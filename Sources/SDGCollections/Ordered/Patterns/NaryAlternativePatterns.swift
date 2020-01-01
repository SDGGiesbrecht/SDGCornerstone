/*
 NaryAlternativePatterns.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches against several alternative patterns.
///
/// The order of the alternatives is significant. If multiple alternatives match, preference will be given to one higher in the list.
public struct NaryAlternativePatterns<ComponentPattern>: Pattern, CustomStringConvertible,
  TextualPlaygroundDisplay
where ComponentPattern: Pattern {

  // MARK: - Initialization

  /// Creates a set of alternative patterns.
  ///
  /// - Parameters:
  ///     - alternatives: The alternative patterns.
  @inlinable public init(_ alternatives: [ComponentPattern]) {
    self.alternatives = alternatives
  }

  // MARK: - Properties

  @usableFromInline internal var alternatives: [ComponentPattern]

  // MARK: - Pattern

  public typealias Element = ComponentPattern.Element

  @inlinable public func matches<C: SearchableCollection>(in collection: C, at location: C.Index)
    -> [Range<C.Index>] where C.Element == Element
  {

    var results: [Range<C.Index>] = []
    for alternative in alternatives {
      results.append(contentsOf: alternative.matches(in: collection, at: location))
    }
    return results
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Element {
    for alternative in alternatives {
      if let match = alternative.primaryMatch(in: collection, at: location) {
        return match
      }
    }
    return nil
  }

  @inlinable public func reversed() -> NaryAlternativePatterns<ComponentPattern.Reversed> {
    return NaryAlternativePatterns<ComponentPattern.Reversed>(alternatives.map({ $0.reversed() }))
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    let entries = alternatives.map { "(" + String(describing: $0) + ")" }
    return entries.joined(separator: " ∨ ")
  }
}
