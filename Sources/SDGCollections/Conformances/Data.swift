/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

extension Data: BidirectionalPattern, SearchableBidirectionalCollection {

  // MARK: - SearchableCollection

  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Data.SubSequence
  ) -> P.Match?
  where P: Pattern, Data.SubSequence == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }

  // MARK: - SearchableBidirectionalCollection

  // #workaround(Swift 5.6.1, Redundant, but evades compiler bug in release configuration.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {  // @exempt(from: tests)
    let reversedCollection: ReversedCollection<Self> = reversed()
    let reversedPattern: Self.Reversed = pattern.reversed()
    guard let match = reversedCollection.firstMatch(for: reversedPattern) else {
      return nil
    }
    return pattern.forward(match: match, in: self)
  }

  // #workaround(Swift 5.6.1, Redundant, but evades compiler bug in release configuration.)
  @inlinable public func hasSuffix(_ pattern: Self) -> Bool {  // @exempt(from: tests)
    let reversedCollection: ReversedCollection<Self> = reversed()
    let reversedPattern: Self.Reversed = pattern.reversed()
    return reversedPattern.primaryMatch(
      in: reversedCollection,
      at: reversedCollection.startIndex
    ) ≠ nil
  }
}
