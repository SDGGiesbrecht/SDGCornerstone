/*
 VectorProtocolExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    static func += (precedingValue: inout VectorProtocolExample, followingValue: VectorProtocolExample) {
        precedingValue.value += followingValue.value
    }

    // AdditiveArithmetic

    static var additiveIdentity: VectorProtocolExample {
        return VectorProtocolExample(0)
    }

    // Equatable

    static func == (precedingValue: VectorProtocolExample, followingValue: VectorProtocolExample) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // Hashable

    var hashValue: Int {
        return value.hashValue
    }

    // VectorProtocol

    typealias Scalar = Double

    static func ×= (precedingValue: inout VectorProtocolExample, followingValue: Scalar) {
        precedingValue.value ×= followingValue
    }

    static func ÷= (precedingValue: inout VectorProtocolExample, followingValue: Scalar) {
        precedingValue.value ÷= followingValue
    }

    // Subtractable

    static func −= (precedingValue: inout VectorProtocolExample, followingValue: VectorProtocolExample) {
        precedingValue.value −= followingValue.value
    }
}
