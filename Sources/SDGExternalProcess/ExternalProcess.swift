/*
 ExternalProcess.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))
    // MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))

    import Foundation

    import SDGLogic
    import SDGPersistence
    import SDGLocalization

    /// An external process.
    public final class ExternalProcess {

        // MARK: - Initialization

        /// Creates an instance with the executable at the specified location.
        ///
        /// - Parameters:
        ///     - executable: The location of the executable file.
        public init(at executable: URL) {
            self.executable = executable
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
        ///
        /// - Throws: An `ExternalProcess.Error` if the exit code indicates a failure.
        @discardableResult public func run(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (_ line: String) -> Void = {_ in }) throws -> String { // [_Exempt from Test Coverage_]

            let process = Process()
            process.launchPath = executable.path
            process.arguments = arguments
            if environment ≠ nil {
                process.environment = environment
            }
            if let location = workingDirectory {
                process.currentDirectoryPath = location.path
            }

            let pipe = Pipe()
            process.standardOutput = pipe
            process.standardError = pipe

            process.launch()

            var output = String()
            var stream = Data()

            let newLine = "\n"
            let newLineData = newLine.data(using: String.Encoding.utf8)!

            func read() -> Data? {
                let new = pipe.fileHandleForReading.availableData
                return new.isEmpty ? nil : new
            }

            while let newData = read() {
                    stream.append(newData)

                    while let lineEnd = stream.range(of: newLineData) {
                        let lineData = stream.subdata(in: stream.startIndex ..< lineEnd.lowerBound)
                        stream.removeSubrange(stream.startIndex ..< lineEnd.upperBound)

                        guard let line = try? String(file: lineData, origin: nil) else {
                            unreachable()
                        }

                        output.append(line + newLine)
                        reportProgress(line)
                    }
            }

            while process.isRunning {} // [_Exempt from Test Coverage_]

            if output.hasSuffix(newLine) {
                output.scalars.removeLast()
            }

            let exitCode = process.terminationStatus
            if exitCode == 0 {
                return output
            } else {
                throw Error(code: Int(exitCode), output: output)
            }
        }
    }

#endif
