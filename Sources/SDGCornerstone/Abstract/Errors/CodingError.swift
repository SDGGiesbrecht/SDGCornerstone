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
public func primitiveMethod(_ method: String = #function) -> Never {
    preconditionFailure("The primitive method “\(method)” has not been overridden.")
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
public func unreachable(function: String = #function, file: String = #file, line: Int = #line, column: Int = #column) -> Never {
    preconditionFailure("Something is being used in a way that violates preconditions. Line \(line) (column \(column)) of “\(function)” in “\(file)” ought to be unreachable.")
}

private func unimplementedMessage(function: String, file: String, line: Int) -> String {
    return "\(function) has not been implemented yet. (\(file), Line \(line))"
}

/// Prints a warning that the method in which it is called has no real implementation yet.
///
/// This can be used during development to automatically provide a reminder. The distinct name can also be easily detected by validation scripts. It should never occur in code intended for release.
///
/// - Parameters:
///     - function: The function. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func notImplementedYet(function: String = #function, file: String = #file, line: Int = #line) {
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
public func notImplementedYetAndCannotReturn(function: String = #function, file: String = #file, line: Int = #line) -> Never {
    preconditionFailure(unimplementedMessage(function: function, file: file, line: line))
}

// precondition
// preconditionFailure

// assert
// assertionFailure

// fatalError
