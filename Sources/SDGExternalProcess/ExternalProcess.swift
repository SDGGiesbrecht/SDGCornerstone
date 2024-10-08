/*
 ExternalProcess.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGPersistence
import SDGLocalization

/// An external process.
public struct ExternalProcess: TextualPlaygroundDisplay {

  // MARK: - Initialization

  /// Creates an instance with the executable at the specified location.
  ///
  /// - Parameters:
  ///   - executable: The location of the executable file.
  public init(at executable: URL) {
    self.executable = executable
  }

  /// Creates an instance by searching the system for the exectutable.
  ///
  /// - Parameters:
  ///   - locations: A list of locations to search. They will be tried in order.
  ///   - commandName: A name to try with the default shell’s `which` command (`where` on Windows). This will be tried after the provided search list.
  ///   - validate: A closure to validate any located executables. Return `true` to accept it. Return `false` to reject it and continue searching. This could be done if, for example, the executable is an incompatible version.
  public init?<S>(
    searching locations: S,
    commandName: String?,
    validate: (_ process: ExternalProcess) -> Bool
  ) where S: Sequence, S.Element == URL {
    let adjustedLocations = locations
      .lazy.map { location -> URL in
        #if PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
          return location
        #else
          return FileManager.default.existingRepresentation(of: location)
        #endif
      }

    func checkLocation(_ location: URL, validate: (ExternalProcess) -> Bool) -> Bool {
      #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
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
      #endif  // @exempt(from: tests) Unreachable on tvOS, etc.
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

    #if !PLATFORM_LACKS_FOUNDATION_PROCESS
      let searchCommand: String
      #if os(Windows)
        searchCommand = "where"
      #else
        searchCommand = "which"
      #endif
      if let name = commandName,
        let searchResult = try? Shell.default.run(
          command: [searchCommand, name],
          ignoreStandardError: true
        ).get()
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
    #endif

    // Fall back to searching PATH manually, because some Linux flavours lack “which”.
    if let name = commandName,
      let path = ProcessInfo.processInfo.environment["PATH"]
    {
      let separator: String
      #if os(Windows)
        separator = ";"
      #else
        separator = ":"
      #endif
      for entry in path.components(separatedBy: separator) as [String] {
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

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Runs the executable with the specified arguments and returns the output.
    ///
    /// - Parameters:
    ///   - arguments: The arguments.
    ///   - workingDirectory: Optional. A different working directory to run inside of than that of the current process.
    ///   - environment: Optional. A different environment to use instead of that of the current process.
    ///   - ignoreStandardError: Optional. If `true`, standard error will be excluded from the output. The default is `false`.
    ///   - reportProgress: Optional. A closure to execute for each line of output as it is received.
    ///
    /// - Returns: The entire output.
    @discardableResult public func run(
      _ arguments: [String],
      in workingDirectory: URL? = nil,
      with environment: [String: String]? = nil,
      ignoreStandardError: Bool = false,
      reportProgress: (_ line: String) -> Void = { _ in }
    ) -> Result<String, ExternalProcess.Error> {

      let process = Process()
      process.executableURL = executable

      process.arguments = arguments
      if environment ≠ nil {
        process.environment = environment
      }

      if let location = workingDirectory {
        process.currentDirectoryURL = location
      }

      let pipe = Pipe()
      process.standardOutput = pipe
      if ignoreStandardError {
        process.standardError = FileHandle.nullDevice
      } else {
        process.standardError = pipe
      }

      process.qualityOfService = Thread.current.qualityOfService

      do {
        try process.run()
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
  #endif

  // MARK: - CustomStringConvertible

  public var description: String {
    return executable.path
  }
}
