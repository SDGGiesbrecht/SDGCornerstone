/*
 Assert.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@usableFromInline internal func list(_ localizations: (_APILocalization) -> String) -> String { // @exempt(from: tests)
    var included: Set<String> = []
    let result = _APILocalization.allCases.map(localizations).filter { (message) in // @exempt(from: tests)
        if included.contains(message) { // @exempt(from: tests)
            return false
        } else { // @exempt(from: tests)
            included.insert(message)
            return true
        }
    }
    return "\n" + result.joined(separator: "\n") + "\n"
}

public func _primitiveMethodMessage(for method: String) -> (_APILocalization) -> String {
    return { (localization: _APILocalization) -> String in // @exempt(from: tests)
        switch localization {
        case .englishCanada: // @exempt(from: tests)
            return "The primitive method “\(method)” has not been overridden."
        }
    }
}
public func _primitiveMethod(_ method: String = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    _preconditionFailure(_primitiveMethodMessage(for: method), file: file, line: line)
}

public func _unreachableMessage(function: String, file: StaticString, line: UInt, column: UInt) -> (_APILocalization) -> String {
    return { (localization: _APILocalization) -> String in // @exempt(from: tests)
        switch localization {
        case .englishCanada:
            return "Something is being used in a way that violates preconditions. Line \(line) (column \(column)) of “\(function)” in “\(file)” ought to be unreachable."
        }
    }
}
public func _unreachable(function: String = #function, file: StaticString = #file, line: UInt = #line, column: UInt = #column) -> Never {
    _preconditionFailure(_unreachableMessage(function: function, file: file, line: line, column: column), file: file, line: line)
}

@inlinable public func _assert(_ condition: @autoclosure () -> Bool, _ message: (_APILocalization) -> String, file: StaticString = #file, line: UInt = #line) {
    Swift.assert(condition(), list(message), file: file, line: line)
}

public func _preconditionFailure(_ message: (_APILocalization) -> String, file: StaticString = #file, line: UInt = #line) -> Never {
    Swift.preconditionFailure(list(message), file: file, line: line)
}
