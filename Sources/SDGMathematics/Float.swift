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

    @inlinable public static var π: Self {
        return pi
    }

    @inlinable public static prefix func √ (operand: Self) -> Self {
        return operand.squareRoot()
    }

    @inlinable public static postfix func √= (operand: inout Self) {
        operand = operand.squareRoot()
    }

    @inlinable public mutating func formLogarithm(toBase base: Self) {
        // log (a) = log (a) ÷ log (b)
        //    b         x         x
        formNaturalLogarithm()
        self ÷= Self.ln(base)
    }

    @inlinable public static func log(_ antilogarithm: Self) -> Self {
        return Self._tgmath_log10(antilogarithm)
    }

    @inlinable public mutating func formCommonLogarithm() {
        self = Self.log(self)
    }

    @inlinable public static func ln(_ antilogarithm: Self) -> Self {
        return Self._tgmath_log(antilogarithm)
    }

    @inlinable public mutating func formNaturalLogarithm() {
        self = Self.ln(self)
    }

    @inlinable public static func sin(_ angle: Angle<Self>) -> Self {
        return Self._tgmath_sin(angle.inRadians)
    }

    @inlinable public static func cos(_ angle: Angle<Self>) -> Self {
        return Self._tgmath_cos(angle.inRadians)
    }

    @inlinable public static func tan(_ angle: Angle<Self>) -> Self {
        return Self._tgmath_tan(angle.inRadians)
    }

    @inlinable public static func arcsin(_ tangent: Self) -> Angle<Self> {
        return Self._tgmath_asin(tangent).radians
    }

    @inlinable public static func arccos(_ tangent: Self) -> Angle<Self> {
        return Self._tgmath_acos(tangent).radians
    }

    @inlinable public static func arctan(_ tangent: Self) -> Angle<Self> {
        return Self._tgmath_atan(tangent).radians
    }

    // MARK: - Subtractable

    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue // @exempt(from: unicode)
    }

    @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue // @exempt(from: unicode)
    }

    // MARK: - WholeArithmetic

    @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue * followingValue // @exempt(from: unicode)
    }

    @inlinable public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue // @exempt(from: unicode)
    }

    @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {
        self ÷= divisor
        self.round(.down)
    }

    @inlinable public static func ↑ (precedingValue: Self, followingValue: Self) -> Self {
        return Self._tgmath_pow(precedingValue, followingValue)
    }

    @inlinable public static func ↑= (precedingValue: inout Self, followingValue: Self) {
        precedingValue = precedingValue ↑ followingValue
    }

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

    public typealias Vector = Stride

    // MARK: - RealArithmetic

    public static let e: Double = 0x1.5BF0A8B145769p1

    @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}

#if canImport(CoreGraphics)

extension CGFloat : FloatFamily {

    // MARK: - CustomDebugStringConvertible

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

    @inlinable public init?(_ description: String) {
        if let result = NativeType(description) {
            self = CGFloat(result)
        } else {
            return nil
        }
    }

    // MARK: - PointProtocol

    public typealias Vector = Stride

    // MARK: - RealArithmetic

    public static let e: CGFloat = CGFloat(Double.e)

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

    public typealias Vector = Stride

    // MARK: - RealArithmetic

    public static let e: Float80 = 0x1.5BF0A8B145769535p1

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

    public typealias Vector = Stride

    // MARK: - RealArithmetic

    public static let e: Float = 0x1.5BF0A9p1

    @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}
