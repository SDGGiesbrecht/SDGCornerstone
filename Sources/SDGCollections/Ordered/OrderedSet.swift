/*
 OrderedSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An ordered collection of elements that guarantees the uniqueness of its elements.
public struct OrderedSet<Element>: ComparableSet, ExpressibleByArrayLiteral, FiniteSet, Hashable,
  RandomAccessCollection, SearchableBidirectionalCollection, SetDefinition, TransparentWrapper
where Element: Hashable {

  // MARK: - Initialization

  /// Creates an empty set.
  @inlinable public init() {
    array = []
    set = []
  }

  /// Creates an ordered set from the contents of a sequence.
  ///
  /// If an element occurs more than once, only the first will be included.
  ///
  /// - Parameters:
  ///   - elements: The elements to include.
  @inlinable public init<S>(_ elements: S) where S: Sequence, S.Element == Element {
    self.init()
    self.append(contentsOf: elements)
  }

  // MARK: - Properties

  @usableFromInline internal var array: [Element]
  @usableFromInline internal var set: Set<Element>

  // MARK: - Usage

  /// The contents of the set as an array.
  @inlinable public var contents: [Element] {
    return array
  }

  /// Appends a new element to the set if it is not already present.
  ///
  /// - Parameters:
  ///   - newElement: The element to append.
  ///
  /// - Returns: Whether or not the element was appended.
  @inlinable @discardableResult public mutating func append(_ newElement: Element) -> Bool {
    let inserted = set.insert(newElement).inserted
    if inserted {
      array.append(newElement)
    }
    return inserted
  }

  /// Appends new elements to the set if they are not already present.
  ///
  /// - Parameters:
  ///   - newElements: The elements to append.
  @inlinable public mutating func append<S>(
    contentsOf newElements: S
  ) where S: Sequence, S.Element == Element {
    for element in newElements {
      self.append(element)
    }
  }

  /// Removes and returns the first element.
  @inlinable @discardableResult public mutating func removeFirst() -> Element {
    let first = array.removeFirst()
    set.remove(first)
    return first
  }

  /// Removes and returns the last element.
  @inlinable @discardableResult public mutating func removeLast() -> Element {
    let last = array.removeLast()
    set.remove(last)
    return last
  }

  /// Removes all elements.
  ///
  /// - Parameters:
  ///   - keepCapacity: Whether or not to keep the memory capacity.
  @inlinable public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    array.removeAll(keepingCapacity: keepCapacity)
    set.removeAll(keepingCapacity: keepCapacity)
  }

  /// Removes and returns a particular element.
  ///
  /// - Parameters:
  ///   - element: The element to remove.
  @inlinable @discardableResult public mutating func remove(_ element: Element) -> Element? {
    guard let removed = set.remove(element) else {
      return nil
    }
    let index = array.firstIndex(of: removed)!
    array.remove(at: index)
    return removed
  }

  // MARK: - Collection

  @inlinable public var startIndex: Array<Element>.Index {
    return array.startIndex
  }

  @inlinable public var endIndex: Array<Element>.Index {
    return array.endIndex
  }

  @inlinable public subscript(position: Array<Element>.Index) -> Element {
    return array[position]
  }

  // MARK: - ComparableSet

  @inlinable public static func ⊆ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.set ⊆ followingValue.set
  }

  @inlinable public static func ⊇ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.set ⊇ followingValue.set
  }

  @inlinable public static func ⊊ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.set ⊊ followingValue.set
  }

  @inlinable public static func ⊋ (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.set ⊋ followingValue.set
  }

  @inlinable public func overlaps(_ other: Self) -> Bool {
    return set.overlaps(other.set)
  }

  @inlinable public func isDisjoint(with other: Self) -> Bool {
    return set.isDisjoint(with: other.set)
  }

  // MARK: - Equatable

  @inlinable public static func == (precedingValue: OrderedSet, followingValue: OrderedSet) -> Bool
  {
    return precedingValue.array == followingValue.array
  }

  // MARK: - ExpressibleByArrayLiteral

  @inlinable public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }

  // MARK: - Hashable

  @inlinable public func hash(into hasher: inout Hasher) {
    hasher.combine(array)
  }

  // MARK: - SetDefinition

  @inlinable public static func ∋ (precedingValue: Self, followingValue: Element) -> Bool {
    return precedingValue.set ∋ followingValue
  }

  // MARK: - TransparentWrapper

  @inlinable public var wrappedInstance: Any {
    return contents
  }
}

extension OrderedSet: Comparable where Element: Comparable {

  // MARK: - Comparable

  @inlinable public static func < (precedingValue: OrderedSet, followingValue: OrderedSet) -> Bool {
    return precedingValue.array.lexicographicallyPrecedes(followingValue.array)
  }
}
