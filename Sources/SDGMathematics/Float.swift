/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
import CoreGraphics
#endif

import SDGControlFlow

#if os(iOS) || os(watchOS) || os(tvOS)
// MARK: - #if os(iOS) || os(watchOS) || os(tvOS)
// [_Workaround: Probably available in Swift 4.2 (Swift 4.1.2)_]

/// The member of the `Float` family with the largest bit field.
public typealias FloatMax = Double
#else
// MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))

/// The member of the `Float` family with the largest bit field.
public typealias FloatMax = Float80
#endif

/// A member of the `Float` family: `Double`, `Float80` or `Float`
public protocol FloatFamily : BinaryFloatingPoint, CustomDebugStringConvertible, LosslessStringConvertible, RealNumberProtocol {

    // [_Define Documentation: SDGCornerstone.FloatFamily.init(_:)_]
    /// Creates a new value, rounded to the closest possible representation.
    ///
    /// - Parameters:
    ///     - value: The number to convert to a floating‐point value.
    init(_ value: Exponent)

    // [_Define Documentation: SDGCornerstone.FloatFamily.ln2_]
    /// The value of ln2.
    static var ln2: Self { get }
}

extension FloatFamily {

    // MARK: - Negatable

    // #documentation(SDGCornerstone.Negatable.−)
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    @_inlineable public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    // #documentation(SDGCornerstone.Negatable.−=)
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    @_inlineable public static postfix func −= (operand: inout Self) {
        operand.negate()
    }

