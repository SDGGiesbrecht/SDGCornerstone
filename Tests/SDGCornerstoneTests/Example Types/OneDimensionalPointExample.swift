/*
 OneDimensionalPointExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct OneDimensionalPointExample : FixedScaleOneDimensionalPoint {

    typealias Value = Int64

    var value: Value

    init(_ value: Value) {
        self.value = value
    }

    // Comparable

    static func < (precedingValue: OneDimensionalPointExample, followingValue: OneDimensionalPointExample) -> Bool {
        return precedingValue.value < followingValue.value
    }

    // Equatable

    static func == (precedingValue: OneDimensionalPointExample, followingValue: OneDimensionalPointExample) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // PointProtocol

    typealias Vector = Value.Stride

    static func += (precedingValue: inout OneDimensionalPointExample, followingValue: Vector) {
        precedingValue.value += followingValue
    }

    static func − (precedingValue: OneDimensionalPointExample, followingValue: OneDimensionalPointExample) -> Vector {
        return precedingValue.value − followingValue.value
    }
}
