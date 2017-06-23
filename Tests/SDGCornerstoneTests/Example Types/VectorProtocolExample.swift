/*
 VectorProtocolExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct VectorProtocolExample : VectorProtocol {

    var value: Double

    init(_ value: Double) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout VectorProtocolExample, rhs: VectorProtocolExample) {
        lhs.value += rhs.value
    }

    // AdditiveArithmetic

    static var additiveIdentity: VectorProtocolExample {
        return VectorProtocolExample(0)
    }

    // Equatable

    static func == (lhs: VectorProtocolExample, rhs: VectorProtocolExample) -> Bool {
        return lhs.value == rhs.value
    }

    // Hashable

    var hashValue: Int {
        return value.hashValue
    }

    // VectorProtocol

    typealias Scalar = Double

    static func ×= (lhs: inout VectorProtocolExample, rhs: Scalar) {
        lhs.value ×= rhs
    }

    static func ÷= (lhs: inout VectorProtocolExample, rhs: Scalar) {
        lhs.value ÷= rhs
    }

    // Subtractable

    static func −= (lhs: inout VectorProtocolExample, rhs: VectorProtocolExample) {
        lhs.value −= rhs.value
    }
}
