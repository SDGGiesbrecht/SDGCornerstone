/*
 SearchableBidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

/// An bidirectional ordered collection which can be searched for elements, subsequences and patterns.
///
/// - Requires: Must also conform to `BidirectionalPattern` even though the compiler is currently incapable of enforcing it.
public protocol SearchableBidirectionalCollection: BidirectionalCollection, BidirectionalPattern,
  SearchableCollection
{

  // @documentation(SDGCornerstone.Collection.lastMatch(for:))
  // #example(1, lastMatchBackwardsDifferences1) #example(2, lastMatchBackwardsDifferences2)
  /// Returns the last match for `pattern` in the collection.
  ///
  /// This mathod searches backward from the end of the search range. This is not always the same thing as the last forward‐searched match:
  ///
  /// ```swift
  /// let collection = [0, 0, 0, 0, 0]
  /// let pattern = [0, 0]
  ///
  /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 3..<5)
  ///
  /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 2..<4)
  /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
  /// ```
  ///
  /// ```swift
  /// let collection = [0, 0, 1]
  /// let pattern = RepetitionPattern([0], count: 1..<Int.max, consumption: .lazy) + [1]
  ///
  /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 1..<3)
  /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
  ///
  /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 0..<3)
  /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
  /// ```
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func lastMatch<P>(for pattern: P) -> P.Match? where P: BidirectionalPattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.lastMatch(for:))
  /// Returns the last match for `pattern` in the collection.
  ///
  /// This mathod searches backward from the end of the search range. This is not always the same thing as the last forward‐searched match:
  ///
  /// ```swift
  /// let collection = [0, 0, 0, 0, 0]
  /// let pattern = [0, 0]
  ///
  /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 3..<5)
  ///
  /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 2..<4)
  /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
  /// ```
  ///
  /// ```swift
  /// let collection = [0, 0, 1]
  /// let pattern = RepetitionPattern([0], count: 1..<Int.max, consumption: .lazy) + [1]
  ///
  /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 1..<3)
  /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
  ///
  /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 0..<3)
  /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
  /// ```
  ///
  /// - Parameters:
  ///     - pattern: The pattern to search for.
  func lastMatch(for pattern: Self) -> Match?

  // @documentation(SDGCornerstone.Collection.hasSuffix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to try.
  func hasSuffix<P>(_ pattern: P) -> Bool where P: BidirectionalPattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.hasSuffix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to try.
  func hasSuffix(_ pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest suffix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///     - other: The other collection
  func commonSuffix<C: SearchableBidirectionalCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element
  // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///     - other: The other collection
  func commonSuffix(with other: Self) -> AtomicPatternMatch<Self>

  // #documentation(SDGCornerstone.Collection.changes(from:))
  /// Returns the difference which transforms the specified collection to match this one.
  ///
  /// - Parameters:
  ///     - other: The other collection. (The starting point.)
  func changes<C>(from other: C) -> CollectionDifference<Element>
  where C: SearchableBidirectionalCollection, C.Element == Self.Element
  // #documentation(SDGCornerstone.Collection.changes(from:))
  /// Returns the difference which transforms the specified collection to match this one.
  ///
  /// - Parameters:
  ///     - other: The other collection. (The starting point.)
  func changes(from other: Self) -> CollectionDifference<Element>
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
  /*@inlinable public func lastMatch(for pattern: Self) -> Match? { @exempt(from: unicode)
    return _lastMatch(for: pattern)
  }*/

  @inlinable internal func _hasSuffix<P>(_ pattern: P) -> Bool
  where P: BidirectionalPattern, P.Searchable == Self {
    let reversedCollection: ReversedCollection<Self> = reversed()
    let reversedPattern: P.Reversed = pattern.reversed()
    return reversedPattern.primaryMatch(
      in: reversedCollection,
      at: reversedCollection.startIndex
    ) ≠ nil
  }
  @inlinable public func hasSuffix<P>(_ pattern: P) -> Bool
  where P: BidirectionalPattern, P.Searchable == Self {
    return _hasSuffix(pattern)
  }
  // #workaround(Swift 5.6.1, The compiler cannot handle the generic signature of this method.)
  /*@inlinable public func hasSuffix(_ pattern: Self) -> Bool { @exempt(from: unicode)
    return _hasSuffix(pattern)
  }*/

  @inlinable internal func _commonSuffix<C: SearchableBidirectionalCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self> where C.Element == Self.Element {
    return forward(match: reversed().commonPrefix(with: other.reversed()), in: self)
  }
  @inlinable public func commonSuffix<C: SearchableBidirectionalCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self> where C.Element == Self.Element {
    return _commonSuffix(with: other)
  }
  @inlinable public func commonSuffix(with other: Self) -> AtomicPatternMatch<Self> {
    return _commonSuffix(with: other)
  }

  @inlinable public func changes<C>(
    from other: C
  ) -> CollectionDifference<Element>
  where C: SearchableBidirectionalCollection, C.Element == Self.Element {
    return shimmedDifference(from: other)
  }
  @inlinable public func changes(
    from other: Self
  ) -> CollectionDifference<Element> {
    return shimmedDifference(from: other)
  }

  // MARK: - BidirectionalPattern

  // #documentation(BidirectionalPattern.forward(match:in:))
  /// Converts the reversed match into a match in the forward collection.
  ///
  /// - Parameters:
  ///     - reversedMatch: The reversed match.
  ///     - forwardCollection: The forward collection.
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
