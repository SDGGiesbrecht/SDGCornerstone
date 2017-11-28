/*
 Shell.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

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

        // MARK: - Static Functions

        private static func argumentNeedsQuotationMarks(_ argument: String) -> Bool {
            if argument.contains(" ") {
                return true
            } else {
                return false
            }
        }

        private static func addQuotationMarks(_ argument: String) -> String {
            return "\u{22}" + argument + "\u{22}"
        }

        /// Guarantees that an argument will be quoted exactly once when passed to `run(command:)`.
        ///
        /// Arguments which `Shell` already quotes automatically are not affected by this function, so as not to receive a duplicate set of quotation marks in the end.
        public static func quote(_ argument: String) -> String {
            if Shell.argumentNeedsQuotationMarks(argument) {
                return argument
            } else {
                return Shell.addQuotationMarks(argument)
            }
        }

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
        ///     - redactionList: An optional list of sensitive strings to redact from the printed output. (Redaction is not applied to the return value or thrown error.)
        ///     - alternatePrint: An optional closure to use instead of `print()` to send lines to standard output. This can be used to redirect or preprocess the text intended for standard output. (The closure will receive the redacted version and will never be executed if `silently` is `true`.)
        ///
        /// - Returns: The output of the command.
        ///
        /// - Throws: A `Shell.Error` if the exit code indicates a failure.
        @discardableResult public func run(command: [String], silently: Bool = false, redacting redactionList: [String] = [], alternatePrint: (_ line: String) -> Void = { print($0) }) throws -> String { // [_Exempt from Code Coverage_]

            let silent: Bool
            switch Application.current.mode {
            case .commandLineTool: // [_Exempt from Code Coverage_]
                silent = silently
            case .guiApplication:
                silent = true
            }

            func redact(_ string: String) -> String { // [_Exempt from Code Coverage_]
                var result = string
                let redacted = "[" + String(UserFacingText({ (localization: InterfaceLocalization, _: Void) -> StrictString in // [_Exempt from Code Coverage_]
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada: // [_Exempt from Code Coverage_]
                        return "redacted"
                    case .deutschDeutschland: // [_Exempt from Code Coverage_]
                        return "geschwärzt"
                    case .françaisFrance: // [_Exempt from Code Coverage_]
                        return "caviardé"
                    case .ελληνικάΕλλάδα: // [_Exempt from Code Coverage_]
                        return "λογοκριμμένο"
                    case .עברית־ישראל: // [_Exempt from Code Coverage_]
                        return "צונזר"
                    }
                }).resolved()) + "]"
                for sensitive in redactionList { // [_Exempt from Code Coverage_]
                    result = result.replacingOccurrences(of: sensitive, with: redacted)
                } // [_Exempt from Code Coverage_]
                return result
            }

            // Formatting separation from other output.
            if ¬silent { // [_Exempt from Code Coverage_]
                alternatePrint("")
            }
            defer {
                if ¬silent { // [_Exempt from Code Coverage_]
                    alternatePrint("")
                }
            }

            let commandString = command.map({ (argument: String) -> String in
                if Shell.argumentNeedsQuotationMarks(argument) {
                    return Shell.addQuotationMarks(argument)
                } else {
                    return argument
                }
            }).joined(separator: " ")

            if ¬silent { // [_Exempt from Code Coverage_]
                alternatePrint(redact("$ " + commandString))
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

            func handleInput(pipe: Pipe, stream: inout Data, result: inout String, report: (_ line: String) -> Void) -> Bool {
                let newData = pipe.fileHandleForReading.availableData
                stream.append(newData)

                while let lineEnd = stream.range(of: newLineData) {
                    let line = stream.subdata(in: stream.startIndex ..< lineEnd.lowerBound)
                    stream.removeSubrange(stream.startIndex ..< lineEnd.upperBound)

                    guard let string = try? String(file: line, origin: nil) else {
                        unreachable()
                    }

                    result.append(string + newLine)
                    if ¬silent { // [_Exempt from Code Coverage_]
                        report(redact(string))
                    }
                }

                return ¬newData.isEmpty
            }

            var completeErrorReceived = false
            background.start {
                while handleInput(pipe: standardError, stream: &errorStream, result: &error, report: { FileHandle.standardError.write(($0 + newLine).data(using: .utf8)!) }) {} // [_Exempt from Code Coverage_]
                completeErrorReceived = true
            }

            while handleInput(pipe: standardOutput, stream: &outputStream, result: &output, report: { alternatePrint($0) }) {} // [_Exempt from Code Coverage_]
            while ¬completeErrorReceived {} // [_Exempt from Code Coverage_]

            while shell.isRunning {} // [_Exempt from Code Coverage_]

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
