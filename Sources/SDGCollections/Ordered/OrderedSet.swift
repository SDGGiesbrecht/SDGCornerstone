/*
 OrderedSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Audit.")
import OrderedCollections

import SDGLogic

extension OrderedCollections.OrderedSet: ComparableSet, FiniteSet,
  SearchableBidirectionalCollection, SetDefinition
{

  // MARK: - ComparableSet

  @inlinable public static func ⊆ (
    precedingValue: OrderedCollections.OrderedSet<Element>,
    followingValue: OrderedCollections.OrderedSet<Element>
  ) -> Bool {
    return precedingValue.isSubset(of: followingValue)
  }

  @inlinable public static func ⊇ (
    precedingValue: OrderedCollections.OrderedSet<Element>,
    followingValue: OrderedCollections.OrderedSet<Element>
  ) -> Bool {
    return precedingValue.isSuperset(of: followingValue)
  }

  @inlinable public static func ⊊ (
    precedingValue: OrderedCollections.OrderedSet<Element>,
    followingValue: OrderedCollections.OrderedSet<Element>
  ) -> Bool {
    return precedingValue.unordered
      .isStrictSubset(of: followingValue.unordered)
  }

  @inlinable public static func ⊋ (
    precedingValue: OrderedCollections.OrderedSet<Element>,
    followingValue: OrderedCollections.OrderedSet<Element>
  ) -> Bool {
    return precedingValue.unordered
      .isStrictSuperset(of: followingValue.unordered)
  }

  @inlinable public func overlaps(_ other: OrderedCollections.OrderedSet<Element>) -> Bool {
    return ¬isDisjoint(with: other)
  }

  // MARK: - SetDefinition

  @inlinable public static func ∋ (
    precedingValue: OrderedCollections.OrderedSet<Element>,
    followingValue: Element
  ) -> Bool {
    return precedingValue.contains(followingValue)
  }
}
