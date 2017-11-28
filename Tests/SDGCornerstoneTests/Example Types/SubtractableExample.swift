/*
 SubtractableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    static func += (lhs: inout SubtractableExample, rhs: SubtractableExample) {
        lhs.value += rhs.value
    }

    // Equatable

    static func == (lhs: SubtractableExample, rhs: SubtractableExample) -> Bool {
        return lhs.value == rhs.value
    }

    // Subtractable

    static func −= (lhs: inout SubtractableExample, rhs: SubtractableExample) {
        lhs.value −= rhs.value
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

    static func == (lhs: SubtractableExampleWherePointProtocolAndVectorIsSelf, rhs: SubtractableExampleWherePointProtocolAndVectorIsSelf) -> Bool {
        return lhs.value == rhs.value
    }

    // Hashable

    var hashValue: Int {
        return value.hashValue
    }

    // PointProtocol

    typealias Vector = SubtractableExampleWherePointProtocolAndVectorIsSelf

    static func += (lhs: inout SubtractableExampleWherePointProtocolAndVectorIsSelf, rhs: Vector) {
        lhs.value += rhs.value
    }

    static func − (lhs: SubtractableExampleWherePointProtocolAndVectorIsSelf, rhs: SubtractableExampleWherePointProtocolAndVectorIsSelf) -> Vector {
        return SubtractableExampleWherePointProtocolAndVectorIsSelf(lhs.value − rhs.value)
    }

    // Subtractable

    static func −= (lhs: inout SubtractableExampleWherePointProtocolAndVectorIsSelf, rhs: SubtractableExampleWherePointProtocolAndVectorIsSelf) {
        lhs.value −= rhs.value
    }
}
