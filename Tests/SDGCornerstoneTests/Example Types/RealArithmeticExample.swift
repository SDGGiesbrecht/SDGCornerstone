/*
 RealArithmeticExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

struct RealArithmeticExample : RealArithmetic {

    var value: Double

    init(_ value: Double) {
        self.value = value
    }

    // Addable

    static func += (lhs: inout RealArithmeticExample, rhs: RealArithmeticExample) {
        lhs.value += rhs.value
    }

    // Comparable

    static func < (lhs: RealArithmeticExample, rhs: RealArithmeticExample) -> Bool {
        return lhs.value < rhs.value
    }

    // Equatable

    static func == (lhs: RealArithmeticExample, rhs: RealArithmeticExample) -> Bool {
        return lhs.value == rhs.value
    }

    // ExpressibleByFloatLiteral

    init(floatLiteral: Double.FloatLiteralType) {
        value = Double(floatLiteral: floatLiteral)
    }

    // ExpressibleByIntegerLiteral

    init(integerLiteral: Double.IntegerLiteralType) {
        value = Double(integerLiteral)
    }

    // IntegralArithmetic

    // [_Inherit Documentation: SDGCornerstone.IntegralArithmetic.init(int:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    public init(_ int: IntMax) {
        value = Double(int)
    }

    // PointType

    typealias Vector = RealArithmeticExample

    // RationalArithmetic

    static func ÷= (lhs: inout RealArithmeticExample, rhs: RealArithmeticExample) {
        lhs.value ÷= rhs.value
    }

    // RealArithmetic

    static var π: RealArithmeticExample {
        return RealArithmeticExample(Double.π)
    }

    static var e: RealArithmeticExample {
        return RealArithmeticExample(Double.e)
    }

    mutating func formLogarithm(toBase base: RealArithmeticExample) {
        value.formLogarithm(toBase: base.value)
    }

    static func sin(_ angle: Angle<RealArithmeticExample>) -> RealArithmeticExample {
        return RealArithmeticExample(Double.sin(angle.inRadians.value.rad))
    }

    static func arctan(_ tangent: RealArithmeticExample) -> Angle<RealArithmeticExample> {
        return RealArithmeticExample(Double.arctan(tangent.value).inRadians).rad
    }

    // Strideable

    typealias Stride = Vector

    // Subtractable

    static func −= (lhs: inout RealArithmeticExample, rhs: RealArithmeticExample) {
        lhs.value −= rhs.value
    }

    // WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    public init(_ uInt: UIntMax) {
        value = Double(uInt)
    }

    static func ×= (lhs: inout RealArithmeticExample, rhs: RealArithmeticExample) {
        lhs.value ×= rhs.value
    }

    mutating func divideAccordingToEuclid(by divisor: RealArithmeticExample) {
        value.divideAccordingToEuclid(by: divisor.value)
    }

    static func ↑= (lhs: inout RealArithmeticExample, rhs: RealArithmeticExample) {
        lhs.value ↑= rhs.value
    }

    init(randomInRange range: ClosedRange<RealArithmeticExample>, fromRandomizer randomizer: Randomizer) {
        value = Double(randomInRange: range.lowerBound.value ... range.upperBound.value, fromRandomizer: randomizer)
    }
}
