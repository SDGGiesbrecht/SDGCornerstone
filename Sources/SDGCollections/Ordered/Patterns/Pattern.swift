/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A pattern that can be searched for in collections with equatable elements.
public protocol Pattern
where Searchable == Match.Searched {

  #warning("Is this necessary? (It is just an alias anyway.)")
  /// The searchable collection
  associatedtype Searchable

  /// The type of a match for the pattern.
  associatedtype Match: PatternMatch

  #warning("Deferred.")/*
  /// The type of the reverse pattern.
  associatedtype Reversed: Pattern where Reversed.Element == Self.Element*/

  /// Returns the ranges of possible matches beginning at the specified index in the collection.
  ///
  /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
  ///
  /// - Parameters:
  ///     - collection: The collection in which to search.
  ///     - location: The index at which to check for the beginning of a match.
  func matches(in collection: Searchable, at location: Searchable.Index) -> [Match]

  /// Returns the primary match beginning at the specified index in the collection.
  ///
  /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
  ///
  /// - Parameters:
  ///     - collection: The collection in which to search.
  ///     - location: The index at which to check for the beginning of a match.
  func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> Match?

  #warning("Deferred.")/*
  /// Retruns a pattern that checks for the reverse pattern.
  ///
  /// This is suitable for performing backward searches by applying it to the reversed collection.
  func reversed() -> Reversed*/
}

extension Pattern {

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> Match? {
    return matches(in: collection, at: location).first
  }

  // MARK: - Composition

  #warning("Temporarily disabled.")/*
  /// Combines two patterns into a single pattern by concatenating them.
  ///
  /// See the `ConcatenatedPatterns` type for details.
  ///
  /// - Parameters:
  ///     - precedingValue: The first pattern.
  ///     - followingValue: The second pattern.
  @inlinable public static func + <Other>(
    precedingValue: Self,
    followingValue: Other
  ) -> ConcatenatedPatterns<Self, Other> {
    return ConcatenatedPatterns(precedingValue, followingValue)
  }

  /// Combines two patterns into a single pattern that will match either.
  ///
  /// See the `AlternativePatterns` type for details.
  ///
  /// - Parameters:
  ///     - precedingValue: The first pattern.
  ///     - followingValue: The second pattern.
  @inlinable public static func ∨ <Other>(
    precedingValue: Self,
    followingValue: Other
  ) -> AlternativePatterns<Self, Other> {
    return AlternativePatterns(precedingValue, followingValue)
  }

  /// Creates a negated pattern from another pattern.
  ///
  /// See the `NegatedPattern` type for details.
  ///
  /// - Parameters:
  ///     - operand: The pattern to negate.
  @inlinable public static prefix func ¬ (operand: Self) -> NegatedPattern<Self> {
    return NegatedPattern(operand)
  }*/

  // MARK: - Switch Expression Pattern

  #warning("Temporarily disabled.")/*
  // #example(1, patternSwitch)
  /// Enables use of any set pattern in switch cases.
  ///
  /// ```swift
  /// switch "This is a string." {
  /// case RepetitionPattern("."):
  ///   XCTFail("This case does not match.")
  /// case RepetitionPattern(¬".") + ".":
  ///   print("This case does match.")
  /// default:
  ///   XCTFail("This case is never reached.")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///     - pattern: The pattern to match against.
  ///     - value: The value to check.
  @inlinable public static func ~= <C: SearchableCollection>(pattern: Self, value: C) -> Bool
  where C.Element == Element {
    return value.isMatch(for: pattern)
  }*/
}
