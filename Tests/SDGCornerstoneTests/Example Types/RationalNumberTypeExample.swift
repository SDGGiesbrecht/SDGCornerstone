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

    typealias Vector = RationalNumberTypeExample

    // RationalArithmetic

    static func ÷= (lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value ÷= rhs.value
    }

    // Strideable

    typealias Stride = Vector

    // Subtractable

    static func −= (lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
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
