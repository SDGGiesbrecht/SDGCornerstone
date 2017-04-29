/*
 RationalNumberTypeExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct RationalNumberTypeExample : RationalNumberType {

    var value: Double

    init(_ value: Double) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value += rhs.value
    }

    // Comparable

    static func < (lhs: RationalNumberTypeExample, rhs: RationalNumberTypeExample) -> Bool {
        return lhs.value < rhs.value
    }

    // Equatable

    static func == (lhs: RationalNumberTypeExample, rhs: RationalNumberTypeExample) -> Bool {
        return lhs.value == rhs.value
    }

    // ExpressibleByFloatLiteral

    init(floatLiteral: Double.FloatLiteralType) {
        value = Double(floatLiteral: floatLiteral)
    }

    // IntegralArithmetic

    public init(_ int: IntMax) {
        value = Double(int)
    }

    // PointType

    typealias Vector = RationalNumberTypeExample

    // RationalArithmetic

    static func ÷= (lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value ÷= rhs.value
    }

    // Subtractable

    static func −= (lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value −= rhs.value
    }

    // WholeArithmetic

    public init(_ uInt: UIntMax) {
        value = Double(uInt)
    }

    static func ×= (lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value ×= rhs.value
    }

    mutating func divideAccordingToEuclid(by divisor: RationalNumberTypeExample) {
        value.divideAccordingToEuclid(by: divisor.value)
    }

    init(randomInRange range: ClosedRange<RationalNumberTypeExample>, fromRandomizer randomizer: Randomizer) {
        value = Double(randomInRange: range.lowerBound.value ... range.upperBound.value, fromRandomizer: randomizer)
    }
}
