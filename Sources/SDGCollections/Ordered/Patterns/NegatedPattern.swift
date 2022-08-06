/*
 NegatedPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches if the underlying pattern does not.
public struct NegatedPattern<Base>: CustomStringConvertible, Pattern, TextualPlaygroundDisplay
where Base: Pattern {

  // MARK: - Initialization

  // @documentation(SDGCornerstone.Not.init(_:))
  /// Creates a negated pattern from another pattern.
  ///
  /// - Parameters:
  ///     - pattern: The underlying pattern to negate.
  @inlinable public init(_ pattern: Base) {
    self.base = pattern
  }

  // MARK: - Properties

  @usableFromInline internal var base: Base

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<Base.Searchable>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [AtomicPatternMatch<Searchable>] {
    return primaryMatch(in: collection, at: location).map({ [$0] }) ?? []
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AtomicPatternMatch<Searchable>? {
    if base.primaryMatch(in: collection, at: location) == nil {
      return AtomicPatternMatch(
        range: (location...location).relative(to: collection),
        in: collection
      )
    } else {
      return nil
    }
  }

  @inlinable public func forSubSequence() -> NegatedPattern<Base.SubSequencePattern> {
    return NegatedPattern<Base.SubSequencePattern>(base.forSubSequence())
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<Searchable.SubSequence>,
    in collection: Searchable
  ) -> AtomicPatternMatch<Searchable> {
    // #workaround(Swift 5.6.1, Should be commented line instead, but for compiler bug.)
    return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
    // return subSequenceMatch.in(collection)
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "¬(" + String(describing: base) + ")"
  }
}

extension NegatedPattern: BidirectionalPattern
where Base: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> NegatedPattern<Base.Reversed> {
    return NegatedPattern<Base.Reversed>(base.reversed())
  }

  @inlinable public func forward(
    match reversedMatch: AtomicPatternMatch<Base.Reversed.Searchable>,
    in forwardCollection: Searchable
  ) -> AtomicPatternMatch<Base.Searchable> {
    let range = reversedMatch.range
    return AtomicPatternMatch(
      range: range.upperBound.base..<range.lowerBound.base,
      in: forwardCollection
    )
  }
}
