/*
 SubtractableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct SubtractableExample : Equatable, Subtractable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // Addable

    static func += (precedingValue: inout SubtractableExample, followingValue: SubtractableExample) {
        precedingValue.value += followingValue.value
    }

    // Equatable

    static func == (precedingValue: SubtractableExample, followingValue: SubtractableExample) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // Subtractable

    static func −= (precedingValue: inout SubtractableExample, followingValue: SubtractableExample) {
        precedingValue.value −= followingValue.value
    }
}

struct SubtractableExampleWherePointProtocolAndVectorIsSelf : Negatable, PointProtocol, Subtractable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // AdditiveArithmetic

    static let additiveIdentity = SubtractableExampleWherePointProtocolAndVectorIsSelf(0)

    // Equatable

    static func == (precedingValue: SubtractableExampleWherePointProtocolAndVectorIsSelf, followingValue: SubtractableExampleWherePointProtocolAndVectorIsSelf) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // Hashable

    var hashValue: Int {
        return value.hashValue
    }

    // PointProtocol

    typealias Vector = SubtractableExampleWherePointProtocolAndVectorIsSelf

    static func += (precedingValue: inout SubtractableExampleWherePointProtocolAndVectorIsSelf, followingValue: Vector) {
        precedingValue.value += followingValue.value
    }

    static func − (precedingValue: SubtractableExampleWherePointProtocolAndVectorIsSelf, followingValue: SubtractableExampleWherePointProtocolAndVectorIsSelf) -> Vector {
        return SubtractableExampleWherePointProtocolAndVectorIsSelf(precedingValue.value − followingValue.value)
    }

    // Subtractable

    static func −= (precedingValue: inout SubtractableExampleWherePointProtocolAndVectorIsSelf, followingValue: SubtractableExampleWherePointProtocolAndVectorIsSelf) {
        precedingValue.value −= followingValue.value
    }
}
