/*
 Slice.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Slice: Pattern, SearchableCollection where Base: SearchableCollection {

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<Slice<Base>>
  public typealias SubSequencePattern = Slice<Base>

  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in subSequence: Slice<Base>
  ) -> P.Match?
  where P: Pattern, Slice<Base> == P.Match.Searched {
    return subSequence.firstMatch(for: pattern)
  }
}
extension Slice: BidirectionalPattern, SearchableBidirectionalCollection
where Base: SearchableBidirectionalCollection {

  // MARK: - BidirectionalPattern

  public typealias Reversed = ReversedCollection<Self>

  @inlinable public func temporaryWorkaroundFirstMatch<P>(
    for pattern: P,
    in reversed: ReversedCollection<Slice<Base>>
  ) -> P.Match?
  where P : Pattern, P.Match.Searched == ReversedCollection<Slice<Base>> {
    return reversed.firstMatch(for: pattern)
  }
}
