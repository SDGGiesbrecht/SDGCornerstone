/*
 SearchableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics

/// An ordered collection which can be searched for elements, subsequences and patterns.
public protocol SearchableCollection: Collection, Pattern
where Element: Equatable, Searchable == Self, SubSequence: SearchableCollection {

  #warning("Debugging")
  /*
  // @documentation(SDGCornerstone.Collection.firstMatch(for:))
  /// Returns the first match for `pattern` in the collection.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func firstMatch<P>(for pattern: P) -> P.Match?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.firstMatch(for:))
  /// Returns the first match for `pattern` in the collection.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func firstMatch(for pattern: Self) -> Match?

  // @documentation(SDGCornerstone.Collection.matches(for:))
  /// Returns a list of all matches for `pattern` in the collection.
  ///
  /// This does not check for overlapping matches.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.matches(for:))
  /// Returns a list of all matches for `pattern` in the collection.
  ///
  /// This does not check for overlapping matches.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func matches(for pattern: Self) -> [Match]

  // @documentation(SDGCornerstone.Collection.prefix(upTo:))
  /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.prefix(upTo:))
  /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func prefix(upTo pattern: Self) -> ExclusivePrefixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.prefix(through:))
  /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.prefix(through:))
  /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func prefix(through pattern: Self) -> InclusivePrefixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.suffix(from:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.suffix(from:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func suffix(from pattern: Self) -> InclusiveSuffixMatch<Match>?*/

#warning("Debugging")
/*
  // @documentation(SDGCornerstone.Collection.suffix(after:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.suffix(after:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func suffix(after pattern: Self) -> ExclusiveSuffixMatch<Match>?

  // @documentation(SDGCornerstone.Collection.components(separatedBy:))
  /// Returns the segments of `self` separated by instances of `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.components(separatedBy:))
  /// Returns the segments of `self` separated by instances of `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func components(separatedBy pattern: Self) -> [SeparatedMatch<Match>]*/

#warning("Debugging")
/*
  // @documentation(SDGCornerstone.Collection.contains(pattern:))
  /// Returns `true` if `self` contains an match for `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func contains<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self*/
  // #documentation(SDGCornerstone.Collection.contains(pattern:))
  /// Returns `true` if `self` contains an match for `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  func contains(_ pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.hasPrefix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  func hasPrefix<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  func hasPrefix(_ pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.isMatch(for:))
  /// Returns `true` if the whole collection matches the specified pattern.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  func isMatch<P>(for pattern: P) -> Bool where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.isMatch(for:))
  /// Returns `true` if the whole collection matches the specified pattern.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  func isMatch(for pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///   - other: The other collection
  func commonPrefix<C: SearchableCollection>(with other: C) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element
  // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///   - other: The other collection
  func commonPrefix(with other: Self) -> AtomicPatternMatch<Self>

  // @documentation(SDGCornerstone.Collection.advance(_: over:))
  /// Advances the index over the pattern.
  ///
  /// - Parameters:
  ///   - index: The index to advance.
  ///   - pattern: The pattern to advance over.
  ///
  /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
  @discardableResult func advance<P>(_ index: inout Index, over pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self
  // #documentation(SDGCornerstone.Collection.advance(_: over:))
  /// Advances the index over the pattern.
  ///
  /// - Parameters:
  ///   - index: The index to advance.
  ///   - pattern: The pattern to advance over.
  ///
  /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
  @discardableResult func advance(_ index: inout Index, over pattern: Self) -> Bool

  // @documentation(SDGCornerstone.Collection.changes(from:))
  /// Returns the difference which transforms the specified collection to match this one.
  ///
  /// - Parameters:
  ///   - other: The other collection. (The starting point.)
  func changes<C>(from other: C) -> CollectionDifference<Element>
  where C: SearchableCollection, C.Element == Self.Element
  // #documentation(SDGCornerstone.Collection.changes(from:))
  /// Returns the difference which transforms the specified collection to match this one.
  ///
  /// - Parameters:
  ///   - other: The other collection. (The starting point.)
  func changes(from other: Self) -> CollectionDifference<Element>
}

extension SearchableCollection {

