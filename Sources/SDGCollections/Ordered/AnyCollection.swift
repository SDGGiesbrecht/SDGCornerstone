/*
 AnyCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension AnyCollection: Pattern, SearchableCollection where Element: Equatable {

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<AnyCollection>
  public typealias SubSequencePattern = AnyCollection.SubSequence
}

extension AnyBidirectionalCollection: BidirectionalPattern, Pattern,
  SearchableBidirectionalCollection,
  SearchableCollection
where Element: Equatable {

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<AnyBidirectionalCollection>
  public typealias SubSequencePattern = AnyBidirectionalCollection.SubSequence

  // MARK: - BidirectionalPattern

  public typealias Reversed = ReversedCollection<Self>

  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }

  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func hasSuffix(_ pattern: Self) -> Bool {
    return _hasSuffix(pattern)
  }
}

extension AnyRandomAccessCollection: BidirectionalPattern, Pattern,
  SearchableBidirectionalCollection,
  SearchableCollection
where Element: Equatable {

  // MARK: - Pattern

  public typealias Match = AtomicPatternMatch<AnyRandomAccessCollection>
  public typealias SubSequencePattern = AnyRandomAccessCollection.SubSequence

  // MARK: - BidirectionalPattern

  public typealias Reversed = ReversedCollection<Self>

  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func lastMatch(for pattern: Self) -> Match? {
    return _lastMatch(for: pattern)
  }

  // #workaround(Swift 5.6.1, This method is redundant and can be removed when the compiler can handle the default implementation.)
  @inlinable public func hasSuffix(_ pattern: Self) -> Bool {
    return _hasSuffix(pattern)
  }
}
