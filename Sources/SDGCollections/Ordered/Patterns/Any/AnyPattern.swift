/*
 AnyPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type‐erased pattern.
///
/// - Note: The indirection used by `AnyPattern` can negatively affect performance. While use of `AnyPattern` is sometimes necessitated by the type system, it is recommended to use other strategies when possible.
public struct AnyPattern<Searchable>: Pattern, TransparentWrapper
where Searchable: SearchableCollection {

  // MARK: - Initialization

  /// Creates a type erased instance of a pattern.
  ///
  /// - Parameters:
  ///   - pattern: The pattern.
  @inlinable public init<PatternType>(_ pattern: PatternType)
  where PatternType: Pattern, PatternType.Searchable == Searchable {
    matchesClosure = { collection, index in
      return pattern.matches(in: collection, at: index)
        .map { AnyPatternMatch($0) }
    }
    primaryMatchClosure = { collection, index in
      pattern.primaryMatch(in: collection, at: index)
        .map { AnyPatternMatch($0) }
    }
    forSubSequenceClosure = { AnyPattern<Searchable.SubSequence>(pattern.forSubSequence()) }
    convertMatchClosure = { match, collection in
      guard let underlying = match.underlyingMatch as? PatternType.SubSequencePattern.Match else {
        _preconditionFailure({ localization in
          switch localization {
          case .englishCanada:
            return "Alien match encountered; only sub‐sequence matches can be converted."
          }
        })
      }
      return AnyPatternMatch(
        pattern.convertMatch(
          from: underlying,
          in: collection
        )
      )
    }
    wrappedInstance = pattern
  }

  // MARK: - Properties

  @usableFromInline internal let matchesClosure:
    (Searchable, Searchable.Index) -> [AnyPatternMatch<Searchable>]
  @usableFromInline internal let primaryMatchClosure:
    (Searchable, Searchable.Index) -> AnyPatternMatch<Searchable>?
  @usableFromInline internal let forSubSequenceClosure: () -> AnyPattern<Searchable.SubSequence>
  @usableFromInline internal let convertMatchClosure:
    (AnyPatternMatch<Searchable.SubSequence>, Searchable) -> AnyPatternMatch<Searchable>

  // MARK: - Pattern

  public typealias Match = AnyPatternMatch<Searchable>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [AnyPatternMatch<Searchable>] {
    return self.matchesClosure(collection, location)
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AnyPatternMatch<Searchable>? {
    return self.primaryMatchClosure(collection, location)
  }

  @inlinable public func forSubSequence() -> AnyPattern<Searchable.SubSequence> {
    return forSubSequenceClosure()
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AnyPatternMatch<Searchable.SubSequence>,
    in collection: Searchable
  ) -> AnyPatternMatch<Searchable> {
    return convertMatchClosure(subSequenceMatch, collection)
  }

  // MARK: - TransparentWrapper

  public let wrappedInstance: Any
}
