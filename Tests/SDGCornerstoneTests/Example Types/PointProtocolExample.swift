/*
 PointProtocolExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct PointProtocolExample : PointProtocol {

    var value: UInt

    init(_ value: UInt) {
        self.value = value
    }

    // Equatable

    static func == (lhs: PointProtocolExample, rhs: PointProtocolExample) -> Bool {
        return lhs.value == rhs.value
    }

    // PointProtocol

    typealias Vector = Int

    static func += (lhs: inout PointProtocolExample, rhs: Vector) {
        lhs.value += rhs
    }

    static func − (lhs: PointProtocolExample, rhs: PointProtocolExample) -> Vector {
        return lhs.value − rhs.value
    }
}

struct PointProtocolExampleWhereVectorIsSelf : Negatable, PointProtocol {

    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    // AdditiveArithmetic

    static let additiveIdentity = PointProtocolExampleWhereVectorIsSelf(0)

    // Equatable

    static func == (lhs: PointProtocolExampleWhereVectorIsSelf, rhs: PointProtocolExampleWhereVectorIsSelf) -> Bool {
        return lhs.value == rhs.value
    }

    // Hashable

    var hashValue: Int {
        return value
    }

    // PointProtocol

    typealias Vector = PointProtocolExampleWhereVectorIsSelf

    static func += (lhs: inout PointProtocolExampleWhereVectorIsSelf, rhs: Vector) {
        lhs.value += rhs.value
    }

    static func − (lhs: PointProtocolExampleWhereVectorIsSelf, rhs: PointProtocolExampleWhereVectorIsSelf) -> Vector {
        return PointProtocolExampleWhereVectorIsSelf(lhs.value − rhs.value)
    }
}
