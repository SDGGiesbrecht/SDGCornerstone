/*
 Assert.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_transparent @_versioned internal func list(_ localizations: (_APILocalization) -> String) -> String {
    var included: Set<String> = []
    let result = _APILocalization.cases.map(localizations).filter { (message) in
        if included.contains(message) {
            return false
        } else {
            included.insert(message)
            return true
        }
    }
    return "\n" + result.joined(separator: "\n") + "\n"
}

/// :nodoc:
@_transparent public func _assert(_ condition: @autoclosure () -> Bool, _ message: (_APILocalization) -> String, file: StaticString = #file, line: UInt = #line) {
    Swift.assert(condition, list(message), file: file, line: line)
}

/// :nodoc:
@_transparent public func _preconditionFailure(_ message: (_APILocalization) -> String, file: StaticString = #file, line: UInt = #line) -> Never {
    Swift.preconditionFailure(list(message), file: file, line: line)
}
