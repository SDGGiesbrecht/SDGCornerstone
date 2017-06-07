/*
 CodingError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Coding Errors

/// Throws a precondition failure indicating that the primitive method in which it is called has not been overridden.
///
/// - Parameters:
///     - method: The method. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func primitiveMethod(_ method: String = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        switch localization {
        case .englishCanada:
            return StrictString("The primitive method “\(method)” has not been overridden.")
        }
    }), file: file, line: line)
}

/// Throws a precondition failure indicating that the code path in which it is called is thought to be unreachable.
///
/// This is intended for use only when there is no forseable way for code to reach a particular path; when code might be reached by disobeying preconditions, provide a more specific description with `preconditionFailure(_:)` instead.
///
/// - Parameters:
///     - function: The function. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
///     - column: The column number. (Provided by default.)
public func unreachable(function: String = #function, file: StaticString = #file, line: UInt = #line, column: UInt = #column) -> Never {
    preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        switch localization {
        case .englishCanada:
            return StrictString("Something is being used in a way that violates preconditions. Line \(line) (column \(column)) of “\(function)” in “\(file)” ought to be unreachable.")
        }
    }), file: file, line: line)
}

private func unimplementedMessage(function: StaticString, file: StaticString, line: UInt) -> String { // [_Exempt from Code Coverage_]
    return String(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Code Coverage_]
        switch localization {
        case .englishCanada:
            return StrictString("\(function) has not been implemented yet. (\(file), Line \(line))")
        }
    }).resolved())
}

/// Prints a warning that the method in which it is called has no real implementation yet.
///
/// This can be used during development to automatically provide a reminder. The distinct name can also be easily detected by validation scripts. It should never occur in code intended for release.
///
/// - Parameters:
///     - function: The function. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func notImplementedYet(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) { // [_Exempt from Code Coverage_]
    print(unimplementedMessage(function: function, file: file, line: line))
}

/// Throws a precondition failure indicating that the method in which it is called has no real implementation yet.
///
/// This can be used during development to automatically provide a more detailed error description. The distinct name can also be easily detected by validation scripts. It should never occur in code intended for release.
///
/// - Parameters:
///     - function: The function. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func notImplementedYetAndCannotReturn(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    preconditionFailure(unimplementedMessage(function: function, file: file, line: line))
}

/// Checks a necessary condition for making forward progress.
///
/// - Parameters:
///     - condition: A closure that performs the check.
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func precondition<L>(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> UserFacingText<L, Void>, file: StaticString = #file, line: UInt = #line) {
    Swift.precondition(condition, String(message().resolved()), file: file, line: line)
}

/// Indicates that a precondition was violated.
///
/// - Parameters:
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func preconditionFailure<L>(_ message: @autoclosure () -> UserFacingText<L, Void>, file: StaticString = #file, line: UInt = #line) -> Never {
    Swift.preconditionFailure(String(message().resolved()), file: file, line: line)
}

/// Performs an internal sanity check.
///
/// - Parameters:
///     - condition: A closure that performs the check.
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func assert<L>(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> UserFacingText<L, Void>, file: StaticString = #file, line: UInt = #line) {
    Swift.assert(condition, String(message().resolved()), file: file, line: line)
}

/// Indicates that an internal sanity check failed.
///
/// - Parameters:
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func assertionFailure<L>(_ message: @autoclosure () -> UserFacingText<L, Void>, file: StaticString = #file, line: UInt = #line) {
    Swift.assertionFailure(String(message().resolved()), file: file, line: line)
}

/// Unconditionally prints a given message and stops execution.
///
/// - Parameters:
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func fatalError<L>(_ message: @autoclosure () -> UserFacingText<L, Void>, file: StaticString = #file, line: UInt = #line) -> Never {
    Swift.fatalError(String(message().resolved()), file: file, line: line)
}
