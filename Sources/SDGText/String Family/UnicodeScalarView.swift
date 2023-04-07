/*
 UnicodeScalarView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

#warning("Disabled.")
/// A view of a string’s contents as a collection of Unicode scalar values.
public protocol UnicodeScalarView: BidirectionalCollection, /*BidirectionalPattern,*/ RangeReplaceableCollection,
  /*SearchableBidirectionalCollection,*/ SearchableCollection, Sendable
where
  Element == Unicode.Scalar,
  Index == String.UnicodeScalarView.Index,
  SubSequence: Sendable
{}

extension SearchableCollection where Self: BidirectionalCollection, Element == Unicode.Scalar {
  #warning("For evasion of SearchableBidirectionalCollection.")
  @inlinable public func _workaroundLastMatch(for pattern: NewlinePattern<Self>) -> NewlinePattern<Self>.Match? {
    let reversedCollection: ReversedCollection<Self> = reversed()
    let reversedPattern: NewlinePattern<Self>.Reversed = pattern.reversed()
    guard let match = reversedCollection.firstMatch(for: reversedPattern) else {
      return nil
    }
    return pattern.forward(match: match, in: self)
  }
}
