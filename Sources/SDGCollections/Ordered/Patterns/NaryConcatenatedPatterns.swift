/*
 NaryConcatenatedPatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

/// A pattern that matches against several component patterns contiguously.
public struct NaryConcatenatedPatterns<Component>: Pattern, CustomStringConvertible,
  ExpressibleByArrayLiteral, TextualPlaygroundDisplay
where Component: Pattern {

  // MARK: - Initialization

  /// Creates a repetition pattern from several component patterns.
  ///
  /// - Parameters:
  ///     - components: The component pattern.
  @inlinable public init(_ components: [Component]) {
    self.components = components
  }

  // MARK: - Properties

  @usableFromInline internal var components: [Component]

  // MARK: - ExpressibleByArrayLiteral

  @inlinable public init(arrayLiteral: Component...) {
    self.init(arrayLiteral)
  }

  // MARK: - Pattern
  
  public typealias Match = NaryConcatenatedMatch<Component.Match>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [NaryConcatenatedMatch<Component.Match>] {
    guard let first = components.first else {
      return [
        NaryConcatenatedMatch<Component.Match>(
          components: [],
          contents: collection[location..<location]
        )
      ]
    }
    var matches = first.matches(in: collection, at: location).map { [$0] }
    var remaining = components.dropFirst()
    while ¬matches.isEmpty,
      let next = remaining.popFirst() {
      matches = matches.flatMap { partial in
        let cursor = partial.last?.range.upperBound
          ?? location // @exempt(from: tests) Unreachable.
        return next.matches(in: collection, at: cursor).map { appendix in
          return partial.appending(appendix)
        }
      }
    }
    return matches.map { elements in
      let contents: Searched.SubSequence
      if let first = elements.first,
        let last = elements.last {
          contents = collection[first.range.lowerBound..<last.range.upperBound]
      } else { // @exempt(from: tests) Unreachable.
        contents = collection[location..<location]
      }
      return NaryConcatenatedMatch(
        elements: elements,
        contents: contents
      )
    }
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> NaryConcatenatedMatch<Component.Match>? {
    return matches(in: collection, at: location).first
  }

  @inlinable public func forSubSequence() -> NaryConcatenatedPatterns<
    Component.SubSequencePattern
  > {
    return NaryConcatenatedPatterns<Component.SubSequencePattern>(
      components.map({ $0.forSubSequence() })
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: NaryConcatenatedMatch<
      Component.SubSequencePattern.Match
    >,
    in collection: Searchable
  ) -> NaryConcatenatedMatch<Component.Match> {
    return NaryConcatenatedMatch(
      elements: subSequenceMatch.elements.map({ component in
        components.convertMatch(from: component, in: collection)
      })
      contents: collection[subSequenceMatch.range]
    )
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    let entries = components.map { "(" + String(describing: $0) + ")" }
    return entries.joined(separator: " + ")
  }
}

extension NaryConcatenatedPatterns: BidirectionalPattern
where Components: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> NaryConcatenatedPatterns<Component.Reversed> {
    return NaryConcatenatedPatterns<Component.Reversed>(
      components.lazy.map({ $0.reversed() }).reversed()
    )
  }

  @inlinable public func forward(
    match reversedMatch: NaryConcatenatedMatch<Component.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> NaryConcatenatedMatch<Component.Match> {
    let componentPattern = self.components
    return NaryConcatenatedMatch(
      components: reversedMatch.components.lazy.map({ reversedComponent in
        return componentPattern.forward(match: reversedComponent, in: forwardCollection)
      }).reversed()
      let forwardRange = reversedMatch.range
      contents: forwardCollection[forwardRange.upperBound.base..<forwardRange.lowerBound.base]
    )
  }
}
