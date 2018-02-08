/*
 RationalArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷_]
/// Returns the (rational) quotient of the left divided by the right.
///
/// - Parameters:
///     - lhs: The dividend.
///     - rhs: The divisor.
///
/// - MutatingVariant: ×
///
/// - RecommendedOver: /
infix operator ÷: MultiplicationPrecedence

// [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷=_]
/// Modifies the left by dividing it by the right.
///
/// - Parameters:
///     - lhs: The value to modify.
///     - rhs: The divisor.
///
/// - NonmutatingVariant: ÷
///
/// - RecommendedOver: /=
infix operator ÷=: AssignmentPrecedence

/// A type that can be used for rational arithmetic.
///
/// Conformance Requirements:
///
/// - `IntegralArithmetic`
/// - `init(_ floatingPoint: FloatMax)`
/// - `static func ÷= (lhs: inout Self, rhs: Self)`
public protocol RationalArithmetic : ExpressibleByFloatLiteral, IntegralArithmetic {

    // [_Define Documentation: SDGCornerstone.IntegralArithmetic.init(floatingPoint:)_]
    /// Creates an instance as close as possible to `floatingPoint`.
    ///
    /// - Properties:
    ///     - floatingPoint: An instance of `FloatMax`.
    init(_ floatingPoint: FloatMax)

    // [_Define Documentation: SDGCornerstone.RationalArithmetic.÷_]
    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    static func ÷ (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RationalArithmetic.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    static func ÷= (lhs: inout Self, rhs: Self)

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: Range<Self>)

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer)
}

extension RationalArithmetic {

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷_]
    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    public static func ÷ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ÷= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {

        assert(¬range.isEmpty, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "Empty range."
            }
        }))

        var random = range.upperBound

        while random == range.upperBound {
            random = Self(randomInRange: range.lowerBound ... range.upperBound, fromRandomizer: randomizer)
        }

        self = random
    }

    /// Returns the number in digits.
    ///
    /// - Parameters:
    ///     - maximumDecimalPlaces: The maximum number of decimal places.
    ///     - radixCharacter: The character to use to represent the radix.
    ///     - thousandsSeparator: The thousands separator. (Space by default.)
    public func inDigits(maximumDecimalPlaces: Int, radixCharacter: UnicodeScalar, thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        let digitSet = egyptianDigits

        let radix = self.radix(for: digitSet)
        let digitMapping = mapping(for: digitSet)

        var result = integralDigits(thousandsSeparator: thousandsSeparator)

        var remainder = (|self|).mod(1)
        if remainder == 0 {
            return result
        } else {
            var decimalDigits: [Self] = []
            var positionValue: Self = 1
            while remainder ≠ 0 ∧ decimalDigits.count ≤ maximumDecimalPlaces {
                positionValue ÷= radix
                decimalDigits.append(remainder.dividedAccordingToEuclid(by: positionValue))
                remainder = remainder.mod(positionValue)
            }

            if decimalDigits.count > maximumDecimalPlaces {
                let next = decimalDigits.removeLast()
                if next.rounded(.toNearestOrAwayFromZero, toMultipleOf: radix) ≠ 0 {
                    for index in decimalDigits.indices.reversed() {
                        var digit = decimalDigits[index]
                        defer { decimalDigits[index] = digit }
                        digit += 1 as Self

                        if digit == radix {
                            digit = 0
                            if index == 0 {
                                result = (self + (1 as Self)).integralDigits(thousandsSeparator: thousandsSeparator)
                            }
                        } else {
                            break
                        }
                    }
                }
            }

            result.append(radixCharacter)
            for index in decimalDigits.indices {
                if index.mod(3) == 0 ∧ index ≠ 0 {
                    result.append(thousandsSeparator)
                }
                guard let digit = digitMapping[decimalDigits[index]] else {
                    unreachable()
                }
                result.append(digit)
            }

            return result
        }
    }

    // MARK: - Calendar Intervals

    /// Returns a calendar interval in Gregorian leap year cycles.
    public var gregorianLeapYearCycles: CalendarInterval<Self> {
        return CalendarInterval(gregorianLeapYearCycles: self)
    }

    /// Returns a calendar interval in Hebrew moons.
    public var hebrewMoons: CalendarInterval<Self> {
        return CalendarInterval(hebrewMoons: self)
    }

    /// Returns a calendar interval in weeks.
    public var weeks: CalendarInterval<Self> {
        return CalendarInterval(weeks: self)
    }

    /// Returns a calendar interval in days.
    public var days: CalendarInterval<Self> {
        return CalendarInterval(days: self)
    }

    /// Returns a calendar interval in hours.
    public var hours: CalendarInterval<Self> {
        return CalendarInterval(hours: self)
    }

    /// Returns a calendar interval in minutes.
    public var minutes: CalendarInterval<Self> {
        return CalendarInterval(minutes: self)
    }

    /// Returns a calendar interval in Hebrew parts.
    public var hebrewParts: CalendarInterval<Self> {
        return CalendarInterval(hebrewParts: self)
    }

    /// Returns a calendar interval in seconds.
    public var seconds: CalendarInterval<Self> {
        return CalendarInterval(seconds: self)
    }
}

extension RationalArithmetic where Self : FloatFamily {
    // MARK: - where Self : FloatFamily

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷_]
    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    public static func ÷ (lhs: Self, rhs: Self) -> Self {
        return lhs / rhs
    }

    // [_Inherit Documentation: SDGCornerstone.RationalArithmetic.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    public static func ÷= (lhs: inout Self, rhs: Self) {
        lhs /= rhs
    }
}
