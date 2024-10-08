/*
 Slice.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Slice: Pattern, SearchableCollection where Base: SearchableCollection {

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<Slice<Base>>
  public typealias SubSequencePattern = Slice<Base>
}
extension Slice: BidirectionalPattern, SearchableBidirectionalCollection
where Base: SearchableBidirectionalCollection {

  // MARK: - BidirectionalPattern

  public typealias Reversed = ReversedCollection<Self>
}
