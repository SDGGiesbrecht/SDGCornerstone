/*
 MutableSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A mutable set.
public protocol MutableSet: ComparableSet, SetAlgebra {

  /// Creates an empty set.
  init()

  /// Inserts `member` into `self` if it is not already present.
  ///
  /// - Parameters:
  ///   - newMember: The element to insert.
  ///
  /// - Returns: A tuple with two elements:
  ///   - `inserted`: Whether or not the element was inserted.
  ///   - `newMember`: The element in the set after the insertion attempt.
  @discardableResult mutating func insert(_ newMember: Self.Element) -> (
    inserted: Bool, memberAfterInsert: Self.Element
  )

  /// Removes `member` from `self` if it is present.
  ///
  /// - Parameters:
  ///   - member: The element to remove.
  ///
  /// - Returns: The element removed, or `nil` if there was nothing to remove.
  @discardableResult mutating func remove(_ member: Self.Element) -> Self.Element?

  /// Inserts the value into the set uncoditionally.
  ///
  /// - Parameters:
  ///   - newMember: The value to insert.
  ///
  /// - Returns: The equal element previously in the set, if there was one.
  @discardableResult mutating func update(with newMember: Element) -> Element?

  // #documentation(SDGCornerstone.SetDefinition.∩)
  /// Returns the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∩ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element

  // #documentation(SDGCornerstone.SetDefinition.∩)
  /// Returns the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∩ (precedingValue: Self, followingValue: Self) -> Self

  /// Sets `precedingValue` to the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∩= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element

  // @documentation(MutableSet.∩=)
  /// Sets `precedingValue` to the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∩= (precedingValue: inout Self, followingValue: Self)

  // #documentation(SDGCornerstone.SetDefinition.∪)
  /// Returns the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∪ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element

  // #documentation(SDGCornerstone.SetDefinition.∪)
  /// Returns the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∪ (precedingValue: Self, followingValue: Self) -> Self

  // @documentation(MutableSet.∪=)
  /// Sets `precedingValue` to the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∪= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element

  // #documentation(MutableSet.∪=)
  /// Sets `precedingValue` to the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∪= (precedingValue: inout Self, followingValue: Self)

  // #documentation(SDGCornerstone.SetDefinition.∖)
  /// Returns the relative complement of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  static func ∖ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element

  // #documentation(SDGCornerstone.SetDefinition.∖)
  /// Returns the relative complement of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  static func ∖ (precedingValue: Self, followingValue: Self) -> Self

  // @documentation(SDGCornerstone.SetDefinition.∖=)
  /// Subtracts `followingValue` from `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  static func ∖= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element

  /// Subtracts `followingValue` from `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  static func ∖= (precedingValue: inout Self, followingValue: Self)

  // #documentation(SDGCornerstone.SetDefinition.∆)
  /// Returns the symmetric difference of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∆ (precedingValue: Self, followingValue: Self) -> Self

  // @documentation(SDGCornerstone.MutableSet.∆=)
  /// Sets `precedingValue` to the symmetric difference of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  static func ∆= (precedingValue: inout Self, followingValue: Self)
}

extension MutableSet {

  // #documentation(SDGCornerstone.SetDefinition.∩)
  /// Returns the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∩ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element {
    return nonmutatingVariant(of: ∩=, on: precedingValue, with: followingValue)
  }

  // #documentation(SDGCornerstone.SetDefinition.∩)
  /// Returns the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∩ (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: ∩=, on: precedingValue, with: followingValue)
  }

  // #documentation(MutableSet.∩=)
  /// Sets `precedingValue` to the intersection of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∩= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element {
    var result = Self()
    for element in followingValue where element ∈ precedingValue {
      result.insert(element)
    }
    precedingValue = result
  }

  // #documentation(SDGCornerstone.SetDefinition.∪)
  /// Returns the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∪ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element {
    return nonmutatingVariant(of: ∪=, on: precedingValue, with: followingValue)
  }

  // #documentation(SDGCornerstone.SetDefinition.∪)
  /// Returns the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∪ (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: ∪=, on: precedingValue, with: followingValue)
  }

  // #documentation(MutableSet.∪=)
  /// Sets `precedingValue` to the union of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∪= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element {
    for element in followingValue {
      precedingValue.insert(element)
    }
  }

  // #documentation(SDGCornerstone.SetDefinition.∖)
  /// Returns the relative complement of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  @inlinable public static func ∖ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element {
    return nonmutatingVariant(of: ∖=, on: precedingValue, with: followingValue)
  }

  // #documentation(SDGCornerstone.SetDefinition.∖)
  /// Returns the relative complement of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  @inlinable public static func ∖ (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: ∖=, on: precedingValue, with: followingValue)
  }

  // #documentation(SDGCornerstone.SetDefinition.∖=)
  /// Subtracts `followingValue` from `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: The set to subtract from.
  ///   - followingValue: The set to subtract.
  @inlinable public static func ∖= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element {
    for element in followingValue {
      precedingValue.remove(element)
    }
  }

  @inlinable public static func ∆ (precedingValue: Self, followingValue: Self) -> Self {
    return nonmutatingVariant(of: ∆=, on: precedingValue, with: followingValue)
  }

  @inlinable public static func ∆= (precedingValue: inout Self, followingValue: Self) {
    var result = precedingValue
    result ∪= followingValue
    result ∖= precedingValue ∩ followingValue
    precedingValue = result
  }

  // MARK: - SetAlgebra

  @inlinable public func intersection(_ other: Self) -> Self {
    return self ∩ other
  }

  @inlinable public mutating func formIntersection(_ other: Self) {
    self ∩= other
  }

  @inlinable public func union(_ other: Self) -> Self {
    return self ∪ other
  }

  @inlinable public mutating func formUnion(_ other: Self) {
    self ∪= other
  }

  @inlinable public func symmetricDifference(_ other: Self) -> Self {
    return self ∆ other
  }

  @inlinable public mutating func formSymmetricDifference(_ other: Self) {
    self ∆= other
  }
}

extension MutableSet where Self: FiniteSet {

  // #documentation(SDGCornerstone.SetDefinition.∆)
  /// Returns the symmetric difference of `followingValue` in `precedingValue`.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∆ <S: FiniteSet>(precedingValue: Self, followingValue: S) -> Self
  where S.Element == Self.Element {
    return nonmutatingVariant(of: ∆=, on: precedingValue, with: followingValue)
  }

  // #documentation(SDGCornerstone.MutableSet.∆=)
  /// Sets `precedingValue` to the symmetric difference of the two sets.
  ///
  /// - Parameters:
  ///   - precedingValue: A set.
  ///   - followingValue: Another set.
  @inlinable public static func ∆= <S: FiniteSet>(precedingValue: inout Self, followingValue: S)
  where S.Element == Self.Element {
    var result = precedingValue
    result ∪= followingValue
    result ∖= precedingValue ∩ followingValue
    precedingValue = result
  }
}
