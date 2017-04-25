/*
 AddableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct AddableExample : Addable, Equatable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout AddableExample, rhs: AddableExample) {
        lhs.value += rhs.value
    }

    // Equatable

    static func == (lhs: AddableExample, rhs: AddableExample) -> Bool {
        return lhs.value == rhs.value
    }
}

struct AddableExampleWhereStrideableAndStrideIsSelf : Addable, Equatable, SignedNumber, Strideable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout AddableExampleWhereStrideableAndStrideIsSelf, rhs: AddableExampleWhereStrideableAndStrideIsSelf) {
        lhs.value += rhs.value
    }

    // Equatable

    static func == (lhs: AddableExampleWhereStrideableAndStrideIsSelf, rhs: AddableExampleWhereStrideableAndStrideIsSelf) -> Bool {
        return lhs.value == rhs.value
    }

    // ExpressibleByIntegerLiteral

    typealias IntegerLiteralType = Int

    init(integerLiteral: IntegerLiteralType) {
        self = AddableExampleWhereStrideableAndStrideIsSelf(integerLiteral)
    }

    // SignedNumber

    static func - (lhs: AddableExampleWhereStrideableAndStrideIsSelf, rhs: AddableExampleWhereStrideableAndStrideIsSelf) -> AddableExampleWhereStrideableAndStrideIsSelf { // Swift.SignedNumber
        return AddableExampleWhereStrideableAndStrideIsSelf(lhs.value − rhs.value)
    }

    // Strideable

    typealias Stride = AddableExampleWhereStrideableAndStrideIsSelf

    func advanced(by n: Stride) -> AddableExampleWhereStrideableAndStrideIsSelf {
        return AddableExampleWhereStrideableAndStrideIsSelf(value.advanced(by: n.value))
    }

    func distance(to other: AddableExampleWhereStrideableAndStrideIsSelf) -> Stride {
        return AddableExampleWhereStrideableAndStrideIsSelf(value.distance(to: other.value))
    }
}
