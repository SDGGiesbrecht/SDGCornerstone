/*
 RationalNumberProtocolExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    static func += (precedingValue: inout RationalNumberProtocolExample, followingValue: RationalNumberProtocolExample) {
        precedingValue.value += followingValue.value
    }

    // Comparable

    static func < (precedingValue: RationalNumberProtocolExample, followingValue: RationalNumberProtocolExample) -> Bool {
        return precedingValue.value < followingValue.value
    }

    // Equatable

    static func == (precedingValue: RationalNumberProtocolExample, followingValue: RationalNumberProtocolExample) -> Bool {
        return precedingValue.value == followingValue.value
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

    init(_ int: SDGCornerstone.IntMax) {
        value = RationalNumber(int)
    }

    // Numeric

    init?<T>(exactly source: T) where T : BinaryInteger {
        guard let result = RationalNumber(exactly: source) else {
            return nil
        }
        value = result
    }

    // PointProtocol

    typealias Vector = RationalNumberProtocolExample

    // RationalArithmetic

    init(_ floatingPoint: FloatMax) {
        value = RationalNumber(floatingPoint)
    }

    static func ÷= (precedingValue: inout RationalNumberProtocolExample, followingValue: RationalNumberProtocolExample) {
        precedingValue.value ÷= followingValue.value
    }

    // RationalNumberProtocol

    func reducedSimpleFraction() -> (numerator: Integer, denominator: Integer) {
        return value.reducedSimpleFraction()
    }

    // Subtractable

    static func −= (precedingValue: inout RationalNumberProtocolExample, followingValue: RationalNumberProtocolExample) {
        precedingValue.value −= followingValue.value
    }

    // WholeArithmetic

    public init(_ uInt: SDGCornerstone.UIntMax) {
        value = RationalNumber(uInt)
    }

    static func ×= (precedingValue: inout RationalNumberProtocolExample, followingValue: RationalNumberProtocolExample) {
        precedingValue.value ×= followingValue.value
    }

    mutating func divideAccordingToEuclid(by divisor: RationalNumberProtocolExample) {
        value.divideAccordingToEuclid(by: divisor.value)
    }

    init(randomInRange range: ClosedRange<RationalNumberProtocolExample>, fromRandomizer randomizer: Randomizer) {
        value = RationalNumber(randomInRange: range.lowerBound.value ... range.upperBound.value, fromRandomizer: randomizer)
    }
}
