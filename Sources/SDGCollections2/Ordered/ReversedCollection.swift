/*
 ReversedCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ReversedCollection: Pattern, SearchableCollection where Base: SearchableCollection {

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<ReversedCollection<Base>>
  public typealias SubSequencePattern = Slice<ReversedCollection<Base>>

  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Slice<ReversedCollection<Base>>
  ) -> P.Match? where P: Pattern, Slice<ReversedCollection<Base>> == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension ReversedCollection: BidirectionalPattern, SearchableBidirectionalCollection
where Base: SearchableBidirectionalCollection {

  // MARK: - BidirectionalPattern

  public typealias Reversed = ReversedCollection<Self>
}
