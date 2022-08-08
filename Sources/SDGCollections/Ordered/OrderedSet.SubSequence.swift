/*
 OrderedSet.SubSequence.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import OrderedCollections

extension OrderedCollections.OrderedSet.SubSequence: BidirectionalPattern, SearchableBidirectionalCollection {

  // MARK: - SearchableCollection

  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: OrderedSet.SubSequence
  ) -> P.Match?
  where P: Pattern, OrderedSet.SubSequence == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
