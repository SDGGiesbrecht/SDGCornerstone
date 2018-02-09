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

    static func == (precedingValue: PointProtocolExample, followingValue: PointProtocolExample) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // PointProtocol

    typealias Vector = Int

    static func += (precedingValue: inout PointProtocolExample, followingValue: Vector) {
        precedingValue.value += followingValue
    }

    static func − (precedingValue: PointProtocolExample, followingValue: PointProtocolExample) -> Vector {
        return precedingValue.value − followingValue.value
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

    static func == (precedingValue: PointProtocolExampleWhereVectorIsSelf, followingValue: PointProtocolExampleWhereVectorIsSelf) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // Hashable

    var hashValue: Int {
        return value
    }

    // PointProtocol

    typealias Vector = PointProtocolExampleWhereVectorIsSelf

    static func += (precedingValue: inout PointProtocolExampleWhereVectorIsSelf, followingValue: Vector) {
        precedingValue.value += followingValue.value
    }

    static func − (precedingValue: PointProtocolExampleWhereVectorIsSelf, followingValue: PointProtocolExampleWhereVectorIsSelf) -> Vector {
        return PointProtocolExampleWhereVectorIsSelf(precedingValue.value − followingValue.value)
    }
}
