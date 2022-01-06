/*
 AlternativePatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against a pair of alternative patterns.
///
/// The order of the alternatives is significant. If both alternatives match, preference will be given to the first one.
public struct AlternativePatterns<First, Second>: CustomStringConvertible, Pattern,
  TextualPlaygroundDisplay
where First: Pattern, Second: Pattern, First.Element == Second.Element {

  // MARK: - Initialization

  /// Creates a pair of alternative patterns.
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
    var results: [Range<C.Index>] = []
    results.append(contentsOf: first.matches(in: collection, at: location))
    results.append(contentsOf: second.matches(in: collection, at: location))
    return results
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Element {
    return first.primaryMatch(in: collection, at: location)
      ?? second.primaryMatch(in: collection, at: location)
  }

  @inlinable public func reversed() -> AlternativePatterns<First.Reversed, Second.Reversed> {
    return AlternativePatterns<First.Reversed, Second.Reversed>(first.reversed(), second.reversed())
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "(\(String(describing: first))) ∨ (\(String(describing: second)))"
  }
}
