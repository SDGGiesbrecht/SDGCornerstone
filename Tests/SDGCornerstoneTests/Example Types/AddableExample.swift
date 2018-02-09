/*
 AddableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    static func += (precedingValue: inout AddableExample, followingValue: AddableExample) {
        precedingValue.value += followingValue.value
    }

    // Equatable

    static func == (precedingValue: AddableExample, followingValue: AddableExample) -> Bool {
        return precedingValue.value == followingValue.value
    }
}

struct AddableExampleWhereStrideableAndStrideIsSelf : Addable, Equatable, SignedNumeric, Strideable, Subtractable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // Addable

    static func += (precedingValue: inout AddableExampleWhereStrideableAndStrideIsSelf, followingValue: AddableExampleWhereStrideableAndStrideIsSelf) {
        precedingValue.value += followingValue.value
    }

    // Equatable

    static func == (precedingValue: AddableExampleWhereStrideableAndStrideIsSelf, followingValue: AddableExampleWhereStrideableAndStrideIsSelf) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // ExpressibleByIntegerLiteral

    init(integerLiteral: Int) {
        self = AddableExampleWhereStrideableAndStrideIsSelf(integerLiteral)
    }

    // SignedNumeric

    internal init?<T>(exactly source: T) where T : BinaryInteger {
        guard let integer = Int(exactly: source) else {
            return nil
        }
        value = integer
    }

    internal var magnitude: Int.Magnitude {
        return value.magnitude
    }

    // func ×
    internal static func * (precedingValue: AddableExampleWhereStrideableAndStrideIsSelf, followingValue: AddableExampleWhereStrideableAndStrideIsSelf) -> AddableExampleWhereStrideableAndStrideIsSelf {
        return AddableExampleWhereStrideableAndStrideIsSelf(precedingValue.value × followingValue.value)
    }

    // func ×=
    internal static func *= (precedingValue: inout AddableExampleWhereStrideableAndStrideIsSelf, followingValue: AddableExampleWhereStrideableAndStrideIsSelf) {
        precedingValue.value ×= followingValue.value
    }

    // Strideable

    func advanced(by n: AddableExampleWhereStrideableAndStrideIsSelf) -> AddableExampleWhereStrideableAndStrideIsSelf {
        return AddableExampleWhereStrideableAndStrideIsSelf(value.advanced(by: n.value))
    }

    func distance(to other: AddableExampleWhereStrideableAndStrideIsSelf) -> AddableExampleWhereStrideableAndStrideIsSelf {
        return AddableExampleWhereStrideableAndStrideIsSelf(value.distance(to: other.value))
    }

    // Subtractable

    static func −= (precedingValue: inout AddableExampleWhereStrideableAndStrideIsSelf, followingValue: AddableExampleWhereStrideableAndStrideIsSelf) {
        precedingValue.value −= followingValue.value
    }
}
