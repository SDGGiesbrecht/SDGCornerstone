/*
 FiniteSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A set small enough to reasonably iterate over.
public protocol FiniteSet: Collection, ComparableSet {

  // @documentation(SDGCornerstone.FiniteSet.⊆)
  // #documentation(SDGCornerstone.ComparableSet.⊆)
  /// Returns `true` if `precedingValue` is a subset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible subset to test.
  ///   - followingValue: The other set.
  static func ⊆ <S: SetDefinition>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.⊈)
  // #documentation(SDGCornerstone.ComparableSet.⊈)
  /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible subset to test.
  ///   - followingValue: The other set.
  static func ⊈ <S: SetDefinition>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.⊇)
  // #documentation(SDGCornerstone.ComparableSet.⊇)
  /// Returns `true` if `precedingValue` is a superset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible superset to test.
  ///   - followingValue: The other set.
  static func ⊇ <S: SetDefinition>(precedingValue: S, followingValue: Self) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.⊉)
  // #documentation(SDGCornerstone.ComparableSet.⊉)
  /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible superset to test.
  ///   - followingValue: The other set.
  static func ⊉ <S: SetDefinition>(precedingValue: S, followingValue: Self) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.⊊)
  // #documentation(SDGCornerstone.ComparableSet.⊊)
  /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible subset to test.
  ///   - followingValue: The other set.
  static func ⊊ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.⊋)
  // #documentation(SDGCornerstone.ComparableSet.⊋)
  /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible superset to test.
  ///   - followingValue: The other set.
  static func ⊋ <S: FiniteSet>(precedingValue: S, followingValue: Self) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.==)
  /// Returns `true` if the two values are equal.
  ///
  /// - Parameters:
  ///   - precedingValue: A value to compare.
  ///   - followingValue: Another value to compare.
  static func == <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.≠)
  // #documentation(SDGCornerstone.Equatable.≠)
  /// Returns `true` if the two values are inequal.
  ///
  /// - Parameters:
  ///   - precedingValue: A value to compare.
  ///   - followingValue: Another value to compare.
  static func ≠ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.overlaps(_:))
  // #documentation(SDGCornerstone.ComparableSet.overlaps(_:))
  /// Returns `true` if the sets overlap.
  ///
  /// - Parameters:
  ///   - other: The other set.
  func overlaps<S: SetDefinition>(_ other: S) -> Bool where S.Element == Self.Element

  // @documentation(SDGCornerstone.FiniteSet.isDisjoint(with:))
  // #documentation(SDGCornerstone.ComparableSet.isDisjoint(with:))
  /// Returns `true` if the sets are disjoint.
  ///
  /// - Parameters:
  ///   - other: Another set.
  func isDisjoint<S: FiniteSet>(with other: S) -> Bool where S.Element == Self.Element
}

extension FiniteSet {

  // #documentation(SDGCornerstone.FiniteSet.⊆)
  /// Returns `true` if `precedingValue` is a subset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible subset to test.
  ///   - followingValue: The other set.
  @inlinable public static func ⊆ <S: SetDefinition>(
    precedingValue: Self,
    followingValue: S
  ) -> Bool where S.Element == Self.Element {
    for element in precedingValue where element ∉ followingValue {
      return false
    }
    return true
  }

  // #documentation(SDGCornerstone.FiniteSet.⊈)
  /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible subset to test.
  ///   - followingValue: The other set.
  @inlinable public static func ⊈ <S: SetDefinition>(
    precedingValue: Self,
    followingValue: S
  ) -> Bool where S.Element == Self.Element {
    return ¬(precedingValue ⊆ followingValue)
  }

  // #documentation(SDGCornerstone.FiniteSet.⊇)
  /// Returns `true` if `precedingValue` is a superset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible superset to test.
  ///   - followingValue: The other set.
  @inlinable public static func ⊇ <S: SetDefinition>(
    precedingValue: S,
    followingValue: Self
  ) -> Bool where S.Element == Self.Element {
    return followingValue ⊆ precedingValue
  }

  // #documentation(SDGCornerstone.FiniteSet.⊉)
  /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible superset to test.
  ///   - followingValue: The other set.
  @inlinable public static func ⊉ <S: SetDefinition>(
    precedingValue: S,
    followingValue: Self
  ) -> Bool where S.Element == Self.Element {
    return ¬(precedingValue ⊇ followingValue)
  }

  // #documentation(SDGCornerstone.FiniteSet.⊊)
  /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible subset to test.
  ///   - followingValue: The other set.
  @inlinable public static func ⊊ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element {
    return precedingValue ⊆ followingValue ∧ precedingValue ⊉ followingValue
  }

  // #documentation(SDGCornerstone.FiniteSet.⊋)
  /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The possible superset to test.
  ///   - followingValue: The other set.
  @inlinable public static func ⊋ <S: FiniteSet>(precedingValue: S, followingValue: Self) -> Bool
  where S.Element == Self.Element {
    return precedingValue ⊇ followingValue ∧ precedingValue ⊈ followingValue
  }

  @inlinable public static func == <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element {
    return precedingValue ⊇ followingValue ∧ precedingValue ⊆ followingValue
  }

  @inlinable public static func ≠ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Bool
  where S.Element == Self.Element {
    return ¬(precedingValue == followingValue)
  }

  @inlinable public func overlaps<S: SetDefinition>(_ other: S) -> Bool
  where S.Element == Self.Element {
    for element in self where element ∈ other {
      return true
    }
    return false
  }

  @inlinable public func isDisjoint<S: SetDefinition>(with other: S) -> Bool
  where S.Element == Self.Element {
    return ¬overlaps(other)
  }
}
