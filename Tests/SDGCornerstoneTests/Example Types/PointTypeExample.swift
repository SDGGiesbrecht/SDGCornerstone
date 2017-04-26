/*
 PointTypeExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct PointTypeExample : PointType {

    var value: UInt

    init(_ value: UInt) {
        self.value = value
    }

    // Equatable

    static func == (lhs: PointTypeExample, rhs: PointTypeExample) -> Bool {
        return lhs.value == rhs.value
    }

    // PointType

    typealias Vector = Int

    static func += (lhs: inout PointTypeExample, rhs: Vector) {
        lhs.value += rhs
    }

    static func − (lhs: PointTypeExample, rhs: PointTypeExample) -> Vector {
        return lhs.value − rhs.value
    }
}

struct PointTypeExampleWhereVectorIsSelf : Negatable, PointType {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // AdditiveArithmetic

    static let additiveIdentity = PointTypeExampleWhereVectorIsSelf(0)

    // Equatable

    static func == (lhs: PointTypeExampleWhereVectorIsSelf, rhs: PointTypeExampleWhereVectorIsSelf) -> Bool {
        return lhs.value == rhs.value
    }

    // PointType

    typealias Vector = PointTypeExampleWhereVectorIsSelf

    static func += (lhs: inout PointTypeExampleWhereVectorIsSelf, rhs: Vector) {
        lhs.value += rhs.value
    }

    static func − (lhs: PointTypeExampleWhereVectorIsSelf, rhs: PointTypeExampleWhereVectorIsSelf) -> Vector {
        return PointTypeExampleWhereVectorIsSelf(lhs.value − rhs.value)
    }
}
