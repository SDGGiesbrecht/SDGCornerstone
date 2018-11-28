/*
 BitField.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to BitField.
@inlinable public func testBitFieldConformance<F>(start: F, not: F, other: F, and: F, or: F, exclusiveOr: F, file: StaticString = #file, line: UInt = #line) where F : BitField {
    test(method: (F.bitwiseNot, "bitwiseNot"), of: start, returns: not, file: file, line: line)
    test(mutatingMethod: ({ $0.formBitwiseNot() }, "formBitwiseNot"), of: start, resultsIn: not, file: file, line: line)
    test(method: (F.bitwiseAnd, "bitwiseAnd"), of: start, with: other, returns: and, file: file, line: line)
    test(mutatingMethod: ({ $0.formBitwiseAnd(with: $1) }, "formBitwiseAnd"), of: start, with: other, resultsIn: and, file: file, line: line)
    test(method: (F.bitwiseOr, "bitwiseOr"), of: start, with: other, returns: or, file: file, line: line)
    test(mutatingMethod: ({ $0.formBitwiseOr(with: $1) }, "formBitwiseOr"), of: start, with: other, resultsIn: or, file: file, line: line)
    test(method: (F.bitwiseExclusiveOr, "bitwiseExclusiveOr"), of: start, with: other, returns: exclusiveOr, file: file, line: line)
    test(mutatingMethod: ({ $0.formBitwiseExclusiveOr(with: $1) }, "formBitwiseExclusiveOr"), of: start, with: other, resultsIn: exclusiveOr, file: file, line: line)
}
