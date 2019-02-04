/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(iOS) || os(watchOS) || os(tvOS)
/// The member of the `Float` family with the largest bit field.
public typealias FloatMax = Double
#else
/// The member of the `Float` family with the largest bit field.
public typealias FloatMax = Float80
#endif

/// A member of the `Float` family: `Double`, `Float80` or `Float`
public protocol FloatFamily : BinaryFloatingPoint, CustomDebugStringConvertible, LosslessStringConvertible, RealNumberProtocol {
    static func _tgmath_pow(_ x: Self, _ y: Self) -> Self
    static func _tgmath_log(_ x: Self) -> Self
    static func _tgmath_log10(_ x: Self) -> Self
    static func _tgmath_sin(_ x: Self) -> Self
    static func _tgmath_cos(_ x: Self) -> Self
    static func _tgmath_tan(_ x: Self) -> Self
    static func _tgmath_asin(_ x: Self) -> Self
    static func _tgmath_acos(_ x: Self) -> Self
    static func _tgmath_atan(_ x: Self) -> Self
}

extension FloatFamily {

    // MARK: - Negatable

    @inlinable public static prefix func − (operand: Self) -> Self {
        return -operand // @exempt(from: unicode)
    }

    // MARK: - NumericAdditiveArithmetic

    @inlinable public var absoluteValue: Self {
        return abs(self)
    }

    @inlinable public mutating func formAbsoluteValue() {
        self = abs(self)
    }

    // MARK: - RationalArithmetic

    @inlinable public static func ÷ (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue / followingValue // @exempt(from: unicode)
    }

    @inlinable public static func ÷= (precedingValue: inout Self, followingValue: Self) {
        precedingValue /= followingValue // @exempt(from: unicode)
    }

    // MARK: - RealArithmetic

    // #documentation(SDGCornerstone.RealArithmetic.π)
    /// An instance of π.
    @inlinable public static var π: Self {
        return pi
    }

    // #documentation(SDGCornerstone.RealArithmetic.√)
    /// Returns the square root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    @inlinable public static prefix func √ (operand: Self) -> Self {
        return operand.squareRoot()
    }

    // #documentation(SDGCornerstone.RealArithmetic.√=)
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    @inlinable public static postfix func √= (operand: inout Self) {
        operand = operand.squareRoot()
    }

    // #documentation(SDGCornerstone.RealArithmetic.formLogarithm(toBase:))
    /// Sets `self` to its base `base` logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    @inlinable public mutating func formLogarithm(toBase base: Self) {
        // log (a) = log (a) ÷ log (b)
        //    b         x         x
        formNaturalLogarithm()
        self ÷= Self.ln(base)
    }

    // #documentation(SDGCornerstone.RealArithmetic.log(_:))
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    @inlinable public static func log(_ antilogarithm: Self) -> Self {
        return Self._tgmath_log10(antilogarithm)
    }

    // #documentation(SDGCornerstone.RealArithmetic.formCommonLogarithm())
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    @inlinable public mutating func formCommonLogarithm() {
        self = Self.log(self)
    }

    // #documentation(SDGCornerstone.RealArithmetic.ln(_:))
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    @inlinable public static func ln(_ antilogarithm: Self) -> Self {
        return Self._tgmath_log(antilogarithm)
    }

    // #documentation(SDGCornerstone.RealArithmetic.formNaturalLogarithm())
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    @inlinable public mutating func formNaturalLogarithm() {
        self = Self.ln(self)
    }

    // #documentation(SDGCornerstone.RealArithmetic.sin(_:))
    /// Returns the sine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func sin(_ angle: Angle<Self>) -> Self {
        return Self._tgmath_sin(angle.inRadians)
    }

    // #documentation(SDGCornerstone.RealArithmetic.cos(_:))
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func cos(_ angle: Angle<Self>) -> Self {
        return Self._tgmath_cos(angle.inRadians)
    }

    // #documentation(SDGCornerstone.RealArithmetic.tan(_:))
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @inlinable public static func tan(_ angle: Angle<Self>) -> Self {
        return Self._tgmath_tan(angle.inRadians)
    }

    // #documentation(SDGCornerstone.RealArithmetic.arcsin(_:))
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    @inlinable public static func arcsin(_ tangent: Self) -> Angle<Self> {
        return Self._tgmath_asin(tangent).radians
    }

    // #documentation(SDGCornerstone.RealArithmetic.arccos(_:))
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    @inlinable public static func arccos(_ tangent: Self) -> Angle<Self> {
        return Self._tgmath_acos(tangent).radians
    }

    // #documentation(SDGCornerstone.RealArithmetic.arctan(_:))
    /// Returns the arctangent of a value.
    ///
    /// The returned angle will be between −90° and 90°.
    ///
    /// - Parameters:
    ///     - tangent: The tangent.
    @inlinable public static func arctan(_ tangent: Self) -> Angle<Self> {
        return Self._tgmath_atan(tangent).radians
    }

    // MARK: - Subtractable

    // #documentation(SDGCornerstone.Subtractable.−)
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.Subtractable.−=)
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue // @exempt(from: unicode)
    }

    // MARK: - WholeArithmetic

    // #documentation(SDGCornerstone.WholeArithmetic.×)
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue * followingValue // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.×=)
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    @inlinable public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue // @exempt(from: unicode)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:))
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {
        self ÷= divisor
        self.round(.down)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.↑)
    /// Returns the result of the preceding value to the power of the following value.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `followingValue` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `followingValue` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `precedingValue` must be positive, or
    ///     - `followingValue` must be an integer.
    ///
    /// - Parameters:
    ///     - precedingValue: The base.
    ///     - followingValue: The exponent.
    @inlinable public static func ↑ (precedingValue: Self, followingValue: Self) -> Self {
        return Self._tgmath_pow(precedingValue, followingValue)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.↑=)
    /// Modifies the preceding value by exponentiation with the following value.
    ///
    /// - Precondition:
    ///   - If `Self` conforms to `IntegerProtocol`, `followingValue` must be non‐negative.
    ///   - If `Self` conforms to `RationalNumberProtocol`, `followingValue` must be an integer.
    ///   - If `Self` conforms to `RealNumberProtocol`, either
    ///     - `precedingValue` must be positive, or
    ///     - `followingValue` must be an integer.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The exponent.
    @inlinable public static func ↑= (precedingValue: inout Self, followingValue: Self) {
        precedingValue = precedingValue ↑ followingValue
    }

    // #documentation(SDGCornerstone.WholeArithmetic.rounded(_:))
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @inlinable public func rounded(_ rule: RoundingRule) -> Self {
        return roundedAsFloatingPoint(rule)
    }
}

