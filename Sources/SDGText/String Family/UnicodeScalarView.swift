/*
 UnicodeScalarView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A view of a string’s contents as a collection of Unicode scalar values.
public protocol UnicodeScalarView: BidirectionalPattern, RangeReplaceableCollection,
  SearchableBidirectionalCollection
where
  Element == Unicode.Scalar,
  Index == String.UnicodeScalarView.Index,
  SubSequence: _SearchableBidirectionalCollection
{}

// #workaround(Swift 5.6.1, This protocol is redundant and can be removed when the compiler can handle its real counterpart as a constraint above.)
public protocol _SearchableBidirectionalCollection: Collection {
  func firstMatch<P>(for pattern: P) -> P.Match? where P: Pattern, P.Searchable == Self
  func firstMatch(for pattern: Self) -> AtomicPatternMatch<Self>?
  func matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self
  func matches(for pattern: Self) -> [AtomicPatternMatch<Self>]
  func prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  func prefix(upTo pattern: Self) -> ExclusivePrefixMatch<AtomicPatternMatch<Self>>?
  func prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  func prefix(through pattern: Self) -> InclusivePrefixMatch<AtomicPatternMatch<Self>>?
  func suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  func suffix(from pattern: Self) -> InclusiveSuffixMatch<AtomicPatternMatch<Self>>?
  func suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  func suffix(after pattern: Self) -> ExclusiveSuffixMatch<AtomicPatternMatch<Self>>?
  func components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self
  func components(separatedBy pattern: Self) -> [SeparatedMatch<AtomicPatternMatch<Self>>]
  func contains<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  func contains(_ pattern: Self) -> Bool
  func hasPrefix<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  func hasPrefix(_ pattern: Self) -> Bool
  func isMatch<P>(for pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  func isMatch(for pattern: Self) -> Bool
  func commonPrefix<C: SearchableCollection>(with other: C) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element
  func commonPrefix(with other: Self) -> AtomicPatternMatch<Self>
  @discardableResult func advance<P>(_ index: inout Index, over pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self
  @discardableResult func advance(_ index: inout Index, over pattern: Self) -> Bool
  func changes<C>(from other: C) -> CollectionDifference<Element>
  where C: SearchableCollection, C.Element == Self.Element
  func changes(from other: Self) -> CollectionDifference<Element>
  func lastMatch<P>(for pattern: P) -> P.Match? where P: BidirectionalPattern, P.Searchable == Self
  func lastMatch(for pattern: Self) -> AtomicPatternMatch<Self>?
  func hasSuffix<P>(_ pattern: P) -> Bool where P: BidirectionalPattern, P.Searchable == Self
  func hasSuffix(_ pattern: Self) -> Bool
  func commonSuffix<C: SearchableBidirectionalCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element
  func commonSuffix(with other: Self) -> AtomicPatternMatch<Self>
  func changes<C>(from other: C) -> CollectionDifference<Element>
  where C: SearchableBidirectionalCollection, C.Element == Self.Element
}
extension Slice: _SearchableBidirectionalCollection where Base: SearchableBidirectionalCollection {}
extension Substring.UnicodeScalarView: _SearchableBidirectionalCollection {}
