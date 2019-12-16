/*
 ExternalProcess.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))

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
    ///     - commandName: A name to try with the default shell’s `which` command. This will be tried after the provided search list.
    ///     - validate: A closure to validate any located executables. Return `true` to accept it. Return `false` to reject it and continue searching. This could be done if, for example, the executable is an incompatible version.
    ///     - process: An executable to validate. Its existence and executability have already been verified.
    public convenience init?<S>(
      searching locations: S,
      commandName: String?,
      validate: (_ process: ExternalProcess) -> Bool
    ) where S: Sequence, S.Element == URL {

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

      for location in locations {
        if checkLocation(location, validate: validate) {
          self.init(at: location)  // @exempt(from: tests) False coverage result in Xcode 10.1.
          return
        }
      }

      if let name = commandName,
        let path = try? Shell.default.run(command: ["which", name]).get()
      {
        let location = URL(fileURLWithPath: path)
        if checkLocation(location, validate: validate) {
          self.init(at: location)
          return
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
      #endif

      process.arguments = arguments
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

      #if !os(Linux)  // #workaround(Swift 5.1.3, Linux will gain this property in 5.2.)
        process.qualityOfService = Thread.current.qualityOfService
      #endif

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
        autoreleasepool {
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

      if output.hasSuffix(newLine) {
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
