/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
  #if canImport(CoreGraphics)
    import CoreGraphics  // Not included in Foundation on iOS.
  #endif
#endif

#if os(Windows)  // #workaround(workspace version 0.30.2, Windows does not support C.)
  import WinSDK
#else
  import RealModule
#endif

// #workaround(Swift 5.1.5, Compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  #if os(Windows) || os(tvOS) || os(iOS) || os(Android) || os(watchOS)
    // #documentation(FloatMax)
    /// The member of the `Float` family with the largest bit field.
    public typealias FloatMax = Double
  #else
    // @documentation(FloatMax)
    /// The member of the `Float` family with the largest bit field.
    public typealias FloatMax = Float80
  #endif
#else
  // #documentation(FloatMax)
  /// The member of the `Float` family with the largest bit field.
  public typealias FloatMax = Double
#endif

/// A member of the `Float` family; `Double`, `Float80` or `Float`.
public protocol FloatFamily: BinaryFloatingPoint, CustomDebugStringConvertible,
  LosslessStringConvertible, RealNumberProtocol
{}

extension FloatFamily {

  // MARK: - Negatable

  @inlinable public static prefix func − (operand: Self) -> Self {
    return -operand  // @exempt(from: unicode)
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
    return precedingValue / followingValue  // @exempt(from: unicode)
  }

  @inlinable public static func ÷= (precedingValue: inout Self, followingValue: Self) {
    precedingValue /= followingValue  // @exempt(from: unicode)
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

  @inlinable public mutating func formCommonLogarithm() {
    self = Self.log(self)
  }

  @inlinable public mutating func formNaturalLogarithm() {
    self = Self.ln(self)
  }

  // MARK: - Subtractable

  @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue - followingValue  // @exempt(from: unicode)
  }

  @inlinable public static func −= (precedingValue: inout Self, followingValue: Self) {
    precedingValue -= followingValue  // @exempt(from: unicode)
  }

  // MARK: - WholeArithmetic

  @inlinable public static func × (precedingValue: Self, followingValue: Self) -> Self {
    return precedingValue * followingValue  // @exempt(from: unicode)
  }

  @inlinable public static func ×= (precedingValue: inout Self, followingValue: Self) {
    precedingValue *= followingValue  // @exempt(from: unicode)
  }