extension FloatingPoint {
    @inlinable internal func roundedAsFloatingPoint(_ rule: FloatingPointRoundingRule) -> Self {
        return rounded(rule)
    }
}

extension Double : FloatFamily {

    // MARK: - FloatFamily

    @inlinable public static func _tgmath_pow(_ x: Double, _ y: Double) -> Double {
        return Foundation.pow(x, y)
    }

    @inlinable public static func _tgmath_log(_ x: Double) -> Double {
        return Foundation.log(x)
    }

    @inlinable public static func _tgmath_log10(_ x: Double) -> Double {
        return Foundation.log10(x)
    }

    @inlinable public static func _tgmath_sin(_ x: Double) -> Double {
        return Foundation.sin(x)
    }

    @inlinable public static func _tgmath_cos(_ x: Double) -> Double {
        return Foundation.cos(x)
    }

    @inlinable public static func _tgmath_tan(_ x: Double) -> Double {
        return Foundation.tan(x)
    }

    @inlinable public static func _tgmath_asin(_ x: Double) -> Double {
        return Foundation.asin(x)
    }

    @inlinable public static func _tgmath_acos(_ x: Double) -> Double {
        return Foundation.acos(x)
    }

    @inlinable public static func _tgmath_atan(_ x: Double) -> Double {
        return Foundation.atan(x)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // #documentation(SDGCornerstone.RealArithmetic.e)
    /// An instance of *e*.
    public static let e: Double = 0x1.5BF0A8B145769p1

    // #documentation(SDGCornerstone.RealArithmetic.floatingPointApproximation)
    /// A floating point approximation.
    @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}

#if canImport(CoreGraphics)

extension CGFloat : FloatFamily {

    // MARK: - CustomDebugStringConvertible

    /// A textual representation of this instance, suitable for debugging.
    @inlinable public var debugDescription: String {
        return NativeType(self).debugDescription
    }

    // MARK: - FloatFamily

    @inlinable public static func _tgmath_pow(_ x: CGFloat, _ y: CGFloat) -> CGFloat {
        return CoreGraphics.pow(x, y)
    }

    @inlinable public static func _tgmath_log(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.log(x)
    }

    @inlinable public static func _tgmath_log10(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.log10(x)
    }

    @inlinable public static func _tgmath_sin(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.sin(x)
    }

