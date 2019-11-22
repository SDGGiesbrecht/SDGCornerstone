/*
 NaryConcatenatedPatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against several component patterns contiguously.
public struct NaryConcatenatedPatterns<ComponentPattern>: Pattern, CustomStringConvertible,
  ExpressibleByArrayLiteral, TextualPlaygroundDisplay
where ComponentPattern: Pattern {

  // MARK: - Initialization

  /// Creates a repetition pattern from several component patterns.
  ///
  /// - Parameters:
  ///     - components: The component patterns.
  @inlinable public init(_ components: [ComponentPattern]) {
    self.components = components
  }

  // MARK: - Properties

  @usableFromInline internal var components: [ComponentPattern]

  // MARK: - ExpressibleByArrayLiteral

  @inlinable public init(arrayLiteral: ComponentPattern...) {
    self.init(arrayLiteral)
  }

  // MARK: - Pattern

  public typealias Element = ComponentPattern.Element

  @inlinable public func matches<C: SearchableCollection>(in collection: C, at location: C.Index)
    -> [Range<C.Index>] where C.Element == Element
  {

    var endIndices: [C.Index] = [location]
    for component in components {
      if endIndices.isEmpty {
        // No matches
        return []
      } else {
        // Continue
        ConcatenationPatterning.advance(ends: &endIndices, for: component, in: collection)
      }
    }

    return endIndices.map { location..<$0 }
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Element {

    var endIndices: [C.Index] = [location]
    for component in components {
      if endIndices.isEmpty {
        // No matches
        return nil
      } else {
        // Continue
        ConcatenationPatterning.advance(ends: &endIndices, for: component, in: collection)
      }
    }

    return endIndices.first.map { location..<$0 }
  }

  @inlinable public func reversed() -> NaryConcatenatedPatterns<ComponentPattern.Reversed> {
    return NaryConcatenatedPatterns<ComponentPattern.Reversed>(
      components.lazy.map({ $0.reversed() }).reversed()
    )
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    let entries = components.map { "(" + String(describing: $0) + ")" }
    return entries.joined(separator: " + ")
  }
}