  @inlinable public mutating func divideAccordingToEuclid(by divisor: Self) {
    self ÷= divisor
    self.round(.down)
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

#if !os(Windows)  // #workaround(workspace version 0.30.2, Windows does not support C.)
  extension ElementaryFunctions {
    @inlinable internal static func logAsElementaryFunctions(_ x: Self) -> Self {
      return Self.log(x)
    }
  }

  extension FloatFamily where Self: ElementaryFunctions {

    // MARK: - RealArithmetic

    @inlinable public static func ln(_ antilogarithm: Self) -> Self {
      return Self.logAsElementaryFunctions(antilogarithm)
    }

    @inlinable public static func cos(_ angle: Angle<Self>) -> Self {
      return Self.cos(angle.inRadians)
    }

    @inlinable public static func sin(_ angle: Angle<Self>) -> Self {
      return Self.sin(angle.inRadians)
    }

    @inlinable public static func tan(_ angle: Angle<Self>) -> Self {
      return Self.tan(angle.inRadians)
    }

    @inlinable public static func arcsin(_ sine: Self) -> Angle<Self> {
      return Self.asin(sine).radians
    }

    @inlinable public static func arccos(_ cosine: Self) -> Angle<Self> {
      return Self.acos(cosine).radians
    }

    @inlinable public static func arctan(_ tangent: Self) -> Angle<Self> {
      return Self.atan(tangent).radians
    }

    // MARK: - WholeArithmetic

    @inlinable public static func ↑ (precedingValue: Self, followingValue: Self) -> Self {
      if precedingValue.isNonNegative {  // SwiftNumerics refuses to do negatives.
        return Self.pow(precedingValue, followingValue)
      } else if let integer = Int(exactly: followingValue) {
        return Self.pow(precedingValue, integer)
      } else {  // @exempt(from: tests)
        // @exempt(from: tests)
        // Allow SwiftNumerics to decide on the error:
        return Self.pow(precedingValue, followingValue)
      }
    }
  }
#endif

extension Double: FloatFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride

  // MARK: - RealArithmetic

  public static let e: Double = 0x1.5BF0A8B145769p1

  #if !os(Windows)  // #workaround(workspace version 0.30.2, Windows does not support C.)
    @inlinable public static func log(_ antilogarithm: Self) -> Self {
      return Self.log10(antilogarithm)
    }
  #endif

  @inlinable public var floatingPointApproximation: FloatMax {
    return FloatMax(self)
  }

  #if os(Windows)  // #workaround(workspace version 0.30.2, Windows does not support C.)
    @inlinable public static func ln(_ antilogarithm: Double) -> Double {
      return WinSDK.log(antilogarithm)
    }

    @inlinable public static func cos(_ angle: Angle<Double>) -> Double {
      return WinSDK.cos(angle.inRadians)
    }

    @inlinable public static func sin(_ angle: Angle<Double>) -> Double {
      return WinSDK.sin(angle.inRadians)
    }

    @inlinable public static func tan(_ angle: Angle<Double>) -> Double {
      return WinSDK.tan(angle.inRadians)
    }

    @inlinable public static func arcsin(_ sine: Double) -> Angle<Double> {
      return WinSDK.asin(sine).radians
    }

    @inlinable public static func arccos(_ cosine: Double) -> Angle<Double> {
      return WinSDK.acos(cosine).radians
    }

    @inlinable public static func arctan(_ tangent: Double) -> Angle<Double> {
      return WinSDK.atan(tangent).radians
    }

    // MARK: - WholeArithmetic

    @inlinable public static func ↑ (precedingValue: Double, followingValue: Double) -> Double {
      return WinSDK.pow(precedingValue, followingValue)
    }
  #endif
}

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  extension CGFloat: FloatFamily {

    // MARK: - CustomDebugStringConvertible

    @inlinable public var debugDescription: String {
      return NativeType(self).debugDescription
    }

    // MARK: - IntegralArithmetic

    @inlinable public init(_ int: IntMax) {
      self = CGFloat(NativeType(int))
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

    public static let e: CGFloat = CGFloat(NativeType.e)

    @inlinable public static func ln(_ antilogarithm: Self) -> Self {
      return CGFloat(SDGMathematics.ln(NativeType(antilogarithm)))
    }

    @inlinable public static func log(_ antilogarithm: Self) -> Self {
      return CGFloat(SDGMathematics.log(NativeType(antilogarithm)))
    }

    @inlinable internal static func convert(_ angle: Angle<Self>) -> Angle<NativeType> {
      return Angle(rawValue: NativeType(angle.rawValue))
    }

    @inlinable public static func cos(_ angle: Angle<Self>) -> Self {
      return CGFloat(SDGMathematics.cos(convert(angle)))
    }

    @inlinable public static func sin(_ angle: Angle<Self>) -> Self {
      return CGFloat(SDGMathematics.sin(convert(angle)))
    }

    @inlinable public static func tan(_ angle: Angle<Self>) -> Self {
      return CGFloat(SDGMathematics.tan(convert(angle)))
    }

    @inlinable internal static func convert(_ angle: Angle<NativeType>) -> Angle<Self> {
      return Angle(rawValue: CGFloat(angle.rawValue))
    }

    @inlinable public static func arcsin(_ sine: Self) -> Angle<Self> {
      return convert(SDGMathematics.arcsin(NativeType(sine)))
    }

    @inlinable public static func arccos(_ cosine: Self) -> Angle<Self> {
      return convert(SDGMathematics.arccos(NativeType(cosine)))
    }

    @inlinable public static func arctan(_ tangent: Self) -> Angle<Self> {
      return convert(SDGMathematics.arctan(NativeType(tangent)))
    }

    @inlinable public var floatingPointApproximation: FloatMax {
      return FloatMax(NativeType(self))
    }

    // MARK: - WholeArithmetic

    @inlinable public init(_ uInt: UIntMax) {
      self = CGFloat(NativeType(uInt))
    }

    @inlinable public static func ↑ (precedingValue: Self, followingValue: Self) -> Self {
      return CGFloat(NativeType(precedingValue) ↑ NativeType(followingValue))
    }
  }
#endif

#if !(os(Windows) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  // #workaround(Swift 5.1.5, Compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)

    extension Float80: Decodable, Encodable, FloatFamily {

      // MARK: - Decodable

      public init(from decoder: Decoder) throws {
        self.init(try Double(from: decoder))
      }

      // MARK: - Encodable

      public func encode(to encoder: Encoder) throws {
        // This causes a reduction in precision, but is necessary to preserve compatibility with Double and Float. (Especially when used as FloatMax.) It is also more likely to be forward compatible than other formats if the Standard Library provides this conformance in the future.
        try Double(self).encode(to: encoder)
      }

      // MARK: - PointProtocol

      public typealias Vector = Stride

      // MARK: - RealArithmetic

      public static let e: Float80 = 0x1.5BF0A8B145769535p1

      @inlinable public static func log(_ antilogarithm: Self) -> Self {
        return Self.log10(antilogarithm)
      }

      @inlinable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
      }
    }
  #endif
#endif

extension Float: FloatFamily {

  // MARK: - PointProtocol

  public typealias Vector = Stride

  // MARK: - RealArithmetic

  public static let e: Float = 0x1.5BF0Bp1

  #if !os(Windows)  // #workaround(workspace version 0.30.2, Windows does not support C.)
    @inlinable public static func log(_ antilogarithm: Self) -> Self {
      return Self.log10(antilogarithm)
    }
  #endif

  @inlinable public var floatingPointApproximation: FloatMax {
    return FloatMax(self)
  }

  #if os(Windows)  // #workaround(workspace version 0.30.2, Windows does not support C.)
    @inlinable public static func ln(_ antilogarithm: Float) -> Float {
      return Float(WinSDK.log(Double(antilogarithm)))
    }

    @inlinable public static func cos(_ angle: Angle<Float>) -> Float {
      return Float(WinSDK.cos(Double(angle.inRadians)))
    }

    @inlinable public static func sin(_ angle: Angle<Float>) -> Float {
      return Float(WinSDK.sin(Double(angle.inRadians)))
    }

    @inlinable public static func tan(_ angle: Angle<Float>) -> Float {
      return Float(WinSDK.tan(Double(angle.inRadians)))
    }

    @inlinable public static func arcsin(_ sine: Float) -> Angle<Float> {
      return Float(WinSDK.asin(Double(sine))).radians
    }

    @inlinable public static func arccos(_ cosine: Float) -> Angle<Float> {
      return Float(WinSDK.acos(Double(cosine))).radians
    }

    @inlinable public static func arctan(_ tangent: Float) -> Angle<Float> {
      return Float(WinSDK.atan(Double(tangent))).radians
    }

    // MARK: - WholeArithmetic

    @inlinable public static func ↑ (precedingValue: Float, followingValue: Float) -> Float {
      return Float(WinSDK.pow(Double(precedingValue), Double(followingValue)))
    }
  #endif
}
