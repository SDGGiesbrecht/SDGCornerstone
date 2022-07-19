/*
 SearchableBidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An bidirectional ordered collection which can be searched for elements, subsequences and patterns.
///
/// - Requires: Must also conform to `BidirectionalPattern` even though the compiler is currently incapable of enforcing it.
public protocol SearchableBidirectionalCollection: BidirectionalCollection, /*BidirectionalPattern,*/
  // #workaround(Swift 5.6.1, The compiler cannot handle the commented constraint. Remove “requires” documentation too when fixed.)
  SearchableCollection
{

  #warning("Is this actually needed?")
  // #workaround(Swift 5.6.1, Needed to dodge compiler bug; remove all conformances too.)
  /// Returns the first match for the pattern in the reversed collection.
  ///
  /// The implementation of this method must be `return reversed.firstMatch(for: pattern)`, which the compiler is unable to do from a default implementation due to a bug.
  ///
  /// - Warning: Never call this method directly. It will be removed from the protocol as soon as the compiler is repaired, and that will be versioned as a bug fix, not a breaking change.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  ///     - reversed: The reversed collection.
  func temporaryWorkaroundFirstMatch<P>(for pattern: P, in reversed: ReversedCollection<Self>) -> P.Match?
  where P: Pattern, P.Searchable == ReversedCollection<Self>
}

extension SearchableBidirectionalCollection {

  @inlinable internal func _lastMatch<P>(for pattern: P) -> P.Match?
  where P: BidirectionalPattern, P.Searchable == Self {
    let reversedCollection: ReversedCollection<Self> = reversed()
    let reversedPattern: P.Reversed = pattern.reversed()
    guard let match = temporaryWorkaroundFirstMatch(for: reversedPattern, in: reversedCollection) else {
      return nil
    }
    return pattern.forward(match: match, in: self)
  }
  @inlinable public func lastMatch<P>(for pattern: P) -> P.Match?
  where P: BidirectionalPattern, P.Searchable == Self {
    return _lastMatch(for: pattern)
  }

  // MARK: - BidirectionalPattern

  @inlinable public func forward(
    match reversedMatch: AtomicPatternMatch<ReversedCollection<Self>>,
    in forwardCollection: Self
  ) -> AtomicPatternMatch<Self> {
    let range = reversedMatch.range
    return AtomicPatternMatch(range: range.upperBound.base..<range.lowerBound.base, in: forwardCollection)
  }
}
