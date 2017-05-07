/*
 Unreachable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Unreachable Code Paths

/// Throws a precondition failure indicating that the code path in which it is called is thought to be unreachable.
///
/// This is intended for use only when there is no forseable way for code to reach a particular path; when code might be reached by disobeying preconditions, provide a more specific description with `preconditionFailure(_:)` instead.
///
/// - Parameters:
///     - function: The function. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func unreachable(function: String = #function, file: String = #file, line: Int = #line, column: Int = #column) -> Never {
    preconditionFailure("Something is being used in a way that violates preconditions. Line \(line) (column \(column)) of “\(function)” in “\(file)” ought to be unreachable.")
}
