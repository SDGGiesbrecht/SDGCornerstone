/*
 RationalNumberProtocolExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct RationalNumberProtocolExample : RationalNumberProtocol {

    var value: RationalNumber

    init(_ value: RationalNumber) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout RationalNumberProtocolExample, rhs: RationalNumberProtocolExample) {
        lhs.value += rhs.value
    }

    // Comparable

    static func < (lhs: RationalNumberProtocolExample, rhs: RationalNumberProtocolExample) -> Bool {
        return lhs.value < rhs.value
    }

    // Equatable

    static func == (lhs: RationalNumberProtocolExample, rhs: RationalNumberProtocolExample) -> Bool {
        return lhs.value == rhs.value
    }

    // Hashable

    var hashValue: Int {
        return value.hashValue
    }

    // ExpressibleByFloatLiteral

    init(floatLiteral: RationalNumber.FloatLiteralType) {
        value = RationalNumber(floatLiteral: floatLiteral)
    }

    // IntegralArithmetic

    public init(_ int: IntMax) {
        value = RationalNumber(int)
    }

    // PointProtocol

    typealias Vector = RationalNumberProtocolExample

    // RationalArithmetic

    static func ÷= (lhs: inout RationalNumberProtocolExample, rhs: RationalNumberProtocolExample) {
        lhs.value ÷= rhs.value
    }

    // RationalNumberProtocol

    func reducedSimpleFraction() -> (numerator: Integer, denominator: Integer) {
        return value.reducedSimpleFraction()
    }

    // Subtractable

    static func −= (lhs: inout RationalNumberProtocolExample, rhs: RationalNumberProtocolExample) {
        lhs.value −= rhs.value
    }

    // WholeArithmetic

    public init(_ uInt: UIntMax) {
        value = RationalNumber(uInt)
    }

    static func ×= (lhs: inout RationalNumberProtocolExample, rhs: RationalNumberProtocolExample) {
        lhs.value ×= rhs.value
    }

    mutating func divideAccordingToEuclid(by divisor: RationalNumberProtocolExample) {
        value.divideAccordingToEuclid(by: divisor.value)
    }

    init(randomInRange range: ClosedRange<RationalNumberProtocolExample>, fromRandomizer randomizer: Randomizer) {
        value = RationalNumber(randomInRange: range.lowerBound.value ... range.upperBound.value, fromRandomizer: randomizer)
    }
}
