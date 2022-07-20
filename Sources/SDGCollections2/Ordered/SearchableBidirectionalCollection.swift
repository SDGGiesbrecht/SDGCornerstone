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
public protocol SearchableBidirectionalCollection:
  BidirectionalCollection, /*BidirectionalPattern,*/
  // #workaround(Swift 5.6.1, The compiler cannot handle the commented constraint. Remove “requires” documentation too when fixed.)
  SearchableCollection
{

  func lastMatch(for pattern: Self) -> Match?
}

extension SearchableBidirectionalCollection {

  @inlinable internal func _lastMatch<P>(for pattern: P) -> P.Match?
  where P: BidirectionalPattern, P.Searchable == Self {
    let reversedCollection: ReversedCollection<Self> = reversed()
    let reversedPattern: P.Reversed = pattern.reversed()
    guard let match = reversedCollection.firstMatch(for: reversedPattern) else {
      return nil
    }
    return pattern.forward(match: match, in: self)
  }
  @inlinable public func lastMatch<P>(for pattern: P) -> P.Match?
  where P: BidirectionalPattern, P.Searchable == Self {
    return _lastMatch(for: pattern)
  }
  // #workaround(Swift 5.6.1, The compiler cannot handle the generic signature of this method.)
  /*@inlinable public func lastMatch(for pattern: Self) -> Match? {  @exempt(from: unicode)
    return _lastMatch(for: pattern)
  }*/

  // MARK: - BidirectionalPattern

  @inlinable public func forward(
    match reversedMatch: AtomicPatternMatch<ReversedCollection<Self>>,
    in forwardCollection: Self
  ) -> AtomicPatternMatch<Self> {
    let range = reversedMatch.range
    return AtomicPatternMatch(
      range: range.upperBound.base..<range.lowerBound.base,
      in: forwardCollection
    )
  }
}
