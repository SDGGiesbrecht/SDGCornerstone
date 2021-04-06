/*
 OrderedSet + Deprecation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import OrderedCollections

import SDGControlFlow
import SDGLogic

/// An ordered collection of elements that guarantees the uniqueness of its elements.
@available(
  *,
  deprecated,
  message: "Use OrderedCollections.OrderedSet from the swift‐collections package instead."
)
public struct OrderedSet<Element>: ComparableSet, ExpressibleByArrayLiteral, FiniteSet, Hashable,
  RandomAccessCollection, SearchableBidirectionalCollection, SetDefinition, TransparentWrapper
where Element: Hashable {

  // MARK: - Initialization

  /// Creates an empty set.
  @inlinable public init() {
    implementation = OrderedCollections.OrderedSet()
  }

  /// Creates an ordered set from the contents of a sequence.
  ///
  /// If an element occurs more than once, only the first will be included.
  ///
  /// - Parameters:
  ///   - elements: The elements to include.
  @inlinable public init<S>(_ elements: S) where S: Sequence, S.Element == Element {
    implementation = OrderedCollections.OrderedSet(elements)
  }

  // MARK: - Properties

  @usableFromInline internal var implementation: OrderedCollections.OrderedSet<Element>

  // MARK: - Usage

  /// The contents of the set as an array.
  @inlinable public var contents: [Element] {
    return implementation.elements
  }

  /// Appends a new element to the set if it is not already present.
  ///
  /// - Parameters:
  ///   - newElement: The element to append.
  ///
  /// - Returns: Whether or not the element was appended.
  @inlinable @discardableResult public mutating func append(_ newElement: Element) -> Bool {
    return implementation.append(newElement).inserted
  }

  /// Appends new elements to the set if they are not already present.
  ///
  /// - Parameters:
  ///   - newElements: The elements to append.
  @inlinable public mutating func append<S>(
    contentsOf newElements: S
  ) where S: Sequence, S.Element == Element {
    implementation.append(contentsOf: newElements)
  }

  /// Removes and returns the first element.
  @inlinable @discardableResult public mutating func removeFirst() -> Element {
    return implementation.removeFirst()
  }

  /// Removes and returns the last element.
  @inlinable @discardableResult public mutating func removeLast() -> Element {
    return implementation.removeLast()
  }

  /// Removes all elements.
  ///
  /// - Parameters:
  ///   - keepCapacity: Whether or not to keep the memory capacity.
  @inlinable public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    implementation.removeAll(keepingCapacity: keepCapacity)
  }

  /// Removes and returns a particular element.
  ///
  /// - Parameters:
  ///   - element: The element to remove.
  @inlinable @discardableResult public mutating func remove(_ element: Element) -> Element? {
    return implementation.remove(element)
  }

  // MARK: - Collection

  @inlinable public var startIndex: Array<Element>.Index {
    return implementation.startIndex
  }

  @inlinable public var endIndex: Array<Element>.Index {
    return implementation.endIndex
  }

  @inlinable public subscript(position: Array<Element>.Index) -> Element {
    return implementation[position]
  }

  // MARK: - ComparableSet

  @inlinable public static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.implementation.isSubset(of: followingValue.implementation)
  }

  @inlinable public static func ⊇ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.implementation.isSuperset(of: followingValue.implementation)
  }

  @inlinable public static func ⊊ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.implementation.unordered
      .isStrictSubset(of: followingValue.implementation.unordered)
  }

  @inlinable public static func ⊋ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.implementation.unordered
      .isStrictSuperset(of: followingValue.implementation.unordered)
  }

  @inlinable public func overlaps(_ other: Self) -> Bool {
    return ¬implementation.isDisjoint(with: other.implementation)
  }

  @inlinable public func isDisjoint(with other: Self) -> Bool {
    return implementation.isDisjoint(with: other.implementation)
  }

  // MARK: - Equatable

  @inlinable public static func == (
    precedingValue: OrderedSet,
    followingValue: OrderedSet
  ) -> Bool {
    return precedingValue.implementation == followingValue.implementation
  }

  // MARK: - ExpressibleByArrayLiteral

  @inlinable public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }

  // MARK: - Hashable

  @inlinable public func hash(into hasher: inout Hasher) {
    hasher.combine(implementation)
  }

  // MARK: - SetDefinition

  @inlinable public static func ∋ (precedingValue: Self, followingValue: Element) -> Bool {
    return precedingValue.implementation.contains(followingValue)
  }

  // MARK: - TransparentWrapper

  @inlinable public var wrappedInstance: Any {
    return implementation
  }
}

@available(
  *,
  deprecated,
  message: "Use OrderedCollections.OrderedSet from the swift‐collections package instead."
)
extension OrderedSet: Comparable where Element: Comparable {

  // MARK: - Comparable

  @inlinable public static func < (precedingValue: OrderedSet, followingValue: OrderedSet) -> Bool {
    return precedingValue.implementation.elements
      .lexicographicallyPrecedes(followingValue.implementation.elements)
  }
}
