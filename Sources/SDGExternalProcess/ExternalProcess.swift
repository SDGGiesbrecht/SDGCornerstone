/*
 ExternalProcess.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))

  // #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    import Foundation

    import SDGControlFlow
    import SDGLogic
    import SDGPersistence
    import SDGLocalization

    /// An external process.
    public final class ExternalProcess: TextualPlaygroundDisplay {

      // MARK: - Initialization

      /// Creates an instance with the executable at the specified location.
      ///
      /// - Parameters:
      ///     - executable: The location of the executable file.
      public init(at executable: URL) {
        self.executable = executable
      }

      /// Creates an instance by searching the system for the exectutable.
      ///
      /// - Parameters:
      ///     - locations: A list of locations to search. They will be tried in order.
      ///     - commandName: A name to try with the default shell’s `which` command (`where` on Windows). This will be tried after the provided search list.
      ///     - validate: A closure to validate any located executables. Return `true` to accept it. Return `false` to reject it and continue searching. This could be done if, for example, the executable is an incompatible version.
      ///     - process: An executable to validate. Its existence and executability have already been verified.
      public convenience init?<S>(
        searching locations: S,
        commandName: String?,
        validate: (_ process: ExternalProcess) -> Bool
      ) where S: Sequence, S.Element == URL {
        let adjustedLocations = locations
          .lazy.map { FileManager.default.existingRepresentation(of: $0) }

        func checkLocation(_ location: URL, validate: (ExternalProcess) -> Bool) -> Bool {
          var isDirectory: ObjCBool = false
          if ¬FileManager.default.fileExists(atPath: location.path, isDirectory: &isDirectory) {
            return false
          }
          if isDirectory.boolValue {
            return false
          }
          if ¬FileManager.default.isExecutableFile(atPath: location.path) {
            return false
          }
          let possible = ExternalProcess(at: location)
          if ¬validate(possible) {
            return false
          }
          return true
        }

        for location in adjustedLocations {
          if checkLocation(location, validate: validate) {
            self.init(at: location)  // @exempt(from: tests) False coverage result in Xcode 10.1.
            return
          }
        }

        let searchCommand: String
        #if os(Windows)
          searchCommand = "where"
        #else
          searchCommand = "which"
        #endif
        if let name = commandName,
          let searchResult = try? Shell.default.run(command: [searchCommand, name]).get()
        {  // @exempt(from: tests) Unreachable from CentOS.
          let locations: [String]
          #if os(Windows)
            // “where” reports several paths; newlines are invalid
            locations = searchResult.lines.map({ String($0.line) })
          #else
            // “which” reports a single path; newlines are valid
            locations = [searchResult]
          #endif
          for location in locations.lazy.map({ URL(fileURLWithPath: $0) }) {
            if checkLocation(location, validate: validate) {
              self.init(at: location)
              return
            }
          }
        }

        // Fall back to searching PATH manually, because some Linux flavours lack “which”.
        if let name = commandName,
          let path = ProcessInfo.processInfo.environment["PATH"]
        {
          for entry in path.components(separatedBy: ":") as [String] {
            let directory = URL(fileURLWithPath: entry)
            #if os(Windows)
              let executableName = "\(name).exe"
            #else
              let executableName = name
            #endif
            let possibleExecutable = directory.appendingPathComponent(executableName)
            if checkLocation(possibleExecutable, validate: validate) {
              self.init(at: possibleExecutable)  // @exempt(from: tests)
              return
            }
          }
        }

        return nil
      }

      // MARK: - Properties

      /// The location of the executable file.
      public let executable: URL

      /// Runs the executable with the specified arguments and returns the output.
      ///
      /// - Parameters:
      ///     - arguments: The arguments.
      ///     - workingDirectory: Optional. A different working directory to run inside of than that of the current process.
      ///     - environment: Optional. A different environment to use instead of that of the current process.
      ///     - reportProgress: Optional. A closure to execute for each line of output as it is received.
      ///     - line: The line of output.
      ///
      /// - Returns: The entire output.
      @discardableResult public func run(
        _ arguments: [String],
        in workingDirectory: URL? = nil,
        with environment: [String: String]? = nil,
        reportProgress: (_ line: String) -> Void = { _ in }
      ) -> Result<String, ExternalProcess.Error> {
        #warning("Debugging...")
        print("executable:")
        print(executable.absoluteString)
        print(executable.pathComponents)
        print("arguments: \(arguments)")

        let process = Process()

        #if os(macOS)
          if #available(macOS 10.13, *),  // @exempt(from: unicode)
            ¬legacyMode
          {
            process.executableURL = executable
          } else {
            process.launchPath = executable.path
          }
        #else
          process.executableURL = executable
          #warning("Debugging...")
          process.executableURL = URL(fileURLWithPath: #"C:\Windows\System32\cmd.exe"#)
        #endif

        process.arguments = arguments
        #warning("Debugging...")
        process.arguments = ["/c", "where", "git"]
        if environment ≠ nil {
          process.environment = environment
        }

        if let location = workingDirectory {
          #if os(macOS)
            if #available(macOS 10.13, *),  // @exempt(from: unicode)
              ¬legacyMode
            {
              process.currentDirectoryURL = location
            } else {
              process.currentDirectoryPath = location.path
            }
          #else
            process.currentDirectoryURL = location
          #endif
        }

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        process.qualityOfService = Thread.current.qualityOfService

        do {
          #if os(macOS)
            if #available(macOS 10.13, *),  // @exempt(from: unicode)
              ¬legacyMode
            {
              try process.run()
            } else {
              _ = try executable.checkResourceIsReachable()
              process.launch()
            }
          #else
            try process.run()
          #endif
        } catch {
          return .failure(.foundationError(error))
        }

        var output = String()
        var stream = Data()

        let newLine = "\n"
        let newLineData = newLine.data(using: String.Encoding.utf8)!

        func read() -> Data? {
          let new = pipe.fileHandleForReading.availableData
          return new.isEmpty ? nil : new
        }

        var end = false
        while ¬end {
          purgingAutoreleased {
            guard let newData = read() else {
              end = true
              return
            }
            stream.append(newData)

            while let lineEnd = stream.range(of: newLineData) {
              let lineData = stream.subdata(in: (..<lineEnd.lowerBound).relative(to: stream))
              stream.removeSubrange(..<lineEnd.upperBound)

              guard let line = try? String(file: lineData, origin: nil) else {
                unreachable()
              }

              output.append(line + newLine)
              reportProgress(line)
            }
          }
        }

        while process.isRunning {}  // @exempt(from: tests)

        if output.scalars.last == "\n" {
          output.scalars.removeLast()
        }
        if output.scalars.last == "\r" {  // @exempt(from: tests) Windows only.
          output.scalars.removeLast()
        }

        let exitCode = process.terminationStatus
        if exitCode == 0 {
          return .success(output)
        } else {
          return .failure(.processError(code: Int(exitCode), output: output))
        }
      }

      // MARK: - CustomStringConvertible

      public var description: String {
        return executable.path
      }
    }
  #endif

#endif