    // MARK: - NumericAdditiveArithmetic

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.absoluteValue)
    /// The absolute value.
    @_inlineable public var absoluteValue: Self {
        return abs(self)
    }

    // #documentation(SDGCornerstone.NumericAdditiveArithmetic.formAbsoluteValue)
    /// Sets `self` to its absolute value.
    @_inlineable public mutating func formAbsoluteValue() {
        self = abs(self)
    }

    // MARK: - RationalArithmetic

    // #documentation(SDGCornerstone.RationalArithmetic.÷)
    /// Returns the (rational) quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    @_inlineable public static func ÷ (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue / followingValue
    }

    // #documentation(SDGCornerstone.RationalArithmetic.÷=)
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The divisor.
    @_inlineable public static func ÷= (precedingValue: inout Self, followingValue: Self) {
        precedingValue /= followingValue
    }

    // MARK: - RealArithmetic

    // #documentation(SDGCornerstone.RealArithmetic.π)
    /// An instance of π.
    @_inlineable public static var π: Self {
        return pi
    }

    // #documentation(SDGCornerstone.RealArithmetic.√)
    /// Returns the square root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    @_inlineable public static prefix func √ (operand: Self) -> Self {
        return operand.squareRoot()
    }

    // #documentation(SDGCornerstone.RealArithmetic.√=)
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    @_inlineable public static postfix func √= (operand: inout Self) {
        operand = operand.squareRoot()
    }

    @_inlineable @_versioned internal mutating func tryConvenientLogarithms(toBase base: Self) -> Bool {

        _assert(self > 0, { (localization: _APILocalization) -> String in
            switch localization { // [_Exempt from Test Coverage_]
            case .englishCanada:
                return "Logarithms of non‐positive numbers are undefined. (\(self))"
            }
        })
        _assert(base > 0, { (localization: _APILocalization) -> String in
            switch localization { // [_Exempt from Test Coverage_]
            case .englishCanada:
                return "Logarithms in a non‐positive base are undefined. (\(base))"
            }
        })
        _assert(base ≠ 1, { (localization: _APILocalization) -> String in
            switch localization { // [_Exempt from Test Coverage_]
            case .englishCanada:
                return "Logarithms in base 1 are undefined."
            }
        })

        if self == 1 {
            self = 0 // x ↑ 0 = 1
            return true
        } else if self == base {
            self = 1 // x ↑ 1 = x
            return true
        } else {
            // not convenient
            return false
        }
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
    @_inlineable public mutating func formLogarithm(toBase base: Self) {

        if ¬tryConvenientLogarithms(toBase: base) {

            // log (a) = log (a) ÷ log (b)
            //    b         x         x

            formNaturalLogarithm()
            self ÷= Self.ln(base)
        }
    }

    // #documentation(SDGCornerstone.RealArithmetic.formNaturalLogarithm())
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    @_inlineable public mutating func formNaturalLogarithm() {

        if ¬tryConvenientLogarithms(toBase: e) {

            if self == 2 {
                self = Self.ln2
            } else {
                // if y = s × b ↑ x
                // then ln(y) = ln(s) + x × ln(b)

                let s: Self = significand
                let x = Self(exponent)
                // Since 1 ≤ s < 2, (or possibly 0 ≤ s for subnormal values?)
                // s satisfies 0 ≤ s < 2 and the Taylor series around 1 will converge:
                //
                //   ∞         n + 1          n
                //   ∑    ( (−1)      _(s_−_1)__ )
                // n = 1                  n

                self = 0
                var lastApproximate = self
                var n: Self = 1
                var negative = false
                let sMinusOne: Self = s − (1 as Self)
                var numerator: Self = sMinusOne
                repeat {
                    lastApproximate = self

                    var term = numerator ÷ n
                    if negative {
                        term−=
                    }
                    self += term

                    n += 1 as Self
                    negative¬=
                    numerator ×= sMinusOne

                } while self ≠ lastApproximate

                self += x × Self.ln2
            }
        }
    }

    // #documentation(SDGCornerstone.RealArithmetic.sin(_:))
    /// Returns the sine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func sin(_ angle: Angle<Self>) -> Self {

        if ¬(additiveIdentity.rad ..< τ.rad).contains(angle) {
            // Use periodic reference angle.
            return sin(angle.mod(τ.rad))
        } else if angle > π.rad {
            // Quadrants III & IV
            return −sin(angle − π.rad)
        } else if angle > (π ÷ 2).rad {
            // Quadrant II
            return sin(π.rad − angle)
        } else {
            // Quadrant I

            if angle > (π ÷ 4).rad {
                // Cosine converges faster in this range.
                return cos((π ÷ 2).rad − angle)
            } else {

                //   ∞         n + 1     2n − 1
                //   ∑    ( (−1)      __θ________ )
                // n = 1               (2n − 1)!

                var result: Self = 0
                var lastApproximate: Self = result
                var negative = false
                var numerator = angle.inRadians
                var _2n_m_1: Self = 1
                var denominator: Self = 1
                repeat {
                    lastApproximate = result

                    var term = numerator ÷ denominator
                    if negative {
                        term−=
                    }
                    result += term

                    negative¬=

                    let multiplicationStep = {
                        numerator ×= angle.inRadians
                        _2n_m_1 += 1 as Self
                        denominator ×= _2n_m_1
                    }
                    multiplicationStep()
                    multiplicationStep()

                } while result ≠ lastApproximate

                return result
            }
        }
    }

    // #documentation(SDGCornerstone.RealArithmetic.cos(_:))
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    @_inlineable public static func cos(_ angle: Angle<Self>) -> Self {

        if ¬(additiveIdentity.rad ..< τ.rad).contains(angle) {
            // Use periodic reference angle.
            return cos(angle.mod(τ.rad))
        } else if angle > π.rad {
            // Quadrants III & IV
            return cos(τ.rad − angle)
        } else if angle > (π ÷ 2).rad {
            // Quadrant II
            return −cos(π.rad − angle)
        } else {
            // Quadrant I

            if angle > (π ÷ 4).rad {
                // Sine converges faster in this range.
                return sin((π ÷ 2).rad − angle)
            } else {

                //   ∞         n + 1      2n
                //   ∑    ( (−1)      ___θ___ )
                // n = 0               (2n)!

                var result: Self = 0
                var lastApproximate: Self = result
                var negative = false
                var numerator: Self = 1
                var _2n: Self = 0
                var denominator: Self = 1
                repeat {
                    lastApproximate = result

                    var term = numerator ÷ denominator
                    if negative {
                        term−=
                    }
                    result += term

                    negative¬=

                    let multiplicationStep = {
                        numerator ×= angle.inRadians
                        _2n += 1 as Self
                        denominator ×= _2n
                    }
                    multiplicationStep()
                    multiplicationStep()

                } while result ≠ lastApproximate

                return result
            }
        }
    }

    // #documentation(SDGCornerstone.RealArithmetic.arctan(_:))
    /// Returns the arctangent of a value.
    ///
    /// The returned angle will be between −90° and 90°.
    ///
    /// - Parameters:
    ///     - tangent: The tangent.
    @_inlineable public static func arctan(_ tangent: Self) -> Angle<Self> {

        if tangent.isNegative {
            return −arctan(−tangent)
        } else if tangent > 1 {
            return (π ÷ 2).rad − arctan(1 ÷ tangent)
        } else if tangent > 2 − √3 {
            let r3: Self = √3
            let numerator: Self = r3 × tangent − (1 as Self)
            let referenceTangent: Self = numerator ÷ (r3 + tangent)
            return (π ÷ 6).rad + arctan(referenceTangent)
        } else {

            //   ∞         n + 1     2n − 1
            //   ∑    ( (−1)      __x_______ )
            // n = 1               (2n − 1)

            var result: Self = 0
            var lastApproximate: Self = result
            var negative = false
            var numerator = tangent
            let x_2 = tangent × tangent
            var denominator: Self = 1
            repeat {
                lastApproximate = result

                var term = numerator ÷ denominator
                if negative {
                    term−=
                }
                result += term

                negative¬=
                numerator ×= x_2
                denominator += 2 as Self

            } while result ≠ lastApproximate

            return result.radians
        }
    }

    // MARK: - Subtractable

    // #documentation(SDGCornerstone.Subtractable.−)
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // #documentation(SDGCornerstone.Subtractable.−=)
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    @_inlineable public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue
    }

    // MARK: - WholeArithmetic

    // #documentation(SDGCornerstone.WholeArithmetic.×)
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func × (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue * followingValue
    }

    // #documentation(SDGCornerstone.WholeArithmetic.×=)
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    @_inlineable public static func ×= (precedingValue: inout Self, followingValue: Self) {
        precedingValue *= followingValue
    }

    // #documentation(SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:))
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    @_inlineable public mutating func divideAccordingToEuclid(by divisor: Self) {
        self ÷= divisor
        self.round(.down)
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
    @_inlineable public static func ↑= (precedingValue: inout Self, followingValue: Self) {

        _assert(precedingValue.isNonNegative ∨ followingValue.isIntegral, { (localization: _APILocalization) -> String in
            switch localization { // [_Exempt from Test Coverage_]
            case .englishCanada:
                return "The result of a negative number raised to a non‐integer exponent may be outside the set of real numbers. Use a type that can represent complex numbers instead. (\(precedingValue) ↑ \(followingValue))"
            }
        })

        if followingValue.isIntegral {
            precedingValue.raiseRationalNumberToThePowerOf(rationalNumber: followingValue)
        } else if followingValue.isNegative /* but not an integer */ {
            precedingValue = 1 ÷ precedingValue ↑ −followingValue
        } else if precedingValue == e /* (natural) exponential function */ {

            // if x = e ↑ (w + r)
            // then x = e ↑ w × e ↑ r
            let w: Self = followingValue.rounded(.toNearestOrAwayFromZero)
            let r: Self = followingValue − w

            precedingValue.raiseRationalNumberToThePowerOf(rationalNumber: w)

            // The Taylor series around 0 will converge for any real r:
            //
            //   ∞       n
            //   ∑   ( _x__ )
            // n = 0    n!

            var e_r: Self = 1
            var lastApproximate: Self = 0
            var n: Self = 1
            var numerator: Self = r
            var denominator: Self = n
            repeat {
                lastApproximate = e_r

                e_r += numerator ÷ denominator

                n += 1 as Self
                numerator ×= r
                denominator ×= n

            } while e_r ≠ lastApproximate

            precedingValue ×= e_r

        } else {
            precedingValue = e ↑ (followingValue × ln(precedingValue))
        }
    }

    // #documentation(SDGCornerstone.WholeArithmetic.rounded(_:))
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @_inlineable public func rounded(_ rule: RoundingRule) -> Self {
        return roundedAsFloatingPoint(rule)
    }
}

