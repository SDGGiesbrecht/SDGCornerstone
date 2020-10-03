/*
 Precondition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText

/// Throws a precondition failure indicating that the primitive method in which it is called has not been overridden.
///
/// - Parameters:
///     - method: The method. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func primitiveMethod(
  _ method: String = #function,
  file: StaticString = #fileID,
  line: UInt = #line
) -> Never {
  preconditionFailure(
    UserFacing<StrictString, _APILocalization>({ localization in
      return StrictString(_primitiveMethodMessage(for: method)(localization))
    }),
    file: file,
    line: line
  )
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
public func unreachable(
  function: String = #function,
  file: StaticString = #fileID,
  line: UInt = #line,
  column: UInt = #column
) -> Never {
  preconditionFailure(
    UserFacing<StrictString, _APILocalization>({ localization in
      return StrictString(
        _unreachableMessage(function: function, file: file, line: line, column: column)(
          localization
        )
      )
    }),
    file: file,
    line: line
  )
}

private func unimplementedMessage(function: StaticString, file: StaticString, line: UInt) -> String
{  // @exempt(from: tests)
  return String(
    UserFacing<StrictString, _APILocalization>({ localization in  // @exempt(from: tests)
      switch localization {
      case .englishCanada:  // @exempt(from: tests)
        return "\(function) has not been implemented yet. (\(file), Line \(line.inDigits()))"
      }
    }).resolved()
  )
}

/// Prints a warning that the method in which it is called has no real implementation yet.
///
/// This can be used during development to automatically provide a reminder. The distinct name can also be easily detected by validation scripts. It should never occur in code intended for release.
///
/// - Parameters:
///     - function: The function. (Provided by default.)
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func notImplementedYet(  // @exempt(from: missingImplementation)
  function: StaticString = #function,
  file: StaticString = #fileID,
  line: UInt = #line
) {  // @exempt(from: tests)
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
public func notImplementedYetAndCannotReturn(  // @exempt(from: missingImplementation)
  function: StaticString = #function,
  file: StaticString = #fileID,
  line: UInt = #line
) -> Never {
  preconditionFailure(unimplementedMessage(function: function, file: file, line: line))
}

/// Checks a necessary condition for making forward progress.
///
/// - Parameters:
///     - condition: A closure that performs the check.
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func precondition<L>(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> UserFacing<StrictString, L>,
  file: StaticString = #fileID,
  line: UInt = #line
) {
  Swift.precondition(condition(), String(message().resolved()), file: file, line: line)
}

/// Indicates that a precondition was violated.
///
/// - Parameters:
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func preconditionFailure<L>(
  _ message: @autoclosure () -> UserFacing<StrictString, L>,
  file: StaticString = #fileID,
  line: UInt = #line
) -> Never {
  Swift.preconditionFailure(String(message().resolved()), file: file, line: line)
}

/// Performs an internal sanity check.
///
/// - Parameters:
///     - condition: A closure that performs the check.
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
@inlinable public func assert<L>(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> UserFacing<StrictString, L>,
  file: StaticString = #fileID,
  line: UInt = #line
) {
  Swift.assert(condition(), String(message().resolved()), file: file, line: line)
}

/// Indicates that an internal sanity check failed.
///
/// - Parameters:
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
@inlinable public func assertionFailure<L>(
  _ message: @autoclosure () -> UserFacing<StrictString, L>,
  file: StaticString = #fileID,
  line: UInt = #line
) {
  Swift.assertionFailure(String(message().resolved()), file: file, line: line)
}

/// Unconditionally prints a given message and stops execution.
///
/// - Parameters:
///     - message: A closure that generates a localized message.
///     - file: The file. (Provided by default.)
///     - line: The line number. (Provided by default.)
public func fatalError<L>(
  _ message: @autoclosure () -> UserFacing<StrictString, L>,
  file: StaticString = #fileID,
  line: UInt = #line
) -> Never {
  Swift.fatalError(String(message().resolved()), file: file, line: line)
}
