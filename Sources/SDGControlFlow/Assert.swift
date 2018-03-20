/*
 Assert.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_versioned internal func list(_ localizations: (_APILocalization) -> String) -> String { // [_Exempt from Test Coverage_]
    var included: Set<String> = []
    let result = _APILocalization.cases.map(localizations).filter { (message) in // [_Exempt from Test Coverage_]
        if included.contains(message) { // [_Exempt from Test Coverage_]
            return false
        } else { // [_Exempt from Test Coverage_]
            included.insert(message)
            return true
        }
    }
    return "\n" + result.joined(separator: "\n") + "\n"
}

/// :nodoc:
public func _primitiveMethodMessage(for method: String) -> (_APILocalization) -> String {
    return { (localization: _APILocalization) -> String in // [_Exempt from Test Coverage_]
        switch localization {
        case .englishCanada: // [_Exempt from Test Coverage_]
            return "The primitive method “\(method)” has not been overridden."
        }
    }
}
/// :nodoc:
public func _primitiveMethod(_ method: String = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    _preconditionFailure(_primitiveMethodMessage(for: method), file: file, line: line)
}

/// :nodoc:
public func _unreachableMessage(function: String, file: StaticString, line: UInt, column: UInt) -> (_APILocalization) -> String {
    return { (localization: _APILocalization) -> String in // [_Exempt from Test Coverage_]
        switch localization {
        case .englishCanada:
            return "Something is being used in a way that violates preconditions. Line \(line) (column \(column)) of “\(function)” in “\(file)” ought to be unreachable."
        }
    }
}
/// :nodoc:
public func _unreachable(function: String = #function, file: StaticString = #file, line: UInt = #line, column: UInt = #column) -> Never {
    _preconditionFailure(_unreachableMessage(function: function, file: file, line: line, column: column), file: file, line: line)
}

/// :nodoc:
@_inlineable public func _assert(_ condition: @autoclosure () -> Bool, _ message: (_APILocalization) -> String, file: StaticString = #file, line: UInt = #line) {
    Swift.assert(condition, list(message), file: file, line: line)
}

/// :nodoc:
public func _preconditionFailure(_ message: (_APILocalization) -> String, file: StaticString = #file, line: UInt = #line) -> Never {
    Swift.preconditionFailure(list(message), file: file, line: line)
}
