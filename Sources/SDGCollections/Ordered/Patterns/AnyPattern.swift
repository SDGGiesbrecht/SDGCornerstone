/*
 AnyPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type‐erased pattern.
///
/// - Note: The indirection used by `AnyPattern` can negatively affect performance. While use of `AnyPattern` is sometimes necessitated by the type system, it is recommended to use other strategies when possible.
public struct AnyPattern<Element>: Pattern, TransparentWrapper where Element: Equatable {

  // MARK: - Initialization

  /// Creates a type erased instance of a pattern.
  ///
  /// - Parameters:
  ///     - pattern: The pattern.
  @inlinable public init<P>(_ pattern: P) where P: Pattern, P.Element == Element {
    matches = { pattern.matches(in: $0, at: $1) }
    primaryMatch = { pattern.primaryMatch(in: $0, at: $1) }
    wrappedInstance = pattern
    reversedPattern = { AnyPattern(pattern.reversed()) }
  }

  // MARK: - Properties

  @usableFromInline internal let matches: (AnyCollection<Element>, AnyIndex) -> [Range<AnyIndex>]
  @usableFromInline internal let primaryMatch:
    (AnyCollection<Element>, AnyIndex) -> Range<AnyIndex>?
  @usableFromInline internal let reversedPattern: () -> AnyPattern<Element>

  // MARK: - Pattern

  @inlinable internal func extract<C>(
    index anyIndex: AnyIndex,
    relativeTo equivalentIndices: (any: AnyIndex, concrete: C.Index),
    in anyCollection: AnyCollection<Element>,
    for collection: C
  ) -> C.Index where C: SearchableCollection {
    let offset = anyCollection.distance(from: equivalentIndices.any, to: anyIndex)
    return collection.index(equivalentIndices.concrete, offsetBy: offset)
  }

  @inlinable internal func extract<C>(
    range anyRange: Range<AnyIndex>,
    relativeTo equivalentIndices: (any: AnyIndex, concrete: C.Index),
    in anyCollection: AnyCollection<Element>,
    for collection: C
  ) -> Range<C.Index> where C: SearchableCollection {
    return anyRange.map { anyIndex in
      return extract(
        index: anyIndex,
        relativeTo: equivalentIndices,
        in: anyCollection,
        for: collection
      )
    }
  }

  @inlinable public func matches<C: SearchableCollection>(in collection: C, at location: C.Index)
    -> [Range<C.Index>] where C.Element == Element
  {
    let anyCollection = AnyCollection(collection)
    let anyLocation = AnyIndex(location)
    let anyResult = matches(anyCollection, anyLocation)
    return anyResult.map { anyRange in
      return extract(
        range: anyRange,
        relativeTo: (anyLocation, location),
        in: anyCollection,
        for: collection
      )
    }
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Element {
    let anyCollection = AnyCollection(collection)
    let anyLocation = AnyIndex(location)
    let anyResult = primaryMatch(anyCollection, anyLocation)
    return anyResult.map { anyRange in
      return extract(
        range: anyRange,
        relativeTo: (anyLocation, location),
        in: anyCollection,
        for: collection
      )
    }
  }

  @inlinable public func reversed() -> AnyPattern<Element> {
    return reversedPattern()
  }

  // MARK: - TransparentWrapper

  public let wrappedInstance: Any
}
