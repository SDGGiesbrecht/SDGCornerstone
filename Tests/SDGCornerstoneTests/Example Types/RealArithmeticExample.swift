/*
 RealArithmeticExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct RealArithmeticExample : RandomizableNumber, RealArithmetic, TextConvertibleNumber {

    var value: FloatMax

    // Addable

    static func += (precedingValue: inout RealArithmeticExample, followingValue: RealArithmeticExample) {
        precedingValue.value += followingValue.value
    }

    // Comparable

    static func < (precedingValue: RealArithmeticExample, followingValue: RealArithmeticExample) -> Bool {
        return precedingValue.value < followingValue.value
    }

    // Equatable

    static func == (precedingValue: RealArithmeticExample, followingValue: RealArithmeticExample) -> Bool {
        return precedingValue.value == followingValue.value
    }

    // ExpressibleByFloatLiteral

    init(floatLiteral: FloatMax.FloatLiteralType) {
        value = FloatMax(floatLiteral: floatLiteral)
    }

    // Hashable

    var hashValue: Int {
        return value.hashValue
    }

    // IntegralArithmetic

    public init(_ int: SDGCornerstone.IntMax) {
        value = FloatMax(int)
    }

    // Numeric

    init?<T>(exactly source: T) where T : BinaryInteger {
        guard let result = FloatMax(exactly: source) else {
            return nil
        }
        value = result
    }

    // PointProtocol

    typealias Vector = RealArithmeticExample

    // RationalArithmetic

    init(_ floatingPoint: FloatMax) {
        value = floatingPoint
    }

    static func ÷= (precedingValue: inout RealArithmeticExample, followingValue: RealArithmeticExample) {
        precedingValue.value ÷= followingValue.value
    }

    // RealArithmetic

    static var π: RealArithmeticExample {
        return RealArithmeticExample(FloatMax.π)
    }

    static var e: RealArithmeticExample {
        return RealArithmeticExample(FloatMax.e)
    }

    mutating func formLogarithm(toBase base: RealArithmeticExample) {
        value.formLogarithm(toBase: base.value)
    }

    static func sin(_ angle: Angle<RealArithmeticExample>) -> RealArithmeticExample {
        return RealArithmeticExample(FloatMax.sin(angle.inRadians.value.rad))
    }

    static func arctan(_ tangent: RealArithmeticExample) -> Angle<RealArithmeticExample> {
        return RealArithmeticExample(FloatMax.arctan(tangent.value).inRadians).rad
    }

    // Subtractable

    static func −= (precedingValue: inout RealArithmeticExample, followingValue: RealArithmeticExample) {
        precedingValue.value −= followingValue.value
    }

    // WholeArithmetic

    public init(_ uInt: SDGCornerstone.UIntMax) {
        value = FloatMax(uInt)
    }

    static func ×= (precedingValue: inout RealArithmeticExample, followingValue: RealArithmeticExample) {
        precedingValue.value ×= followingValue.value
    }

    mutating func divideAccordingToEuclid(by divisor: RealArithmeticExample) {
        value.divideAccordingToEuclid(by: divisor.value)
    }

    static func ↑= (precedingValue: inout RealArithmeticExample, followingValue: RealArithmeticExample) {
        precedingValue.value ↑= followingValue.value
    }

    init(randomInRange range: ClosedRange<RealArithmeticExample>, fromRandomizer randomizer: Randomizer) {
        value = FloatMax(randomInRange: range.lowerBound.value ... range.upperBound.value, fromRandomizer: randomizer)
    }
}
