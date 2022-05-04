/*
 Comparable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension Comparable {

  // MARK: - Comparison

  // @documentation(SDGCornerstone.Comparable.≤)
  /// Returns `true` if the preceding operand is ordered before or the same as the following operand.
  ///
  /// - Parameters:
  ///     - precedingValue: A value to compare.
  ///     - followingValue: Another value to compare.
  @inlinable public static func ≤ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue <= followingValue  // @exempt(from: unicode)
  }

  // @documentation(SDGCornerstone.Comparable.≥)
  /// Returns `true` if the preceding operand is ordered after or the same as the following operand.
  ///
  /// - Parameters:
  ///     - precedingValue: A value to compare.
  ///     - followingValue: Another value to compare.
  @inlinable public static func ≥ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue >= followingValue  // @exempt(from: unicode)
  }

  // #example(1, increase)
  /// Increases the value of `self` so that falls at or above `minimum`.
  ///
  /// This is accomplished by changing `self` to match the value of `minimum` if and only if `self` does not already satisfy `self ≥ minimum`.
  ///
  /// For example:
  ///
  /// ```swift
  /// func rollDie() -> Int {
  ///   return Int.random(in: 1...6)
  /// }
  ///
  /// let numberOfRolls = 5
  /// var highestRoll = 1
  /// for _ in 1...numberOfRolls {
  ///   highestRoll.increase(to: rollDie())
  /// }
  /// print(
  ///   "After rolling the die \(numberOfRolls.inDigits()) time(s), the highest roll was \(highestRoll.inDigits())."
  /// )
  /// // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
  ///
  /// // In each iteration of the for loop, a new number is rolled, and if it is greater than highestRoll’s existing value, increase(to:) changes highestRoll to reflect the new high.
  /// ```
  ///
  /// - Parameters:
  ///     - minimum: The desired minimum for the value.
  @inlinable public mutating func increase(to minimum: Self) {
    if self < minimum {
      self = minimum
    }
  }

  // #example(1, decrease)
  /// Decreases the value of `self` so that falls at or below `maximum`.
  ///
  /// This is accomplished by changing `self` to match the value of `maximum` if and only if `self` does not already satisfy `self ≤ maximum`.
  ///
  /// For example:
  ///
  /// ```swift
  /// func rollDie() -> Int {
  ///   return Int.random(in: 1...6)
  /// }
  ///
  /// let numberOfRolls = 5
  /// var lowestRoll = 6
  /// for _ in 1...numberOfRolls {
  ///   lowestRoll.decrease(to: rollDie())
  /// }
  /// print(
  ///   "After rolling the die \(numberOfRolls.inDigits()) time(s), the lowest roll was \(lowestRoll.inDigits())."
  /// )
  /// // Prints, for example, “After rolling the die 5 time(s), the lowest roll was 2.”
  ///
  /// // In each iteration of the for loop, a new number is rolled, and if it is less than lowestRoll’s existing value, decrease(to:) changes lowestRoll to reflect the new low.
  /// ```
  ///
  /// - Parameters:
  ///     - maximum: The desired maximum for the value.
  @inlinable public mutating func decrease(to maximum: Self) {
    if self > maximum {
      self = maximum
    }
  }

  // MARK: - Approximation

  // #example(1, ≈)
  /// Returns `true` if `precedingValue` is within the range described by `followingValue`.
  ///
  /// ```swift
  /// XCTAssert(1 ÷ 3 ≈ 0.33333 ± 0.00001)
  /// ```
  ///
  /// - Parameters:
  ///     - precedingValue: The value to test.
  ///     - followingValue: The bounds of the range.
  @inlinable public static func ≈ (precedingValue: Self, followingValue: (Self, Self)) -> Bool {
    let range: ClosedRange<Self>
    if followingValue.0 ≥ followingValue.1 {
      range = followingValue.1...followingValue.0
    } else {
      range = followingValue.0...followingValue.1
    }

    return range.contains(precedingValue)
  }
}

@inlinable internal func compareElements<T, C>(
  _ precedingValue: T,
  _ followingValue: T,
  by comparison: (_ value: T) -> C
) -> Bool? where C: Comparable {
  let resolvedPreceding = comparison(precedingValue)
  let resolvedFollowing = comparison(followingValue)
  if resolvedPreceding < resolvedFollowing {
    return true
  } else if resolvedPreceding > resolvedFollowing {
    return false
  } else {
    return nil
  }
}

/// Compares two values according to some derived sort criteria.
///
/// - Parameters:
///   - precedingValue: The value preceding the `<` sign.
///   - followingValue: The value following the `<` sign.
///   - comparison: A closure which returns the derived value to compare.
///   - value: The value for which to derive the sort criterion.
@inlinable public func compare<T, C>(
  _ precedingValue: T,
  _ followingValue: T,
  by comparison: (_ value: T) -> C
) -> Bool where C: Comparable {
  return compareElements(precedingValue, followingValue, by: comparison) ?? false
}

/// Compares two values according to some derived sort criteria.
///
/// This function uses short‐circuit evaluation.
///
/// - Parameters:
///   - precedingValue: The value preceding the `<` sign.
///   - followingValue: The value following the `<` sign.
///   - comparisonOne: A closure which returns the first derived value to compare.
///   - valueOne: The value for which to derive the first sort criterion.
///   - comparisonTwo: A closure which returns the second derived value to compare.
///   - valueTwo: The value for which to derive the second sort criterion.
@inlinable public func compare<T, C, D>(
  _ precedingValue: T,
  _ followingValue: T,
  by comparisonOne: (_ valueOne: T) -> C,
  _ comparisonTwo: (_ valueTwo: T) -> D
) -> Bool
where C: Comparable, D: Comparable {
  return compareElements(precedingValue, followingValue, by: comparisonOne)
    ?? compare(precedingValue, followingValue, by: comparisonTwo)
}

/// Compares two values according to some derived sort criteria.
///
/// This function uses short‐circuit evaluation.
///
/// - Parameters:
///   - precedingValue: The value preceding the `<` sign.
///   - followingValue: The value following the `<` sign.
///   - comparisonOne: A closure which returns the first derived value to compare.
///   - valueOne: The value for which to derive the first sort criterion.
///   - comparisonTwo: A closure which returns the second derived value to compare.
///   - valueTwo: The value for which to derive the second sort criterion.
///   - comparisonThree: A closure which returns the third derived value to compare.
///   - valueThree: The value for which to derive the third sort criterion.
@inlinable public func compare<T, C, D, E>(
  _ precedingValue: T,
  _ followingValue: T,
  by comparisonOne: (_ valueOne: T) -> C,
  _ comparisonTwo: (_ valueTwo: T) -> D,
  _ comparisonThree: (_ valueThree: T) -> E
) -> Bool
where C: Comparable, D: Comparable, E: Comparable {
  return compareElements(precedingValue, followingValue, by: comparisonOne)
    ?? compare(precedingValue, followingValue, by: comparisonTwo, comparisonThree)
}

/// Compares two values according to some derived sort criteria.
///
/// This function uses short‐circuit evaluation.
///
/// - Parameters:
///   - precedingValue: The value preceding the `<` sign.
///   - followingValue: The value following the `<` sign.
///   - comparisonOne: A closure which returns the first derived value to compare.
///   - valueOne: The value for which to derive the first sort criterion.
///   - comparisonTwo: A closure which returns the second derived value to compare.
///   - valueTwo: The value for which to derive the second sort criterion.
///   - comparisonThree: A closure which returns the third derived value to compare.
///   - valueThree: The value for which to derive the third sort criterion.
///   - comparisonFour: A closure which returns the fourth derived value to compare.
///   - valueFour: The value for which to derive the fourth sort criterion.
@inlinable public func compare<T, C, D, E, F>(
  _ precedingValue: T,
  _ followingValue: T,
  by comparisonOne: (_ valueOne: T) -> C,
  _ comparisonTwo: (_ valueTwo: T) -> D,
  _ comparisonThree: (_ valueThree: T) -> E,
  _ comparisonFour: (_ valueFour: T) -> F
) -> Bool
where C: Comparable, D: Comparable, E: Comparable, F: Comparable {
  return compareElements(precedingValue, followingValue, by: comparisonOne)
    ?? compare(precedingValue, followingValue, by: comparisonTwo, comparisonThree, comparisonFour)
}