extension FloatingPoint {
    @_inlineable @_versioned internal func roundedAsFloatingPoint(_ rule: FloatingPointRoundingRule) -> Self {
        return rounded(rule)
    }
}

extension Double : FloatFamily {

    // MARK: - FloatFamily

    // #documentation(SDGCornerstone.FloatFamily.ln2)
    /// The value of ln2.
    public static let ln2: Double = 0x1.62E42FEFA39EFp-1

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
    @_inlineable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}

#if canImport(CoreGraphics)
// MARK: - #if canImport(CoreGraphics)

extension CGFloat : FloatFamily {

    // MARK: - CustomDebugStringConvertible

    /// A textual representation of this instance, suitable for debugging.
    @_inlineable public var debugDescription: String {
        return NativeType(self).debugDescription
    }

    // MARK: - FloatFamily

    // #documentation(SDGCornerstone.FloatFamily.ln2)
    /// The value of ln2.
    public static let ln2: CGFloat = CGFloat(Double.ln2)

    // MARK: - LosslessStringConvertible

    /// Instantiates an instance of the conforming type from a string representation.
    ///
    /// - Parameters:
    ///     - description: The string representation.
    @_inlineable public init?(_ description: String) {
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
    @_inlineable public var floatingPointApproximation: FloatMax {
        return FloatMax(NativeType(self))
    }
}
#endif

#if !(os(iOS) || os(watchOS) || os(tvOS))
// MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))
// [_Workaround: Probably available in Swift 4.2 (Swift 4.1.2)_]

extension Float80 : Codable, FloatFamily {

    // MARK: - Decodable

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        self.init(try Double(from: decoder))
    }

    // MARK: - Encodable

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        // This causes a reduction in precision, but is necessary to preserve compatibility with Double and Float. (Especially when used as FloatMax.) It is also more likely to be forward compatible than other formats if the Standard Library provides this conformance in the future.
        try Double(self).encode(to: encoder)
    }

    // MARK: - FloatFamily

    // #documentation(SDGCornerstone.FloatFamily.ln2)
    /// The value of ln2.
    public static let ln2: Float80 = 0x1.62E42FEFA39EF358p-1

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
    @_inlineable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}
#endif

extension Float : FloatFamily {

    // MARK: - FloatFamily

    // #documentation(SDGCornerstone.FloatFamily.ln2)
    /// The value of ln2.
    public static let ln2: Float = 0x1.62E430p-1

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
    @_inlineable public var floatingPointApproximation: FloatMax {
        return FloatMax(self)
    }
}
