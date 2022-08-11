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
public protocol _SearchableBidirectionalCollection {
  func firstMatch<P>(for pattern: P) -> P.Match? where P: Pattern, P.Searchable == Self
  func lastMatch<P>(for pattern: P) -> P.Match? where P: BidirectionalPattern, P.Searchable == Self
}
extension Slice: _SearchableBidirectionalCollection where Base: SearchableBidirectionalCollection {}
extension Substring.UnicodeScalarView: _SearchableBidirectionalCollection {}
