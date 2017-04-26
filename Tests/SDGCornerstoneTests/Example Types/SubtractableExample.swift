/*
 SubtractableExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

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

struct SubtractableExampleWherePointTypeAndVectorIsSelf : Negatable, PointType, Subtractable {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // AdditiveArithmetic

    static let additiveIdentity = SubtractableExampleWherePointTypeAndVectorIsSelf(0)

    // Equatable

    static func == (lhs: SubtractableExampleWherePointTypeAndVectorIsSelf, rhs: SubtractableExampleWherePointTypeAndVectorIsSelf) -> Bool {
        return lhs.value == rhs.value
    }

    // PointType

    typealias Vector = SubtractableExampleWherePointTypeAndVectorIsSelf

    static func += (lhs: inout SubtractableExampleWherePointTypeAndVectorIsSelf, rhs: Vector) {
        lhs.value += rhs.value
    }

    static func − (lhs: SubtractableExampleWherePointTypeAndVectorIsSelf, rhs: SubtractableExampleWherePointTypeAndVectorIsSelf) -> Vector {
        return SubtractableExampleWherePointTypeAndVectorIsSelf(lhs.value − rhs.value)
    }

    // Subtractable

    static func −= (lhs: inout SubtractableExampleWherePointTypeAndVectorIsSelf, rhs: SubtractableExampleWherePointTypeAndVectorIsSelf) {
        lhs.value −= rhs.value
    }
}
