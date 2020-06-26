/*
 ConcatenatedPatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against a pair of component patterns contiguously.
public struct ConcatenatedPatterns<First, Second>: Pattern, CustomStringConvertible,
  TextualPlaygroundDisplay
where First: Pattern, Second: Pattern, First.Element == Second.Element {

  // MARK: - Initialization

  /// Creates a pattern from a pair of component patterns.
  ///
  /// - Parameters:
  ///     - first: The first pattern.
  ///     - second: The second pattern.
  @inlinable public init(_ first: First, _ second: Second) {
    self.first = first
    self.second = second
  }

  // MARK: - Properties

  @usableFromInline internal var first: First
  @usableFromInline internal var second: Second

  // MARK: - Pattern

  public typealias Element = First.Element

  @inlinable public func matches<C: SearchableCollection>(in collection: C, at location: C.Index)
    -> [Range<C.Index>] where C.Element == Element
  {
    var endIndices: [C.Index] = [location]
    ConcatenationPatterning.advance(ends: &endIndices, for: first, in: collection)
    if endIndices.isEmpty { return [] }
    ConcatenationPatterning.advance(ends: &endIndices, for: second, in: collection)
    return endIndices.map { location..<$0 }
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Element {
    var endIndices: [C.Index] = [location]
    ConcatenationPatterning.advance(ends: &endIndices, for: first, in: collection)
    if endIndices.isEmpty { return nil }
    ConcatenationPatterning.advance(ends: &endIndices, for: second, in: collection)
    return endIndices.first.map { location..<$0 }
  }

  @inlinable public func reversed() -> ConcatenatedPatterns<Second.Reversed, First.Reversed> {
    return ConcatenatedPatterns<Second.Reversed, First.Reversed>(
      second.reversed(),
      first.reversed()
    )
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "(\(String(describing: first))) + (\(String(describing: second)))"
  }
}

// Shared with N‐ary variant.
@usableFromInline internal enum ConcatenationPatterning {
  @inlinable internal static func advance<P, C>(
    ends endIndices: inout [C.Index],
    for pattern: P,
    in collection: C
  )
  where P: Pattern, C: SearchableCollection, C.Element == P.Element {
    var result: [Range<C.Index>] = []
    for index in endIndices {
      result.append(contentsOf: pattern.matches(in: collection, at: index))
    }
    endIndices = result.map({ $0.upperBound })
  }
}
