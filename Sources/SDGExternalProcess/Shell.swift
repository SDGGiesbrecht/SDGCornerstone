/*
 Shell.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))

import SDGControlFlow
import SDGLogic

/// A command line shell.
public class Shell : TransparentWrapper {

    // MARK: - Static Properties

    /// The default shell.
    public static let `default`: Shell = Shell(at: URL(fileURLWithPath: "/bin/sh"))

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

    /// Creates an instance with the
    ///
    /// - Parameters:
    ///     - executable: The location of the executable file.
    public init(at executable: URL) {
        process = ExternalProcess(at: executable)
    }

    // MARK: - Properties

    private let process: ExternalProcess

    // MARK: - Usage

    /// Runs a command.
    ///
    /// - Parameters:
    ///     - command: An array representing the command and its arguments. Each element in the array is a separate argument. Quoting of arguments with spaces is handled automatically.
    ///     - workingDirectory: Optional. A different working directory to run inside of than that of the current process.
    ///     - environment: Optional. A different environment to use instead of that of the current process.
    ///     - autoquote: Whether or not to automatically quote arguments. Defaults to `true`.
    ///     - reportProgress: Optional. A closure to execute for each line of output as it is received.
    ///     - line: The line of output.
    ///
    /// - Returns: The output of the command.
    ///
    /// - Throws: An `ExternalProcess.Error` if the exit code indicates a failure.
    @discardableResult public func run(command: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, autoquote: Bool = true, reportProgress: (_ line: String) -> Void = {_ in }) throws -> String { // @exempt(from: tests)

        let commandString = command.map({ (argument: String) -> String in
            if autoquote ∧ Shell.argumentNeedsQuotationMarks(argument) {
                return Shell.addQuotationMarks(argument)
            } else {
                return argument
            }
        }).joined(separator: " ") // @exempt(from: tests) False result in Xcode 9.3.

        reportProgress("$ " + commandString)

        return try process.run(["\u{2D}c", commandString], in: workingDirectory, with: environment) {
            reportProgress($0)
        }
    }

    // MARK: - TransparentWrapper

    // #documentation(SDGCornerstone.TransparentWrapper.wrapped)
    /// The wrapped instance.
    public var wrappedInstance: Any {
        return process
    }
}

#endif
