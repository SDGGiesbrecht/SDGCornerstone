/*
 Comparable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Comparable {

    // MARK: - Comparison

    // @documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.

    // @documentation(SDGCornerstone.Comparable.≤)
    /// Returns `true` if the preceding operand is ordered before or the same as the following operand.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func ≤ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue <= followingValue
    }

    // @documentation(SDGCornerstone.Comparable.≥)
    /// Returns `true` if the preceding operand is ordered after or the same as the following operand.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func ≥ (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue >= followingValue
    }

    // @documentation(SDGCornerstone.Comparable.≥=)
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
    @_inlineable public mutating func increase(to minimum: Self) {
        if self < minimum {
            self = minimum
        }
    }

    // @documentation(SDGCornerstone.Comparable.≤=)
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
    @_inlineable public mutating func decrease(to maximum: Self) {
        if self > maximum {
            self = maximum
        }
    }

    // MARK: - Approximation

    // @documentation(SDGCornerstone.Comparable.≈)
    // [_Example 1: ≈_]
    /// Returns `true` if `precedingValue` is within the range described by `followingValue`.
    ///
    /// ```swift
    /// XCTAssert(1 ÷ 3 ≈ 0.33333 ± 0.00001)
    /// ```
    ///
    /// - Parameters:
    ///     - precedingValue: The value to test.
    ///     - followingValue: The bounds of the range.
    @_inlineable public static func ≈ (precedingValue: Self, followingValue: (Self, Self)) -> Bool {
        let range: ClosedRange<Self>
        if followingValue.0 ≥ followingValue.1 {
            range = followingValue.1 ... followingValue.0
        } else {
            range = followingValue.0 ... followingValue.1
        }

        return range.contains(precedingValue)
    }
}
