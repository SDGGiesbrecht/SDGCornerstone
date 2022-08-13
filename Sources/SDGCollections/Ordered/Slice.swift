/*
 Slice.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }
}
