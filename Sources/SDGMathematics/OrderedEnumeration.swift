/*
 OrderedEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An enumeration whose cases have a defined order.
///
/// - Requires: `allCases` must have stable indices, and should be O(1).
public protocol OrderedEnumeration: CaseIterable, Comparable, Hashable
where AllCases: BidirectionalCollection {

  /// Increments to the next case.
  ///
  /// - Precondition: There is a valid next case.
  mutating func increment()

  /// Returns the next case or `nil` if there are no later cases.
  func successor() -> Self?

  /// Decrements to the previous case.
  ///
  /// - Precondition: There is a valid previous case.
  mutating func decrement()

  /// Returns the previous case or `nil` if there are no earlier cases.
  func predecessor() -> Self?

  /// Increments to the next case in the cycle.
  ///
  /// - Parameters:
  ///     - wrap: A closure that will be executed if the incrementation wraps around to the beginnig of the sequence.
  mutating func incrementCyclically(_ wrap: () -> Void)

  /// Returns the next case, wrapping around to the first case if necessary.
  func cyclicSuccessor() -> Self

  /// Decrements to the previous case in the cycle.
  ///
  /// - Parameters:
  ///     - wrap: A closure that will be executed if the decrementation wraps around to the end of the sequence.
  mutating func decrementCyclically(_ wrap: () -> Void)

  /// Returns the previous case, wrapping around to the last case if necessary.
  func cyclicPredecessor() -> Self
}

@usableFromInline internal var orderedEnumerationCache = OrderedEnumerationCache()
@usableFromInline internal class OrderedEnumerationCache {
  private var storage: [ObjectIdentifier: Any] = [:]
  private subscript<T>(_ type: T.Type) -> [T: T.AllCases.Index]? where T: OrderedEnumeration {
    get {
      return storage[ObjectIdentifier(type)] as? [T: T.AllCases.Index]
    }
    set {
      storage[ObjectIdentifier(type)] = newValue
    }
  }
  @usableFromInline internal func mapping<T>(for type: T.Type) -> [T: T.AllCases.Index]
  where T: OrderedEnumeration {
    return cached(in: &self[T.self]) {
      var result: [T: T.AllCases.Index] = [:]
      let cases = T.allCases
      for index in cases.indices {
        let `case` = cases[index]
        result[`case`] = index
      }
      return result
    }
  }
}

extension OrderedEnumeration {

  @inlinable internal static func index(of `case`: Self) -> AllCases.Index {
    return orderedEnumerationCache.mapping(for: Self.self)[`case`]!
  }

  @inlinable internal mutating func _increment() {
    guard let result = successor() else {
      _preconditionFailure({ [instance = self] (localization: _APILocalization) -> String in
        switch localization {
        case .englishCanada:  // @exempt(from: tests)
          return "“\(instance)” has no successor."
        }
      })
    }
    self = result
  }
  @inlinable public mutating func increment() {
    _increment()
  }

  @inlinable internal func _successor() -> Self? {
    let successorIndex = Self.allCases.index(after: Self.index(of: self))
    if successorIndex == Self.allCases.endIndex {
      return nil
    } else {
      return Self.allCases[successorIndex]
    }
  }
  @inlinable public func successor() -> Self? {
    return _successor()
  }

  @inlinable internal mutating func _decrement() {
    guard let result = predecessor() else {
      _preconditionFailure({ [instance = self] (localization: _APILocalization) -> String in
        switch localization {
        case .englishCanada:  // @exempt(from: tests)
          return "“\(instance)” has no predecessor."
        }
      })
    }
    self = result
  }
  @inlinable public mutating func decrement() {
    _decrement()
  }

  @inlinable internal func _predecessor() -> Self? {
    let index = Self.index(of: self)
    if index == Self.allCases.startIndex {
      return nil
    } else {
      return Self.allCases[Self.allCases.index(before: index)]
    }
  }
  @inlinable public func predecessor() -> Self? {
    return _predecessor()
  }

  @inlinable public mutating func incrementCyclically(_ wrap: () -> Void = {}) {
    if let next = successor() {
      self = next
    } else {
      wrap()
      self = Self.allCases.first!
    }
  }

  @inlinable public func cyclicSuccessor() -> Self {
    return nonmutatingVariant(of: { $0.incrementCyclically($1) }, on: self, with: {})
  }

  @inlinable public mutating func decrementCyclically(_ wrap: () -> Void = {}) {
    if let previous = predecessor() {
      self = previous
    } else {
      wrap()
      self = Self.allCases.last!
    }
  }

  @inlinable public func cyclicPredecessor() -> Self {
    return nonmutatingVariant(of: { $0.decrementCyclically($1) }, on: self, with: {})
  }

  // MARK: - Comparable

  @inlinable internal func isLessThan(_ other: Self) -> Bool {
    return compare(self, other) { Self.index(of: $0) }
  }
  @inlinable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.isLessThan(followingValue)
  }
}

// Disambiguate Strideable vs OrderedEnumeration for calendar components.
extension OrderedEnumeration where Self: Strideable {

  // MARK: - Comparable

  @inlinable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.isLessThan(followingValue)
  }
}

// Disambiguate OneDimensionalPoint vs OrderedEnumeration for calendar components.
extension OrderedEnumeration where Self: OneDimensionalPoint, Self.Vector: IntegerProtocol {

  @inlinable public mutating func increment() {
    _increment()
  }

  @inlinable public func successor() -> Self? {
    return _successor()
  }

  @inlinable public mutating func decrement() {
    _decrement()
  }

  @inlinable public func predecessor() -> Self? {
    return _predecessor()
  }
}