    @inlinable public static func _tgmath_cos(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.cos(x)
    }

    @inlinable public static func _tgmath_tan(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.tan(x)
    }

    @inlinable public static func _tgmath_asin(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.asin(x)
    }

    @inlinable public static func _tgmath_acos(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.acos(x)
    }

    @inlinable public static func _tgmath_atan(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.atan(x)
    }

    // MARK: - LosslessStringConvertible

    /// Instantiates an instance of the conforming type from a string representation.
    ///
    /// - Parameters:
    ///     - description: The string representation.
    @inlinable public init?(_ description: String) {
        if let result = NativeType(description) {
            self = CGFloat(result)
        } else {
            return nil
        }
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // #documentation(SDGCornerstone.RealArithmetic.e)
    /// An instance of *e*.
    public static let e: CGFloat = CGFloat(Double.e)

    // #documentation(SDGCornerstone.RealArithmetic.floatingPointApproximation)
    /// A floating point approximation.
    @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(NativeType(self))
    }
}
#endif

#if !(os(iOS) || os(watchOS) || os(tvOS))

extension Float80 : Decodable, Encodable, FloatFamily {

    // MARK: - Decodable

    @inlinable public init(from decoder: Decoder) throws {
        self.init(try Double(from: decoder))
    }

    // MARK: - Encodable

    @inlinable public func encode(to encoder: Encoder) throws {
        // This causes a reduction in precision, but is necessary to preserve compatibility with Double and Float. (Especially when used as FloatMax.) It is also more likely to be forward compatible than other formats if the Standard Library provides this conformance in the future.
        try Double(self).encode(to: encoder)
    }

    // MARK: - FloatFamily

    @inlinable public static func _tgmath_pow(_ x: Float80, _ y: Float80) -> Float80 {
        return Foundation.pow(x, y)
    }

    @inlinable public static func _tgmath_log(_ x: Float80) -> Float80 {
        return Foundation.log(x)
    }

    @inlinable public static func _tgmath_log10(_ x: Float80) -> Float80 {
        return Foundation.log10(x)
    }

    @inlinable public static func _tgmath_sin(_ x: Float80) -> Float80 {
        return Foundation.sin(x)
    }

    @inlinable public static func _tgmath_cos(_ x: Float80) -> Float80 {
        return Foundation.cos(x)
    }

    @inlinable public static func _tgmath_tan(_ x: Float80) -> Float80 {
        return Foundation.tan(x)
    }

    @inlinable public static func _tgmath_asin(_ x: Float80) -> Float80 {
        return Foundation.asin(x)
    }

    @inlinable public static func _tgmath_acos(_ x: Float80) -> Float80 {
        return Foundation.acos(x)
    }

    @inlinable public static func _tgmath_atan(_ x: Float80) -> Float80 {
        return Foundation.atan(x)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // #documentation(SDGCornerstone.RealArithmetic.e)
    /// An instance of *e*.
    public static let e: Float80 = 0x1.5BF0A8B145769535p1

    // #documentation(SDGCornerstone.RealArithmetic.floatingPointApproximation)
    /// A floating point approximation.
    @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}
#endif

extension Float : FloatFamily {

    // MARK: - FloatFamily

    @inlinable public static func _tgmath_pow(_ x: Float, _ y: Float) -> Float {
        return Foundation.pow(x, y)
    }

    @inlinable public static func _tgmath_log(_ x: Float) -> Float {
        return Foundation.log(x)
    }

    @inlinable public static func _tgmath_log10(_ x: Float) -> Float {
        return Foundation.log10(x)
    }

    @inlinable public static func _tgmath_sin(_ x: Float) -> Float {
        return Foundation.sin(x)
    }

    @inlinable public static func _tgmath_cos(_ x: Float) -> Float {
        return Foundation.cos(x)
    }

    @inlinable public static func _tgmath_tan(_ x: Float) -> Float {
        return Foundation.tan(x)
    }

    @inlinable public static func _tgmath_asin(_ x: Float) -> Float {
        return Foundation.asin(x)
    }

    @inlinable public static func _tgmath_acos(_ x: Float) -> Float {
        return Foundation.acos(x)
    }

    @inlinable public static func _tgmath_atan(_ x: Float) -> Float {
        return Foundation.atan(x)
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // #documentation(SDGCornerstone.RealArithmetic.e)
    /// An instance of *e*.
    public static let e: Float = 0x1.5BF0A9p1

    // #documentation(SDGCornerstone.RealArithmetic.floatingPointApproximation)
    /// A floating point approximation.
    @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}
