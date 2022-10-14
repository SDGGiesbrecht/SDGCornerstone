/*
 AnyBidirectionalPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type‐erased bidirectional pattern.
///
/// - Note: The indirection used by `AnyBidirectionalPattern` can negatively affect performance. While use of `AnyBidirectionalPattern` is sometimes necessitated by the type system, it is recommended to use other strategies when possible.
public struct AnyBidirectionalPattern<Searchable>: BidirectionalPattern, TransparentWrapper
where Searchable: SearchableBidirectionalCollection {

  // MARK: - Initialization

  /// Creates a type erased instance of a pattern.
  ///
  /// - Parameters:
  ///     - pattern: The pattern.
  @inlinable public init<PatternType>(_ pattern: PatternType)
  where PatternType: BidirectionalPattern, PatternType.Searchable == Searchable {
    forwardPattern = AnyPattern(pattern)
    reversedClosure = { AnyPattern<ReversedCollection<Searchable>>(pattern.reversed()) }
    forwardClosure = { reversedMatch, forwardCollection in
      guard let underlying = reversedMatch.underlyingMatch as? PatternType.Reversed.Match else {
        _preconditionFailure({ localization in
          switch localization {
          case .englishCanada:
            return
              "Alien match encountered; only matches from the reversed collection can be converted."
          }
        })
      }
      return AnyPatternMatch<Searchable>(
        pattern.forward(match: underlying, in: forwardCollection)
      )
    }
  }

  // MARK: - Properties

  @usableFromInline internal let forwardPattern: AnyPattern<Searchable>
  @usableFromInline internal let reversedClosure: () -> AnyPattern<ReversedCollection<Searchable>>
  @usableFromInline internal let forwardClosure:
    (AnyPatternMatch<ReversedCollection<Searchable>>, Searchable) -> AnyPatternMatch<Searchable>

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> AnyPattern<ReversedCollection<Searchable>> {
    return reversedClosure()
  }

  @inlinable public func forward(
    match reversedMatch: AnyPatternMatch<ReversedCollection<Searchable>>,
    in forwardCollection: Searchable
  ) -> AnyPatternMatch<Searchable> {
    return forwardClosure(reversedMatch, forwardCollection)
  }

  // MARK: - Pattern

  public typealias Match = AnyPatternMatch<Searchable>

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [AnyPatternMatch<Searchable>] {
    return forwardPattern.matches(in: collection, at: location)
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> AnyPatternMatch<Searchable>? {
    return forwardPattern.primaryMatch(in: collection, at: location)
  }

  @inlinable public func forSubSequence() -> AnyPattern<Searchable.SubSequence> {
    return forwardPattern.forSubSequence()
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AnyPatternMatch<Searchable.SubSequence>,
    in collection: Searchable
  ) -> AnyPatternMatch<Searchable> {
    return forwardPattern.convertMatch(from: subSequenceMatch, in: collection)
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return forwardPattern.wrappedInstance
  }
}