  @inlinable internal func _firstMatch<P>(for pattern: P) -> P.Match?
  where P: Pattern, P.Searchable == Self {
    var i = startIndex
    while i ≠ endIndex {
      if let match = pattern.primaryMatch(in: self, at: i) {
        return match
      }
      i = index(after: i)
    }
    return nil
  }
  // #documentation(SDGCornerstone.Collection.firstMatch(for:))
  /// Returns the first match for `pattern` in the collection.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func firstMatch<P>(for pattern: P) -> P.Match?
  where P: Pattern, P.Searchable == Self {
    return _firstMatch(for: pattern)
  }
  // #documentation(SDGCornerstone.Collection.firstMatch(for:))
  /// Returns the first match for `pattern` in the collection.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func firstMatch(for pattern: Self) -> Match? {
    return _firstMatch(for: pattern)
  }

  @inlinable internal func _matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self {
    let subsequencePattern = pattern.forSubSequence()
    var accountedFor = startIndex
    var results: [P.Match] = []
    while let match = self[accountedFor...].firstMatch(for: subsequencePattern) {
      accountedFor = match.range.upperBound
      results.append(pattern.convertMatch(from: match, in: self))
    }
    return results
  }
  // #documentation(SDGCornerstone.Collection.matches(for:))
  /// Returns a list of all matches for `pattern` in the collection.
  ///
  /// This does not check for overlapping matches.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func matches<P>(for pattern: P) -> [P.Match]
  where P: Pattern, P.Searchable == Self {
    return _matches(for: pattern)
  }
  // #documentation(SDGCornerstone.Collection.matches(for:))
  /// Returns a list of all matches for `pattern` in the collection.
  ///
  /// This does not check for overlapping matches.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func matches(for pattern: Self) -> [Match] {
    return _matches(for: pattern)
  }

  @inlinable internal func _prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return ExclusivePrefixMatch(match: match, in: self)
  }
  // #documentation(SDGCornerstone.Collection.prefix(upTo:))
  /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func prefix<P>(upTo pattern: P) -> ExclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _prefix(upTo: pattern)
  }
  // #documentation(SDGCornerstone.Collection.prefix(upTo:))
  /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func prefix(upTo pattern: Self) -> ExclusivePrefixMatch<Match>? {
    return _prefix(upTo: pattern)
  }

  @inlinable internal func _prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return InclusivePrefixMatch(match: match, in: self)
  }
  // #documentation(SDGCornerstone.Collection.prefix(through:))
  /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func prefix<P>(through pattern: P) -> InclusivePrefixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _prefix(through: pattern)
  }
  // #documentation(SDGCornerstone.Collection.prefix(through:))
  /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func prefix(through pattern: Self) -> InclusivePrefixMatch<Match>? {
    return _prefix(through: pattern)
  }

  @inlinable internal func _suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return InclusiveSuffixMatch(match: match, in: self)
  }
  // #documentation(SDGCornerstone.Collection.suffix(from:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func suffix<P>(from pattern: P) -> InclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _suffix(from: pattern)
  }
  // #documentation(SDGCornerstone.Collection.suffix(from:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func suffix(from pattern: Self) -> InclusiveSuffixMatch<Match>? {
    return _suffix(from: pattern)
  }

  @inlinable internal func _suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    guard let match = firstMatch(for: pattern) else {
      return nil
    }
    return ExclusiveSuffixMatch(match: match, in: self)
  }
  // #documentation(SDGCornerstone.Collection.suffix(after:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func suffix<P>(after pattern: P) -> ExclusiveSuffixMatch<P.Match>?
  where P: Pattern, P.Searchable == Self {
    return _suffix(after: pattern)
  }
  // #documentation(SDGCornerstone.Collection.suffix(after:))
  /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func suffix(after pattern: Self) -> ExclusiveSuffixMatch<Match>? {
    return _suffix(after: pattern)
  }

  @inlinable internal func _components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self {
    let separators = matches(for: pattern)
    var previousIndex = startIndex
    var components: [SeparatedMatch<P.Match>] = separators.map { separator in
      defer { previousIndex = separator.range.upperBound }
      return SeparatedMatch(start: previousIndex, match: separator, in: self)
    }
    components.append(SeparatedMatch(start: previousIndex, match: nil, in: self))
    return components
  }
  // #documentation(SDGCornerstone.Collection.components(separatedBy:))
  /// Returns the segments of `self` separated by instances of `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func components<P>(separatedBy pattern: P) -> [SeparatedMatch<P.Match>]
  where P: Pattern, P.Searchable == Self {
    return _components(separatedBy: pattern)
  }
  // #documentation(SDGCornerstone.Collection.components(separatedBy:))
  /// Returns the segments of `self` separated by instances of `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func components(separatedBy pattern: Self) -> [SeparatedMatch<Match>] {
    return _components(separatedBy: pattern)
  }

  @inlinable internal func _contains<P>(_ pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    return firstMatch(for: pattern) ≠ nil
  }
  // #documentation(SDGCornerstone.Collection.contains(pattern:))
  /// Returns `true` if `self` contains an match for `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func contains<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self {
    return _contains(pattern)
  }
  // #documentation(SDGCornerstone.Collection.contains(pattern:))
  /// Returns `true` if `self` contains an match for `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func contains(_ pattern: Self) -> Bool {
    return _contains(pattern)
  }

  @inlinable public func _hasPrefix<P>(_ pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    return pattern.primaryMatch(in: self, at: startIndex) ≠ nil
  }
  // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  @inlinable public func hasPrefix<P>(_ pattern: P) -> Bool where P: Pattern, P.Searchable == Self {
    return _hasPrefix(pattern)
  }
  // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
  /// Returns `true` if `self` begins with `pattern`.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  @inlinable public func hasPrefix(_ pattern: Self) -> Bool {
    return _hasPrefix(pattern)
  }

  @inlinable public func _isMatch<P>(for pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    return pattern.matches(in: self, at: startIndex)
      .contains(where: { $0.range.upperBound == endIndex })
  }
  // #documentation(SDGCornerstone.Collection.isMatch(for:))
  /// Returns `true` if the whole collection matches the specified pattern.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  @inlinable public func isMatch<P>(for pattern: P) -> Bool where P: Pattern, P.Searchable == Self {
    return _isMatch(for: pattern)
  }
  // #documentation(SDGCornerstone.Collection.isMatch(for:))
  /// Returns `true` if the whole collection matches the specified pattern.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to try.
  @inlinable public func isMatch(for pattern: Self) -> Bool {
    return elementsEqual(pattern)
  }

  @inlinable internal func _commonPrefix<C: SearchableCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self> where C.Element == Self.Element {
    var end: Index = startIndex
    for (ownIndex, otherIndex) in zip(indices, other.indices) {
      if self[ownIndex] == other[otherIndex] {
        end = index(after: end)
      } else {
        break
      }
    }
    return AtomicPatternMatch(range: ..<end, in: self)
  }
  // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///   - other: The other collection
  @inlinable public func commonPrefix<C: SearchableCollection>(
    with other: C
  ) -> AtomicPatternMatch<Self>
  where C.Element == Self.Element {
    return _commonPrefix(with: other)
  }
  // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
  /// Returns the longest prefix subsequence shared with the other collection.
  ///
  /// - Parameters:
  ///   - other: The other collection
  @inlinable public func commonPrefix(with other: Self) -> AtomicPatternMatch<Self> {
    return _commonPrefix(with: other)
  }

  @inlinable internal func _advance<P>(_ index: inout Index, over pattern: P) -> Bool
  where P: Pattern, P.Searchable == Self {
    if let match = pattern.primaryMatch(in: self, at: index) {
      index = match.range.upperBound
      return true
    } else {
      return false
    }
  }
  // #documentation(SDGCornerstone.Collection.advance(_: over:))
  /// Advances the index over the pattern.
  ///
  /// - Parameters:
  ///   - index: The index to advance.
  ///   - pattern: The pattern to advance over.
  ///
  /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
  @inlinable @discardableResult public func advance<P>(
    _ index: inout Index,
    over pattern: P
  ) -> Bool where P: Pattern, P.Searchable == Self {
    return _advance(&index, over: pattern)
  }
  // #documentation(SDGCornerstone.Collection.advance(_: over:))
  /// Advances the index over the pattern.
  ///
  /// - Parameters:
  ///   - index: The index to advance.
  ///   - pattern: The pattern to advance over.
  ///
  /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
  @inlinable @discardableResult public func advance(
    _ index: inout Index,
    over pattern: Self
  ) -> Bool {
    return _advance(&index, over: pattern)
  }

  @inlinable internal func forwardDifference<C>(from other: C)
    -> CollectionDifference<Element>
  where C: SearchableCollection, C.Element == Self.Element {
    let prefixEnd = commonPrefix(with: other).range.upperBound
    let prefixLength = distance(from: startIndex, to: prefixEnd)
    let otherPrefixEnd = other.index(other.startIndex, offsetBy: prefixLength)

    let slice = other[otherPrefixEnd...].changes(toMake: self[prefixEnd...], by: ==)
    let adjusted: [CollectionDifference<Element>.Change] = slice.map { change in
      var change = change
      change.offset += prefixLength
      change.associatedOffset? += prefixLength
      return change
    }

    return CollectionDifference(unsafeChanges: adjusted)
  }
  // #documentation(SDGCornerstone.Collection.changes(from:))
  /// Returns the difference which transforms the specified collection to match this one.
  ///
  /// - Parameters:
  ///   - other: The other collection. (The starting point.)
  @inlinable public func changes<C>(
    from other: C
  ) -> CollectionDifference<Element>
  where C: SearchableCollection, C.Element == Self.Element {
    return forwardDifference(from: other)
  }
  // #documentation(SDGCornerstone.Collection.changes(from:))
  /// Returns the difference which transforms the specified collection to match this one.
  ///
  /// - Parameters:
  ///   - other: The other collection. (The starting point.)
  @inlinable public func changes(
    from other: Self
  ) -> CollectionDifference<Element> {
    return forwardDifference(from: other)
  }

  /// Creates a literal for use searching a different collection type containing the same elements.
  ///
  /// - Parameters:
  ///   - searchTarget: The type of collection to search.
  @inlinable public func literal<SearchTarget>(
    for searchTarget: SearchTarget.Type
  ) -> LiteralPattern<Self, SearchTarget>
  where SearchTarget: Collection, SearchTarget.Element == Element {
    return LiteralPattern<Self, SearchTarget>(self)
  }

  /// Creates a literal for use searching a different collection type containing the same elements.
  @inlinable public func literal<SearchTarget>() -> LiteralPattern<Self, SearchTarget>
  where SearchTarget: SearchableCollection, SearchTarget.Element == Element {
    return literal(for: SearchTarget.self)
  }

  // MARK: - Pattern

  @inlinable public func matches(
    in collection: Self,
    at location: Index
  ) -> [AtomicPatternMatch<Self>] {
    return literal(for: Self.self).matches(in: collection, at: location)
  }

  @inlinable public func primaryMatch(
    in collection: Self,
    at location: Index
  ) -> AtomicPatternMatch<Self>? {
    return literal(for: Self.self).primaryMatch(in: collection, at: location)
  }

  @inlinable public func forSubSequence() -> SubSequence {
    return self[...]
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: AtomicPatternMatch<SubSequence>,
    in collection: Self
  ) -> AtomicPatternMatch<Self> {
    return subSequenceMatch.in(collection)
  }
}

