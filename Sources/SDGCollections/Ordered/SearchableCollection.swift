/*
 SearchableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics

/// An ordered collection which can be searched for elements, subsequences and patterns.
///
/// Conformance Requirements:
///
/// - `Collection`
/// - `Element : Equatable`
/// - `SubSequence : SearchableCollection`
public protocol SearchableCollection : Collection, PatternProtocol
where SubSequence : SearchableCollection {

    // @documentation(SDGCornerstone.Collection.firstMatch(for:))
    /// Returns the first match for `pattern` in the collection.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func firstMatch<P>(for pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.firstMatch(for:))
    /// Returns the first match for `pattern` in the collection.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func firstMatch(for pattern: Self) -> PatternMatch<Self>?

    // @documentation(SDGCornerstone.Collection.matches(for:))
    /// Returns a list of all matches for `pattern` in the collection.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func matches<P>(for pattern: P) -> [PatternMatch<Self>] where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.matches(for:))
    /// Returns a list of all matches for `pattern` in the collection.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func matches(for pattern: Self) -> [PatternMatch<Self>]

    // @documentation(SDGCornerstone.Collection.prefix(upTo:))
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func prefix<P>(upTo pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.prefix(upTo:))
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func prefix(upTo pattern: Self) -> PatternMatch<Self>?

    // @documentation(SDGCornerstone.Collection.prefix(through:))
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func prefix<P>(through pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.prefix(through:))
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func prefix(through pattern: Self) -> PatternMatch<Self>?

    // @documentation(SDGCornerstone.Collection.suffix(from:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func suffix<P>(from pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.suffix(from:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func suffix(from pattern: Self) -> PatternMatch<Self>?

    // @documentation(SDGCornerstone.Collection.suffix(after:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func suffix<P>(after pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.suffix(after:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func suffix(after pattern: Self) -> PatternMatch<Self>?

    /// Returns an array of ranges representing the complement of those provided.
    ///
    /// - SeeAlso: `components(separatedBy:)`
    ///
    /// - Precondition: The provided ranges must be sorted and not overlap.
    func ranges(separatedBy separators: [Range<Index>]) -> [Range<Index>]

    // @documentation(SDGCornerstone.Collection.components(separatedBy:))
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func components<P>(separatedBy pattern: P) -> [PatternMatch<Self>] where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.components(separatedBy:))
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func components(separatedBy pattern: Self) -> [PatternMatch<Self>]

    // @documentation(SDGCornerstone.Collection.contains(pattern:))
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func contains<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.contains(pattern:))
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func contains(_ pattern: Self) -> Bool

    // @documentation(SDGCornerstone.Collection.hasPrefix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    func hasPrefix<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    func hasPrefix(_ pattern: Self) -> Bool

    // @documentation(SDGCornerstone.Collection.commonPrefix(with:))
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    func commonPrefix<C : SearchableCollection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element
    // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    func commonPrefix(with other: Self) -> PatternMatch<Self>

    // @documentation(SDGCornerstone.Collection.firstNestingLevel(startingWith:endingWith:))
    // #example(1, nestingLevel)
    /// Returns the first nesting level found in the collection.
    ///
    /// Use this to search for corresponding pairs of delimiters that may be nested. For example:
    ///
    /// ```swift
    /// let equation = "2(3x − (y + 4)) = z"
    /// let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!
    ///
    /// XCTAssertEqual(String(nestingLevel.container.contents), "(3x − (y + 4))")
    /// XCTAssertEqual(String(nestingLevel.contents.contents), "3x − (y + 4)")
    /// ```
    func firstNestingLevel<C : SearchableCollection, D : SearchableCollection>(startingWith openingToken: C, endingWith closingToken: D) -> NestingLevel<Self>? where C.Element == Element, D.Element == Element
    // #documentation(SDGCornerstone.Collection.firstNestingLevel(startingWith:endingWith:))
    /// Returns the first nesting level found in the collection.
    ///
    /// Use this to search for corresponding pairs of delimiters that may be nested. For example:
    ///
    /// ```swift
    /// let equation = "2(3x − (y + 4)) = z"
    /// let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!
    ///
    /// XCTAssertEqual(String(nestingLevel.container.contents), "(3x − (y + 4))")
    /// XCTAssertEqual(String(nestingLevel.contents.contents), "3x − (y + 4)")
    /// ```
    func firstNestingLevel(startingWith openingToken: Self, endingWith closingToken: Self) -> NestingLevel<Self>?

    // @documentation(SDGCornerstone.Collection.advance(_: over:))
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @discardableResult func advance<P>(_ index: inout Index, over pattern: P) -> Bool where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.advance(_: over:))
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @discardableResult func advance(_ index: inout Index, over pattern: Self) -> Bool

    // @documentation(SDGCornerstone.Collection.difference(from:))
    /// Returns the sequence of changes necessary to transform the other collection to be the same as this one.
    ///
    /// - Parameters:
    ///     - other: The other collection. (The starting point.)
    func difference<C>(from other: C) -> [Change<C.Index, Index>] where C : SearchableCollection, C.Element == Self.Element
    // @documentation(SDGCornerstone.Collection.difference(from:))
    /// Returns the sequence of changes necessary to transform the other collection to be the same as this one.
    ///
    /// - Parameters:
    ///     - other: The other collection. (The starting point.)
    func difference(from other: Self) -> [Change<Index, Index>]
}

extension SearchableCollection {

    @inlinable @_versioned internal func _firstMatch<P>(for pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        var i = startIndex
        while i ≠ endIndex {
            if let range = pattern.primaryMatch(in: self, at: i) {
                return PatternMatch(range: range, in: self)
            }
            i = index(after: i)
        }
        return nil
    }
    // #documentation(SDGCornerstone.Collection.firstMatch(for:))
    /// Returns the first match for `pattern` in the collection.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func firstMatch<P>(for pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        return _firstMatch(for: pattern)
    }
    // #documentation(SDGCornerstone.Collection.firstMatch(for:))
    /// Returns the first match for `pattern` in the collection.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func firstMatch(for pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return _firstMatch(for: pattern)
    }
    // #documentation(SDGCornerstone.Collection.firstMatch(for:))
    /// Returns the first match for `pattern` in the collection.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func firstMatch(for pattern: Self) -> PatternMatch<Self>? {
        return _firstMatch(for: pattern)
    }

    @inlinable @_versioned internal func _matches<P>(for pattern: P) -> [PatternMatch<Self>] where P : PatternProtocol, P.Element == Element {
        var accountedFor = startIndex
        var results: [PatternMatch<Self>] = []
        while let match = self[accountedFor...].firstMatch(for: pattern) {
            accountedFor = match.range.upperBound
            results.append(match.in(self))
        }
        return results
    }
    // #documentation(SDGCornerstone.Collection.matches(for:))
    /// Returns a list of all matches for `pattern` in the collection.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func matches<P>(for pattern: P) -> [PatternMatch<Self>] where P : PatternProtocol, P.Element == Element {
        return _matches(for: pattern)
    }
    // #documentation(SDGCornerstone.Collection.matches(for:))
    /// Returns a list of all matches for `pattern` in the collection.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func matches(for pattern: CompositePattern<Element>) -> [PatternMatch<Self>] {
        return _matches(for: pattern)
    }
    // #documentation(SDGCornerstone.Collection.matches(for:))
    /// Returns a list of all matches for `pattern` in the collection.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func matches(for pattern: Self) -> [PatternMatch<Self>] {
        return _matches(for: pattern)
    }

    @inlinable @_versioned internal func _prefix<P>(upTo pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: ..<match.range.lowerBound, in: self)
    }
    // #documentation(SDGCornerstone.Collection.prefix(upTo:))
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func prefix<P>(upTo pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        return _prefix(upTo: pattern)
    }
    // #documentation(SDGCornerstone.Collection.prefix(upTo:))
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func prefix(upTo pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return _prefix(upTo: pattern)
    }
    // #documentation(SDGCornerstone.Collection.prefix(upTo:))
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func prefix(upTo pattern: Self) -> PatternMatch<Self>? {
        return _prefix(upTo: pattern)
    }

    @inlinable @_versioned internal func _prefix<P>(through pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: ..<match.range.upperBound, in: self)
    }
    // #documentation(SDGCornerstone.Collection.prefix(through:))
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func prefix<P>(through pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        return _prefix(through: pattern)
    }
    // #documentation(SDGCornerstone.Collection.prefix(through:))
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func prefix(through pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return _prefix(through: pattern)
    }
    // #documentation(SDGCornerstone.Collection.prefix(through:))
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func prefix(through pattern: Self) -> PatternMatch<Self>? {
        return _prefix(through: pattern)
    }

    @inlinable @_versioned internal func _suffix<P>(from pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: match.range.lowerBound..., in: self)
    }
    // #documentation(SDGCornerstone.Collection.suffix(from:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func suffix<P>(from pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        return _suffix(from: pattern)
    }
    // #documentation(SDGCornerstone.Collection.suffix(from:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func suffix(from pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return _suffix(from: pattern)
    }
    // #documentation(SDGCornerstone.Collection.suffix(from:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func suffix(from pattern: Self) -> PatternMatch<Self>? {
        return _suffix(from: pattern)
    }

    @inlinable @_versioned internal func _suffix<P>(after pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: match.range.upperBound..., in: self)
    }
    // #documentation(SDGCornerstone.Collection.suffix(after:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func suffix<P>(after pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        return _suffix(after: pattern)
    }
    // #documentation(SDGCornerstone.Collection.suffix(after:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func suffix(after pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return _suffix(after: pattern)
    }
    // #documentation(SDGCornerstone.Collection.suffix(after:))
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func suffix(after pattern: Self) -> PatternMatch<Self>? {
        return _suffix(after: pattern)
    }

    /// Returns an array of ranges representing the complement of those provided.
    ///
    /// - SeeAlso: `components(separatedBy:)`
    ///
    /// - Precondition: The provided ranges must be sorted and not overlap.
    @inlinable public func ranges(separatedBy separators: [Range<Index>]) -> [Range<Index>] {
        let startIndices = [startIndex] + separators.map({ $0.upperBound })
        let endIndices = separators.map({ $0.lowerBound }) + [endIndex]

        return zip(startIndices, endIndices).map({ $0 ..< $1 })
    }

    @inlinable @_versioned internal func _components<P>(separatedBy pattern: P) -> [PatternMatch<Self>] where P : PatternProtocol, P.Element == Element {
        let separators = matches(for: pattern).map { $0.range }
        return ranges(separatedBy: separators).map({ PatternMatch(range: $0, in: self) })
    }
    // #documentation(SDGCornerstone.Collection.components(separatedBy:))
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func components<P>(separatedBy pattern: P) -> [PatternMatch<Self>] where P : PatternProtocol, P.Element == Element {
        return _components(separatedBy: pattern)
    }
    // #documentation(SDGCornerstone.Collection.components(separatedBy:))
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func components(separatedBy pattern: CompositePattern<Element>) -> [PatternMatch<Self>] {
        return _components(separatedBy: pattern)
    }
    // #documentation(SDGCornerstone.Collection.components(separatedBy:))
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func components(separatedBy pattern: Self) -> [PatternMatch<Self>] {
        return _components(separatedBy: pattern)
    }

    @inlinable @_versioned internal func _contains<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        return firstMatch(for: pattern) ≠ nil
    }
    // #documentation(SDGCornerstone.Collection.contains(pattern:))
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func contains<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        return _contains(pattern)
    }
    // #documentation(SDGCornerstone.Collection.contains(pattern:))
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func contains(_ pattern: CompositePattern<Element>) -> Bool {
        return _contains(pattern)
    }
    // #documentation(SDGCornerstone.Collection.contains(pattern:))
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func contains(_ pattern: Self) -> Bool {
        return _contains(pattern)
    }

    @inlinable public func _hasPrefix<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        return pattern.primaryMatch(in: self, at: startIndex) ≠ nil
    }
    // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @inlinable public func hasPrefix<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        return _hasPrefix(pattern)
    }
    // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @inlinable public func hasPrefix(_ pattern: CompositePattern<Element>) -> Bool {
        return _hasPrefix(pattern)
    }
    // #documentation(SDGCornerstone.Collection.hasPrefix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @inlinable public func hasPrefix(_ pattern: Self) -> Bool {
        return _hasPrefix(pattern)
    }

    @inlinable @_versioned internal func _commonPrefix<C : SearchableCollection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element {
        var end: Index = startIndex
        for (ownIndex, otherIndex) in zip(indices, other.indices) {
            if self[ownIndex] == other[otherIndex] {
                end = index(after: end)
            } else {
                break
            }
        }
        return PatternMatch(range: ..<end, in: self)
    }
    // @documentation(SDGCornerstone.Collection.commonPrefix(with:))
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    @inlinable public func commonPrefix<C : SearchableCollection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element {
        return _commonPrefix(with: other)
    }
    // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    @inlinable public func commonPrefix(with other: Self) -> PatternMatch<Self> {
        return _commonPrefix(with: other)
    }

    @inlinable @_versioned internal func _firstNestingLevel<C : SearchableCollection, D : SearchableCollection>(startingWith openingToken: C, endingWith closingToken: D) -> NestingLevel<Self>? where C.Element == Element, D.Element == Element {
        var searchArea = bounds

        guard let start = self[searchArea].firstMatch(for: openingToken)?.range else {
            return nil
        }
        searchArea = start.upperBound ..< searchArea.upperBound

        var level = 1
        while let hit = self[searchArea].firstMatch(for: AlternativePatterns([
            LiteralPattern(openingToken),
            LiteralPattern(closingToken)
            ])) {

                if hit.contents.elementsEqual(openingToken) {
                    level += 1
                } else {
                    level −= 1
                    if level == 0 {
                        return NestingLevel(container: PatternMatch(range: start.lowerBound ..< hit.range.upperBound, in: self), contents: PatternMatch(range: start.upperBound ..< hit.range.lowerBound, in: self))
                    }
                }
                searchArea = hit.range.upperBound ..< searchArea.upperBound
        }

        // No more hits, level never closed.
        return nil
    }
    // #documentation(SDGCornerstone.Collection.firstNestingLevel(startingWith:endingWith:))
    /// Returns the first nesting level found in the collection.
    ///
    /// Use this to search for corresponding pairs of delimiters that may be nested. For example:
    ///
    /// ```swift
    /// let equation = "2(3x − (y + 4)) = z"
    /// let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!
    ///
    /// XCTAssertEqual(String(nestingLevel.container.contents), "(3x − (y + 4))")
    /// XCTAssertEqual(String(nestingLevel.contents.contents), "3x − (y + 4)")
    /// ```
    @inlinable public func firstNestingLevel<C : SearchableCollection, D : SearchableCollection>(startingWith openingToken: C, endingWith closingToken: D) -> NestingLevel<Self>? where C.Element == Element, D.Element == Element {
        return _firstNestingLevel(startingWith: openingToken, endingWith: closingToken)
    }
    // #documentation(SDGCornerstone.Collection.firstNestingLevel(startingWith:endingWith:))
    /// Returns the first nesting level found in the collection.
    ///
    /// Use this to search for corresponding pairs of delimiters that may be nested. For example:
    ///
    /// ```swift
    /// let equation = "2(3x − (y + 4)) = z"
    /// let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!
    ///
    /// XCTAssertEqual(String(nestingLevel.container.contents), "(3x − (y + 4))")
    /// XCTAssertEqual(String(nestingLevel.contents.contents), "3x − (y + 4)")
    /// ```
    @inlinable public func firstNestingLevel(startingWith openingToken: Self, endingWith closingToken: Self) -> NestingLevel<Self>? {
        return _firstNestingLevel(startingWith: openingToken, endingWith: closingToken)
    }

    @inlinable @_versioned internal func _advance<P>(_ index: inout Index, over pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        if let match = pattern.primaryMatch(in: self, at: index) {
            index = match.upperBound
            return true
        } else {
            return false
        }
    }
    // @documentation(SDGCornerstone.Collection.advance(_: over:))
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @inlinable @discardableResult public func advance<P>(_ index: inout Index, over pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        return _advance(&index, over: pattern)
    }
    // #documentation(SDGCornerstone.Collection.advance(_: over:))
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @inlinable @discardableResult public func advance(_ index: inout Index, over pattern: CompositePattern<Element>) -> Bool {
        return _advance(&index, over: pattern)
    }
    // #documentation(SDGCornerstone.Collection.advance(_: over:))
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @inlinable @discardableResult public func advance(_ index: inout Index, over pattern: Self) -> Bool {
        return _advance(&index, over: pattern)
    }

    @inlinable @_versioned internal func longestCommonSubsequenceTable<C>(with other: C, indexCache: inout [Int: Index], otherIndexCache: inout [Int: C.Index]) -> [[Int]] where C : SearchableCollection, C.Element == Self.Element {
        let row = [Int](repeating: 0, count: Int(other.count) + 1)
        var table = [[Int]](repeating: row, count: Int(count) + 1)
        if ¬isEmpty ∧ ¬other.isEmpty {
            for prefixLength in 1 ... Int(count) {
                for otherPrefixLength in 1 ... Int(other.count) {
                    let lastIndexDistance = prefixLength − 1
                    let otherLastIndexDistance = otherPrefixLength − 1
                    let lastIndex = cached(in: &indexCache[lastIndexDistance]) { self.index(startIndex, offsetBy: lastIndexDistance) }
                    let otherLastIndex = cached(in: &otherIndexCache[otherLastIndexDistance]) { other.index(other.startIndex, offsetBy: otherLastIndexDistance) }
                    if self[lastIndex] == other[otherLastIndex] {
                        table[prefixLength][otherPrefixLength] = table[prefixLength − 1][otherPrefixLength − 1] + 1
                    } else {
                        table[prefixLength][otherPrefixLength] = Swift.max(table[prefixLength][otherPrefixLength − 1], table[prefixLength − 1][otherPrefixLength])
                    }
                }
            }
        }
        return table
    }

    @inlinable @_versioned internal func traceDifference<C>(_ table: [[Int]], other: C, prefixLength: Int, otherPrefixLength: Int, differenceUnderConstruction: inout [IndividualChange<Index, C.Index>], indexCache: inout [Int: Index], otherIndexCache: inout [Int: C.Index]) where C : SearchableCollection, C.Element == Self.Element {

        // The “? :” prevents springing bounds. Such indices will not be queried anyway.
        let lastIndexDistance = prefixLength == 0 ? 0 : prefixLength − 1
        let otherLastIndexDistance = otherPrefixLength == 0 ? 0 : otherPrefixLength − 1

        let lastIndex = cached(in: &indexCache[lastIndexDistance]) { self.index(startIndex, offsetBy: lastIndexDistance) } // @exempt(from: tests) Already present.
        let otherLastIndex = cached(in: &otherIndexCache[otherLastIndexDistance]) { other.index(other.startIndex, offsetBy: otherLastIndexDistance) } // @exempt(from: tests) Already present.
        if prefixLength > 0 ∧ otherPrefixLength > 0 ∧ self[lastIndex] == other[otherLastIndex] {
            traceDifference(table, other: other, prefixLength: prefixLength − 1, otherPrefixLength: otherPrefixLength − 1, differenceUnderConstruction: &differenceUnderConstruction, indexCache: &indexCache, otherIndexCache: &otherIndexCache)
            differenceUnderConstruction.append(.keep(lastIndex))
        } else if otherPrefixLength > 0 ∧ (prefixLength == 0 ∨ table[prefixLength][(otherPrefixLength − 1) as Int] ≥ table[(prefixLength − 1) as Int][otherPrefixLength]) {
            traceDifference(table, other: other, prefixLength: prefixLength, otherPrefixLength: otherPrefixLength − 1, differenceUnderConstruction: &differenceUnderConstruction, indexCache: &indexCache, otherIndexCache: &otherIndexCache)
            differenceUnderConstruction.append(.insert(otherLastIndex))
        } else if prefixLength > 0 ∧ (otherPrefixLength == 0 ∨ table[prefixLength][(otherPrefixLength − 1) as Int] < table[(prefixLength − 1) as Int][otherPrefixLength]) {
            traceDifference(table, other: other, prefixLength: prefixLength − 1, otherPrefixLength: otherPrefixLength, differenceUnderConstruction: &differenceUnderConstruction, indexCache: &indexCache, otherIndexCache: &otherIndexCache)
            differenceUnderConstruction.append(.remove(lastIndex))
        }
    }

    @inlinable @_versioned internal func changes<C>(toMake other: C) -> [Change<Index, C.Index>] where C : SearchableCollection, C.Element == Self.Element {
        var indexCache: [Int: Index] = [:]
        var otherIndexCache: [Int: C.Index] = [:]
        let table = longestCommonSubsequenceTable(with: other, indexCache: &indexCache, otherIndexCache: &otherIndexCache)
        var differenceUnderConstruction: [IndividualChange<Index, C.Index>] = []
        traceDifference(table, other: other, prefixLength: table.count − 1, otherPrefixLength: table.first!.count − 1, differenceUnderConstruction: &differenceUnderConstruction, indexCache: &indexCache, otherIndexCache: &otherIndexCache)

        var changeGroups: [Change<Index, C.Index>] = []
        changes: for individualChange in differenceUnderConstruction {
            if let last = changeGroups.last {
                switch last {
                case .keep(let range):
                    switch individualChange {
                    case .keep(let index):
                        changeGroups.removeLast()
                        changeGroups.append(.keep((range.lowerBound ... index).relative(to: self)))
                        continue changes
                    default:
                        break
                    }
                case .remove(let range):
                    switch individualChange {
                    case .remove(let index):
                        changeGroups.removeLast()
                        changeGroups.append(.remove((range.lowerBound ... index).relative(to: self)))
                        continue changes
                    default:
                        break
                    }
                case .insert(let range):
                    switch individualChange {
                    case .insert(let index):
                        changeGroups.removeLast()
                        changeGroups.append(.insert((range.lowerBound ... index).relative(to: other)))
                        continue changes
                    default:
                        break
                    }
                }
            }
            switch individualChange {
            case .keep(let index):
                changeGroups.append(.keep((index ... index).relative(to: self)))
            case .remove(let index):
                changeGroups.append(.remove((index ... index).relative(to: self)))
            case .insert(let index):
                changeGroups.append(.insert((index ... index).relative(to: other)))
            }
        }
        return changeGroups
    }

    @inlinable @_versioned internal func suffixIgnorantDifference<C>(from other: C) -> [Change<C.Index, Index>] where C : SearchableCollection, C.Element == Self.Element {
        let prefixEnd = commonPrefix(with: other).range.upperBound
        let prefixLength = distance(from: startIndex, to: prefixEnd)
        let otherPrefixEnd = other.index(other.startIndex, offsetBy: prefixLength)

        var difference: [Change<C.Index, Index>] = []
        if prefixLength ≠ 0 {
            difference.append(.keep(other.startIndex ..< otherPrefixEnd))
        }

        difference.append(contentsOf: other.suffix(from: otherPrefixEnd).changes(toMake: self.suffix(from: prefixEnd)))

        return difference
    }
    // @documentation(SDGCornerstone.Collection.difference(from:))
    /// Returns the sequence of changes necessary to transform the other collection to be the same as this one.
    ///
    /// - Parameters:
    ///     - other: The other collection. (The starting point.)
    @inlinable public func difference<C>(from other: C) -> [Change<C.Index, Index>] where C : SearchableCollection, C.Element == Self.Element {
        return suffixIgnorantDifference(from: other)
    }
    // @documentation(SDGCornerstone.Collection.difference(from:))
    /// Returns the sequence of changes necessary to transform the other collection to be the same as this one.
    ///
    /// - Parameters:
    ///     - other: The other collection. (The starting point.)
    @inlinable public func difference(from other: Self) -> [Change<Index, Index>] {
        return suffixIgnorantDifference(from: other)
    }

    // MARK: - PatternProtocol

    // #documentation(SDGCornerstone.PatternProtocol.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        var checkingIndex = self.startIndex
        var collectionIndex = location
        while checkingIndex ≠ self.endIndex {
            guard collectionIndex ≠ collection.endIndex else {
                // Ran out of space to check.
                return nil
            }

            if self[checkingIndex] ≠ collection[collectionIndex] {
                // Mis‐match.
                return nil
            }

            checkingIndex = self.index(after: checkingIndex)
            collectionIndex = collection.index(after: collectionIndex)
        }

        return location ..< collectionIndex
    }
}

extension SearchableCollection where Self : RangeReplaceableCollection {
    // MARK: - where Self : RangeReplaceableCollection

    @inlinable @_versioned internal mutating func _truncate<P>(before pattern: P) where P : PatternProtocol, P.Element == Element {
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
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func truncate<P>(before pattern: P) where P : PatternProtocol, P.Element == Element {
        return _truncate(before: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucate(before:))
    /// Truncates `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func truncate(before pattern: CompositePattern<Element>) {
        _truncate(before: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucate(after:))
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func truncate(before pattern: Self) {
        _truncate(before: pattern)
    }

    @inlinable @_versioned internal func _truncated<P>(before pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return nonmutatingVariant(of: { $0.truncate(before: $1) }, on: self, with: pattern)
    }
    // @documentation(SDGCornerstone.Collection.trucated(before:))
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func truncated<P>(before pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return _truncated(before: pattern)
    }

    // #documentation(SDGCornerstone.Collection.trucated(before:))
    /// Returns a collection formed by truncating `self` at the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func truncated(before pattern: CompositePattern<Element>) -> Self {
        return _truncated(before: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucated(after:))
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func truncated(before pattern: Self) -> Self {
        return _truncated(before: pattern)
    }

    @inlinable @_versioned internal mutating func _truncate<P>(after pattern: P) where P : PatternProtocol, P.Element == Element {
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
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func truncate<P>(after pattern: P) where P : PatternProtocol, P.Element == Element {
        return _truncate(after: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucate(after:))
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func truncate(after pattern: CompositePattern<Element>) {
        _truncate(after: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucate(after:))
    /// Truncates `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func truncate(after pattern: Self) {
        _truncate(after: pattern)
    }

    @inlinable @_versioned internal func _truncated<P>(after pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return nonmutatingVariant(of: { $0.truncate(after: $1) }, on: self, with: pattern)
    }
    // @documentation(SDGCornerstone.Collection.trucated(after:))
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func truncated<P>(after pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return _truncated(after: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucated(after:))
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func truncated(after pattern: CompositePattern<Element>) -> Self {
        return _truncated(after: pattern)
    }
    // #documentation(SDGCornerstone.Collection.trucated(after:))
    /// Returns a collection formed by truncating `self` at the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will remain unchanged.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func truncated(after pattern: Self) -> Self {
        return _truncated(after: pattern)
    }

    @inlinable @_versioned internal mutating func _drop<P>(upTo pattern: P) where P : PatternProtocol, P.Element == Element {
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
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func drop<P>(upTo pattern: P) where P : PatternProtocol, P.Element == Element {
        return _drop(upTo: pattern)
    }
    // #documentation(SDGCornerstone.Collection.drop(upTo:))
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func drop(upTo pattern: CompositePattern<Element>) {
        _drop(upTo: pattern)
    }
    // #documentation(SDGCornerstone.Collection.drop(upTo:))
    /// Drops elements from the beginning of the collection to the start of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func drop(upTo pattern: Self) {
        _drop(upTo: pattern)
    }

    @inlinable @_versioned internal func _dropping<P>(upTo pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return nonmutatingVariant(of: { $0.drop(upTo: $1) }, on: self, with: pattern)
    }
    // @documentation(SDGCornerstone.Collection.dropping(upTo:))
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func dropping<P>(upTo pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return _dropping(upTo: pattern)
    }
    // #documentation(SDGCornerstone.Collection.dropping(upTo:))
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func dropping(upTo pattern: CompositePattern<Element>) -> Self {
        return _dropping(upTo: pattern)
    }
    // #documentation(SDGCornerstone.Collection.dropping(upTo:))
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the start of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func dropping(upTo pattern: Self) -> Self {
        return _dropping(upTo: pattern)
    }

    @inlinable @_versioned internal mutating func _drop<P>(through pattern: P) where P : PatternProtocol, P.Element == Element {
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
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func drop<P>(through pattern: P) where P : PatternProtocol, P.Element == Element {
        return _drop(through: pattern)
    }
    // #documentation(SDGCornerstone.Collection.drop(through:))
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func drop(through pattern: CompositePattern<Element>) {
        _drop(through: pattern)
    }
    // #documentation(SDGCornerstone.Collection.drop(through:))
    /// Drops elements from the beginning of the collection to the end of the first match for the specified pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public mutating func drop(through pattern: Self) {
        _drop(through: pattern)
    }

    @inlinable @_versioned internal func _dropping<P>(through pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return nonmutatingVariant(of: { $0.drop(through: $1) }, on: self, with: pattern)
    }
    // @documentation(SDGCornerstone.Collection.dropping(through:))
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func dropping<P>(through pattern: P) -> Self where P : PatternProtocol, P.Element == Element {
        return _dropping(through: pattern)
    }
    // #documentation(SDGCornerstone.Collection.dropping(through:))
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func dropping(through pattern: CompositePattern<Element>) -> Self {
        return _dropping(through: pattern)
    }
    // #documentation(SDGCornerstone.Collection.dropping(through:))
    /// Returns a collection formed by dropping the elements from the beginning of the collection to the end of the first match for the pattern.
    ///
    /// If the pattern does not occur, the collection will empty itself.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    @inlinable public func dropping(through pattern: Self) -> Self {
        return _dropping(through: pattern)
    }

    @inlinable @_versioned internal mutating func _replaceMatches<P, C>(for pattern: P, with replacement: C) where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        mutateMatches(for: pattern, mutation: { (_) -> C in
            return replacement
        })
    }
    // @documentation(SDGCornerstone.Collection.replaceMatches(for:with:))
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public mutating func replaceMatches<P, C>(for pattern: P, with replacement: C) where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        return _replaceMatches(for: pattern, with: replacement)
    }
    // #documentation(SDGCornerstone.Collection.replaceMatches(for:with:))
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public mutating func replaceMatches<C : SearchableCollection>(for pattern: CompositePattern<Element>, with replacement: C) where C.Element == Self.Element {
        _replaceMatches(for: pattern, with: replacement)
    }
    // #documentation(SDGCornerstone.Collection.replaceMatches(for:with:))
    /// Replaces each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public mutating func replaceMatches(for pattern: Self, with replacement: Self) {
        _replaceMatches(for: pattern, with: replacement)
    }

    @inlinable @_versioned internal func _replacingMatches<P, C>(for pattern: P, with replacement: C) -> Self where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        return nonmutatingVariant(of: { $0.replaceMatches(for: $1, with: $2) }, on: self, with: (pattern, replacement))
    }
    // @documentation(SDGCornerstone.Collection.replacingMatches(for:with:))
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public func replacingMatches<P, C>(for pattern: P, with replacement: C) -> Self where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        return _replacingMatches(for: pattern, with: replacement)
    }

    // #documentation(SDGCornerstone.Collection.replacingMatches(for:with:))
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public func replacingMatches<C : SearchableCollection>(for pattern: CompositePattern<Element>, with replacement: C) -> Self where C.Element == Self.Element {
        return _replacingMatches(for: pattern, with: replacement)
    }
    // #documentation(SDGCornerstone.Collection.replacingMatches(for:with:))
    /// Returns a collection formed by replacing each match for the pattern with the elements of the replacement.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public func replacingMatches(for pattern: Self, with replacement: Self) -> Self {
        return _replacingMatches(for: pattern, with: replacement)
    }

    @inlinable @_versioned internal mutating func _mutateMatches<P, C>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {

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
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    @inlinable public mutating func mutateMatches<P, C>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        return _mutateMatches(for: pattern, mutation: mutation)
    }
    // #documentation(SDGCornerstone.Collection.mutateMatches(for:mutation:))
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    @inlinable public mutating func mutateMatches<C : SearchableCollection>(for pattern: CompositePattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        _mutateMatches(for: pattern, mutation: mutation)
    }
    // #documentation(SDGCornerstone.Collection.mutateMatches(for:mutation:))
    /// Mutates each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - mutation: A closure that generates a replacement collection from a match.
    @inlinable public mutating func mutateMatches<C : SearchableCollection>(for pattern: Self, mutation: (_ match: PatternMatch<Self>) -> C) where C.Element == Self.Element {
        _mutateMatches(for: pattern, mutation: mutation)
    }

    @inlinable @_versioned internal func _mutatingMatches<P, C>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        var copy = self
        copy.mutateMatches(for: pattern, mutation: mutation)
        return copy
    }
    // @documentation(SDGCornerstone.Collection.mutatingMatches(for:mutation:))
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public func mutatingMatches<P, C>(for pattern: P, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where P : PatternProtocol, C : SearchableCollection, P.Element == Self.Element, C.Element == Self.Element {
        return _mutatingMatches(for: pattern, mutation: mutation)
    }

    // #documentation(SDGCornerstone.Collection.mutatingMatches(for:mutation:))
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public func mutatingMatches<C : SearchableCollection>(for pattern: CompositePattern<Element>, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        return _mutatingMatches(for: pattern, mutation: mutation)
    }
    // #documentation(SDGCornerstone.Collection.mutatingMatches(for:mutation:))
    /// Returns a collection formed by mutating each match for the pattern according to a closure.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - replacement: The collection to use as a replacement
    @inlinable public func mutatingMatches<C : SearchableCollection>(for pattern: Self, mutation: (_ match: PatternMatch<Self>) -> C) -> Self where C.Element == Self.Element {
        return _mutatingMatches(for: pattern, mutation: mutation)
    }
}
