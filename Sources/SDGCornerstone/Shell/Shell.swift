/*
 Shell.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))

    import Foundation

    /// A command line shell.
    public struct Shell {

        // MARK: - Static Properties

        /// The default shell.
        public static let `default` = Shell(launchPath: "/bin/sh")

        // MARK: - Initialization

        /// Creates a shell using the specified launch path.
        ///
        /// - Parameters:
        ///     - launchPath: The launch path.
        public init(launchPath: String) {
            self.launchPath = launchPath
        }

        // MARK: - Properties

        private let launchPath: String

        // MARK: - Usage

        /// Runs a command.
        ///
        /// - Parameters:
        ///     - command: An array representing the command and its arguments. Each element in the array is a separate argument. Quoting of arguments with spaces is handled automatically.
        ///     - silently: If `false` (the default), the command and its output will be printed to standard out. If `true`, nothing will be sent to standard out. This argument is ignored in GUI applications, where this method is always silent.
        ///     - redactionList: An optional list of sensitive strings to redact from the printed output. (Redaction is not applied to the return value.)
        ///
        /// - Returns: The output of the command.
        ///
        /// - Throws: A `Shell.Error` if the exit code indicates a failure.
        @discardableResult public func run(command: [String], silently: Bool = false, redacting redactionList: [String] = []) throws -> String {

            let silent: Bool
            switch Application.current.mode {
            case .commandLineTool: // [_Exempt from Code Coverage_]
                silent = silently
            case .guiApplication:
                silent = true
            }

            func redact(_ string: String) -> String {
                var result = string
                let redacted = "[" + String(UserFacingText({ (localization: ContentLocalization, _: Void) -> StrictString in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "redacted"
                    case .deutschDeutschland:
                        return "geschwärzt"
                    case .françaisFrance:
                        return "caviardé"
                    case .ελληνικάΕλλάδα:
                        return "λογοκριμμένο"
                    case .עברית־ישראל:
                        return "צונזר"
                    }
                }).resolved()) + "]"
                for sensitive in redactionList {
                    result = result.replacingOccurrences(of: sensitive, with: redacted)
                }
                return result
            }

            // Formatting separation from other output.
            if ¬silent { // [_Exempt from Code Coverage_]
                print("")
            }
            defer {
                if ¬silent { // [_Exempt from Code Coverage_]
                    print("")
                }
            }

            let commandString = command.map({ (argument: String) -> String in
                if argument.contains(" ") {
                    return "\u{22}" + argument + "\u{22}"
                } else {
                    return argument
                }
            }).joined(separator: " ")

            if ¬silent { // [_Exempt from Code Coverage_]
                print(redact("$ " + commandString))
            }

            let shell = Process()
            shell.launchPath = launchPath
            shell.arguments = ["\u{2D}c", commandString]

            let standardOutput = Pipe()
            shell.standardOutput = standardOutput
            let standardError = Pipe()
            shell.standardError = standardError

            shell.launch()

            var output = String()
            var outputStream = Data()
            var error = String()
            var errorStream = Data()

            let newLine = "\n"
            let newLineData = newLine.data(using: String.Encoding.utf8)!
            func handleInput(pipe: Pipe, stream: inout Data, result: inout String, report: (_ line: String) -> Void) {
                stream.append(pipe.fileHandleForReading.availableData)

                while let lineEnd = stream.range(of: newLineData) {
                    let line = stream.subdata(in: stream.startIndex ..< lineEnd.lowerBound)
                    stream.removeSubrange(stream.startIndex ..< lineEnd.upperBound)

                    guard let string = try? String(file: line, origin: nil) else {
                        unreachable()
                    }

                    result.append(string + newLine)
                    if ¬silent { // [_Exempt from Code Coverage_]
                        report(string)
                    }
                }
            }
            func readProgress() {
                handleInput(pipe: standardOutput, stream: &outputStream, result: &output, report: { (line: String) -> Void in // [_Exempt from Code Coverage_]
                    print(redact(line))
                })
                handleInput(pipe: standardError, stream: &errorStream, result: &error, report: { (line: String) -> Void in // [_Exempt from Code Coverage_]
                    FileHandle.standardError.write((redact(line) + newLine).data(using: .utf8)!)
                })
            }

            while shell.isRunning {
                readProgress()
            }
            readProgress()

            if output.hasSuffix(newLine) {
                output.scalars.removeLast()
            }
            if error.hasSuffix(newLine) {
                error.scalars.removeLast()
            }

            let exitCode = shell.terminationStatus
            if exitCode == 0 {
                return output
            } else {
                throw Error(code: Int(exitCode), description: error, output: output)
            }
        }
    }

#endif
