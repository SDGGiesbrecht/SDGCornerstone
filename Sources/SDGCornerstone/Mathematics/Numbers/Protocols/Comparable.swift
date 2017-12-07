/*
 Comparable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.Comparable.≤_]
/// Returns `true` if the left value is ordered before or the same as the right value.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
///
/// - RecommendedOver: <=
infix operator ≤: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.Comparable.≥_]
/// Returns `true` if the left value is ordered after or the same as the right value.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
///
/// - RecommendedOver: >=
infix operator ≥: ComparisonPrecedence

// [_Inherit Documentation: SDGCornerstone.Comparable.≈_]
/// Returns `true` if `lhs` is within the range described by `rhs`.
///
/// ```swift
/// XCTAssert(1 ÷ 3 ≈ 0.33333 ± 0.00001)
/// ```
///
/// - Parameters:
///     - lhs: The value to test.
///     - rhs: The bounds of the range.
infix operator ≈: ComparisonPrecedence

extension Comparable {

    // MARK: - Comparison

    // [_Define Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.

    // [_Define Documentation: SDGCornerstone.Comparable.≤_]
    /// Returns `true` if the left value is ordered before or the same as the right value.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: <=
    public static func ≤ (lhs: Self, rhs: Self) -> Bool {
        return lhs <= rhs
    }

    // [_Define Documentation: SDGCornerstone.Comparable.≥_]
    /// Returns `true` if the left value is ordered after or the same as the right value.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: >=
    public static func ≥ (lhs: Self, rhs: Self) -> Bool {
        return lhs >= rhs
    }

    // [_Define Documentation: SDGCornerstone.Comparable.≥=_]
    // [_Example 1: increase(to:)_]
    /// Increases the value of `self` so that falls at or above `minimum`.
    ///
    /// This is accomplished by changing `self` to match the value of `minimum` if and only if `self` does not already satisfy `self ≥ minimum`.
    ///
    /// For example:
    ///
    /// ```swift
    /// func rollDie() -> Int {
    ///     return Int(randomInRange: 1 ... 6)
    /// }
    ///
    /// let numberOfRolls = 5
    /// var highestRoll = 1
    /// for _ in 1 ... numberOfRolls {
    ///     highestRoll.increase(to: rollDie())
    /// }
    /// print("After rolling the die \(numberOfRolls.inDigits()) time(s), the highest roll was \(highestRoll.inDigits()).")
    /// // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
    ///
    /// // In each iteration of the for loop, a new number is rolled, and if it is greater than highestRoll’s existing value, increase(to:) changes highestRoll to reflect the new high.
    /// ```
    ///
    /// - Parameters:
    ///     - minimum: The desired minimum for the value.
    ///
    /// - NonmutatingVariant: max
    public mutating func increase(to minimum: Self) {
        if self < minimum {
            self = minimum
        }
    }

    // [_Define Documentation: SDGCornerstone.Comparable.≤=_]
    // [_Example 1: decrease(to:)_]
    /// Decreases the value of `self` so that falls at or below `maximum`.
    ///
    /// This is accomplished by changing `self` to match the value of `maximum` if and only if `self` does not already satisfy `self ≤ maximum`.
    ///
    /// For example:
    ///
    /// ```swift
    /// func rollDie() -> Int {
    ///     return Int(randomInRange: 1 ... 6)
    /// }
    ///
    /// let numberOfRolls = 5
    /// var lowestRoll = 6
    /// for _ in 1 ... numberOfRolls {
    ///     lowestRoll.decrease(to: rollDie())
    /// }
    /// print("After rolling the die \(numberOfRolls.inDigits()) time(s), the lowest roll was \(lowestRoll.inDigits()).")
    /// // Prints, for example, “After rolling the die 5 time(s), the lowest roll was 2.”
    ///
    /// // In each iteration of the for loop, a new number is rolled, and if it is less than lowestRoll’s existing value, decrease(to:) changes lowestRoll to reflect the new low.
    /// ```
    ///
    /// - Parameters:
    ///     - maximum: The desired maximum for the value.
    ///
    /// - NonmutatingVariant: min
    public mutating func decrease(to maximum: Self) {
        if self > maximum {
            self = maximum
        }
    }

    // MARK: - Approximation

    // [_Define Documentation: SDGCornerstone.Comparable.≈_]
    // [_Example 1: ≈_]
    /// Returns `true` if `lhs` is within the range described by `rhs`.
    ///
    /// ```swift
    /// XCTAssert(1 ÷ 3 ≈ 0.33333 ± 0.00001)
    /// ```
    ///
    /// - Parameters:
    ///     - lhs: The value to test.
    ///     - rhs: The bounds of the range.
    public static func ≈ (lhs: Self, rhs: (Self, Self)) -> Bool {
        let range: ClosedRange<Self>
        if rhs.0 ≥ rhs.1 {
            range = rhs.1 ... rhs.0
        } else {
            range = rhs.0 ... rhs.1
        }

        return lhs ∈ range
    }
}

extension Comparable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Comparable where Self : OrderedEnumeration {
    // MARK: - where Self : OrderedEnumeration

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