extension SearchableCollection where Self: RangeReplaceableCollection {

  @inlinable internal mutating func _truncate<P>(before pattern: P)
  where P: Pattern, P.Searchable == Self {
    if let match = firstMatch(for: pattern) {
      removeSubrange(match.range.lowerBound...)
    }
  }
  // @documentation(SDGCornerstone.Collection.trucate(before:))
  /// Truncates `self` at the start of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func truncate<P>(before pattern: P)
  where P: Pattern, P.Searchable == Self {
    return _truncate(before: pattern)
  }
  // #documentation(SDGCornerstone.Collection.trucate(after:))
  /// Truncates `self` at the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func truncate(before pattern: Self) {
    _truncate(before: pattern)
  }

  @inlinable internal func _truncated<P>(before pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return nonmutatingVariant(of: { $0.truncate(before: $1) }, on: self, with: pattern)
  }
  // @documentation(SDGCornerstone.Collection.trucated(before:))
  /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func truncated<P>(before pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return _truncated(before: pattern)
  }
  // #documentation(SDGCornerstone.Collection.trucated(after:))
  /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func truncated(before pattern: Self) -> Self {
    return _truncated(before: pattern)
  }

  @inlinable internal mutating func _truncate<P>(after pattern: P)
  where P: Pattern, P.Searchable == Self {
    if let match = firstMatch(for: pattern) {
      removeSubrange(match.range.upperBound...)
    }
  }
  // @documentation(SDGCornerstone.Collection.trucate(after:))
  /// Truncates `self` at the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func truncate<P>(after pattern: P)
  where P: Pattern, P.Searchable == Self {
    return _truncate(after: pattern)
  }
  // #documentation(SDGCornerstone.Collection.trucate(after:))
  /// Truncates `self` at the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func truncate(after pattern: Self) {
    _truncate(after: pattern)
  }

  @inlinable internal func _truncated<P>(after pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return nonmutatingVariant(of: { $0.truncate(after: $1) }, on: self, with: pattern)
  }
  // @documentation(SDGCornerstone.Collection.trucated(after:))
  /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func truncated<P>(after pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return _truncated(after: pattern)
  }
  // #documentation(SDGCornerstone.Collection.trucated(after:))
  /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will remain unchanged.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func truncated(after pattern: Self) -> Self {
    return _truncated(after: pattern)
  }

  @inlinable internal mutating func _drop<P>(upTo pattern: P)
  where P: Pattern, P.Searchable == Self {
    if let match = firstMatch(for: pattern) {
      removeSubrange(..<match.range.lowerBound)
    } else {
      self = Self()
    }
  }
  // @documentation(SDGCornerstone.Collection.drop(upTo:))
  /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func drop<P>(upTo pattern: P) where P: Pattern, P.Searchable == Self {
    return _drop(upTo: pattern)
  }
  // #documentation(SDGCornerstone.Collection.drop(upTo:))
  /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func drop(upTo pattern: Self) {
    _drop(upTo: pattern)
  }

  @inlinable internal func _dropping<P>(upTo pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return nonmutatingVariant(of: { $0.drop(upTo: $1) }, on: self, with: pattern)
  }
  // @documentation(SDGCornerstone.Collection.dropping(upTo:))
  /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func dropping<P>(upTo pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return _dropping(upTo: pattern)
  }
  // #documentation(SDGCornerstone.Collection.dropping(upTo:))
  /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func dropping(upTo pattern: Self) -> Self {
    return _dropping(upTo: pattern)
  }

  @inlinable internal mutating func _drop<P>(through pattern: P)
  where P: Pattern, P.Searchable == Self {
    if let match = firstMatch(for: pattern) {
      removeSubrange(..<match.range.upperBound)
    } else {
      self = Self()
    }
  }
  // @documentation(SDGCornerstone.Collection.drop(through:))
  /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func drop<P>(through pattern: P)
  where P: Pattern, P.Searchable == Self {
    return _drop(through: pattern)
  }
  // #documentation(SDGCornerstone.Collection.drop(through:))
  /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public mutating func drop(through pattern: Self) {
    _drop(through: pattern)
  }

  @inlinable internal func _dropping<P>(through pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return nonmutatingVariant(of: { $0.drop(through: $1) }, on: self, with: pattern)
  }
  // @documentation(SDGCornerstone.Collection.dropping(through:))
  /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func dropping<P>(through pattern: P) -> Self
  where P: Pattern, P.Searchable == Self {
    return _dropping(through: pattern)
  }
  // #documentation(SDGCornerstone.Collection.dropping(through:))
  /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
  ///
  /// If the pattern does not occur, the collection will empty itself.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  @inlinable public func dropping(through pattern: Self) -> Self {
    return _dropping(through: pattern)
  }

  @inlinable internal mutating func _replaceMatches<P, C>(for pattern: P, with replacement: C)
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    mutateMatches(
      for: pattern,
      mutation: { (_) -> C in
        return replacement
      }
    )
  }
  // @documentation(SDGCornerstone.Collection.replaceMatches(for:with:))
  /// Replaces each match for the pattern with the elements of the replacement.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - replacement: The collection to use as a replacement
  @inlinable public mutating func replaceMatches<P, C>(for pattern: P, with replacement: C)
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    return _replaceMatches(for: pattern, with: replacement)
  }
  // #documentation(SDGCornerstone.Collection.replaceMatches(for:with:))
  /// Replaces each match for the pattern with the elements of the replacement.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - replacement: The collection to use as a replacement
  @inlinable public mutating func replaceMatches(for pattern: Self, with replacement: Self) {
    _replaceMatches(for: pattern, with: replacement)
  }

  @inlinable internal func _replacingMatches<P, C>(for pattern: P, with replacement: C) -> Self
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    return nonmutatingVariant(
      of: { $0.replaceMatches(for: $1, with: $2) },
      on: self,
      with: (pattern, replacement)
    )
  }
  // @documentation(SDGCornerstone.Collection.replacingMatches(for:with:))
  /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - replacement: The collection to use as a replacement
  @inlinable public func replacingMatches<P, C>(for pattern: P, with replacement: C) -> Self
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    return _replacingMatches(for: pattern, with: replacement)
  }
  // #documentation(SDGCornerstone.Collection.replacingMatches(for:with:))
  /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - replacement: The collection to use as a replacement
  @inlinable public func replacingMatches(for pattern: Self, with replacement: Self) -> Self {
    return _replacingMatches(for: pattern, with: replacement)
  }

  @inlinable internal mutating func _mutateMatches<P, C>(
    for pattern: P,
    mutation: (_ match: P.Match) -> C
  )
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {

    let hits = matches(for: pattern)
    var unaltered = ranges(separatedBy: hits.map({ $0.range }))

    var replacements = hits.map({ mutation($0) })

    var result = Self()
    while ¬replacements.isEmpty {
      result.append(contentsOf: self[unaltered.removeFirst()])
      result.append(contentsOf: replacements.removeFirst())
    }

    result.append(contentsOf: self[unaltered.removeFirst()])

    self = result
  }
  // @documentation(SDGCornerstone.Collection.mutateMatches(for:mutation:))
  /// Mutates each match for the pattern according to a closure.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - mutation: A closure that generates a replacement collection from a match.
  @inlinable public mutating func mutateMatches<P, C>(
    for pattern: P,
    mutation: (_ match: P.Match) -> C
  )
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    return _mutateMatches(for: pattern, mutation: mutation)
  }
  // #documentation(SDGCornerstone.Collection.mutateMatches(for:mutation:))
  /// Mutates each match for the pattern according to a closure.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - mutation: A closure that generates a replacement collection from a match.
  @inlinable public mutating func mutateMatches<C: SearchableCollection>(
    for pattern: Self,
    mutation: (_ match: Self.Match) -> C
  ) where C.Element == Self.Element {
    _mutateMatches(for: pattern, mutation: mutation)
  }

  @inlinable internal func _mutatingMatches<P, C>(
    for pattern: P,
    mutation: (_ match: P.Match) -> C
  ) -> Self
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    var copy = self
    copy.mutateMatches(for: pattern, mutation: mutation)
    return copy
  }
  // @documentation(SDGCornerstone.Collection.mutatingMatches(for:mutation:))
  /// Returns a collection formed by mutating each match for the pattern according to a closure.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - mutation: The mutation to perform on each match.
  @inlinable public func mutatingMatches<P, C>(
    for pattern: P,
    mutation: (_ match: P.Match) -> C
  ) -> Self
  where P: Pattern, C: SearchableCollection, P.Searchable == Self, C.Element == Self.Element {
    return _mutatingMatches(for: pattern, mutation: mutation)
  }
  // #documentation(SDGCornerstone.Collection.mutatingMatches(for:mutation:))
  /// Returns a collection formed by mutating each match for the pattern according to a closure.
  ///
  /// - Parameters:
  ///   - pattern: The pattern to search for.
  ///   - mutation: The mutation to perform on each match.
  @inlinable public func mutatingMatches<C: SearchableCollection>(
    for pattern: Self,
    mutation: (_ match: Self.Match) -> C
  ) -> Self where C.Element == Self.Element {
    return _mutatingMatches(for: pattern, mutation: mutation)
  }
}
