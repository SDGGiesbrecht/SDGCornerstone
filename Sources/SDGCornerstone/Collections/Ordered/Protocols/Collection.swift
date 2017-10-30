/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension Collection {

    // MARK: - Conformance

    // [_Define Documentation: SDGCornerstone.Collection.Element_]
    /// The type of the elements of the collection.

    // [_Define Documentation: SDGCornerstone.Collection.Index_]
    /// The type of the indices of the collection.

    // [_Define Documentation: SDGCornerstone.Collection.IndexDistance_]
    /// The type that represents the number of steps between a pair of indices.

    // [_Define Documentation: SDGCornerstone.Collection.Indices_]
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.

    // [_Define Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.

    // [_Define Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.

    // [_Define Documentation: SDGCornerstone.Collection.subscript(position:)_]
    /// Accesses the element at the specified position.

    // [_Define Documentation: SDGCornerstone.Collection.count_]
    /// The number of elements in the collection.

    // [_Define Documentation: SDGCornerstone.Collection.index(after:)_]
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.

    // MARK: - Indices

    /// Returns the range for all of `self`.
    public var bounds: Range<Index> {
        return startIndex ..< endIndex
    }

    internal func assertIndexExists(_ index: Index) {
        assert(index ∈ bounds, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Code Coverage_]
                return "Index out of bounds."
            }
        }))
    }

    /// Returns the backward version of the specified range.
    public func backward(_ range: Range<Self.Index>) -> Range<ReversedIndex<Self>> {
        return ReversedIndex(range.upperBound) ..< ReversedIndex(range.lowerBound)
    }

    /// Returns the forward version of the specified range.
    public func forward(_ range: Range<ReversedIndex<Self>>) ->  Range<Self.Index> {
        return range.upperBound.base ..< range.lowerBound.base
    }
}

extension Collection where Element : Equatable {
    // MARK: - where Element : Equatable

    // [_Define Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch(for pattern: Pattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        let searchArea = searchRange ?? bounds

        var i = searchArea.lowerBound
        while i ≠ searchArea.upperBound {
            if let range = pattern.primaryMatch(in: self, at: i) {
                return PatternMatch(range: range, in: self)
            }
            i = index(after: i)
        }
        return nil
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch(for pattern: LiteralPattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        return firstMatch(for: pattern as Pattern<Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch(for pattern: CompositePattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        return firstMatch(for: pattern as Pattern<Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch<C : Collection>(for pattern: C, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? where C.Element == Self.Element {
        return firstMatch(for: LiteralPattern(pattern), in: searchRange)
    }

    // [_Define Documentation: SDGCornerstone.Collection.matches(for:in:)_]
    /// Returns a list of all matches for `pattern` in the specified subrange.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func matches(for pattern: Pattern<Element>, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] {
        let searchArea = searchRange ?? bounds

        var accountedFor = searchArea.lowerBound
        var results: [PatternMatch<Self>] = []
        while let match = firstMatch(for: pattern, in: accountedFor ..< searchArea.upperBound) {
            accountedFor = match.range.upperBound
            results.append(match)
        }
        return results
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.matches(for:in:)_]
    /// Returns a list of all matches for `pattern` in the specified subrange.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func matches(for pattern: LiteralPattern<Element>, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] {
        return matches(for: pattern as Pattern<Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.matches(for:in:)_]
    /// Returns a list of all matches for `pattern` in the specified subrange.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func matches(for pattern: CompositePattern<Element>, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] {
        return matches(for: pattern as Pattern<Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.matches(for:in:)_]
    /// Returns a list of all matches for `pattern` in the specified subrange.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func matches<C : Collection>(for pattern: C, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] where C.Element == Self.Element {
        return matches(for: LiteralPattern(pattern), in: searchRange)
    }

    // [_Define Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(upTo pattern: Pattern<Element>) -> PatternMatch<Self>? {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: startIndex ..< match.range.lowerBound, in: self)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(upTo pattern: LiteralPattern<Element>) -> PatternMatch<Self>? {
        return prefix(upTo: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(upTo pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return prefix(upTo: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix<C : Collection>(upTo pattern: C) -> PatternMatch<Self>? where C.Element == Self.Element {
        return prefix(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(through pattern: Pattern<Element>) -> PatternMatch<Self>? {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: startIndex ..< match.range.upperBound, in: self)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(through pattern: LiteralPattern<Element>) -> PatternMatch<Self>? {
        return prefix(through: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(through pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return prefix(through: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix<C : Collection>(through pattern: C) -> PatternMatch<Self>? where C.Element == Self.Element {
        return prefix(through: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(from pattern: Pattern<Element>) -> PatternMatch<Self>? {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: match.range.lowerBound ..< endIndex, in: self)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(from pattern: LiteralPattern<Element>) -> PatternMatch<Self>? {
        return suffix(from: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(from pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return suffix(from: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix<C : Collection>(from pattern: C) -> PatternMatch<Self>? where C.Element == Self.Element {
        return suffix(from: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(after pattern: Pattern<Element>) -> PatternMatch<Self>? {
        guard let match = firstMatch(for: pattern) else {
            return nil
        }
        return PatternMatch(range: match.range.upperBound ..< endIndex, in: self)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(after pattern: LiteralPattern<Element>) -> PatternMatch<Self>? {
        return suffix(after: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(after pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return suffix(after: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix<C : Collection>(after pattern: C) -> PatternMatch<Self>? where C.Element == Self.Element {
        return suffix(after: LiteralPattern(pattern))
    }

    internal func ranges(separatedBy separators: [Range<Index>]) -> [Range<Index>] {
        let startIndices = [startIndex] + separators.map({ $0.upperBound })
        let endIndices = separators.map({ $0.lowerBound }) + [endIndex]

        return zip(startIndices, endIndices).map({ $0 ..< $1 })
    }

    // [_Define Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components(separatedBy pattern: Pattern<Element>) -> [PatternMatch<Self>] {
        let separators = matches(for: pattern).map() { $0.range }
        return ranges(separatedBy: separators).map({ PatternMatch(range: $0, in: self) })
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components(separatedBy pattern: LiteralPattern<Element>) -> [PatternMatch<Self>] {
        return components(separatedBy: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components(separatedBy pattern: CompositePattern<Element>) -> [PatternMatch<Self>] {
        return components(separatedBy: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components<C : Collection>(separatedBy pattern: C) -> [PatternMatch<Self>] where C.Element == Self.Element {
        return components(separatedBy: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains(_ pattern: Pattern<Element>) -> Bool {
        return firstMatch(for: pattern) ≠ nil
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains(_ pattern: LiteralPattern<Element>) -> Bool {
        return contains(pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains(_ pattern: CompositePattern<Element>) -> Bool {
        return contains(pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains<C : Collection>(_ pattern: C) -> Bool where C.Element == Self.Element {
        return contains(LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix(_ pattern: Pattern<Element>) -> Bool {
        return pattern.primaryMatch(in: self, at: startIndex) ≠ nil
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix(_ pattern: LiteralPattern<Element>) -> Bool {
        return hasPrefix(pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix(_ pattern: CompositePattern<Element>) -> Bool {
        return hasPrefix(pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix<C : Collection>(_ pattern: C) -> Bool where C.Element == Self.Element {
        return hasPrefix(LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix(_ pattern: Pattern<Element>) -> Bool {
        let backwards = reversed()
        return pattern.reversed().primaryMatch(in: backwards, at: backwards.startIndex) ≠ nil
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix(_ pattern: LiteralPattern<Element>) -> Bool {
        return hasSuffix(pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix(_ pattern: CompositePattern<Element>) -> Bool {
        return hasSuffix(pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix<C : Collection>(_ pattern: C) -> Bool where C.Element == Self.Element {
        return hasSuffix(LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.commonPrefix(with:)_]
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    public func commonPrefix<C : Collection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element {
        var end: Index = startIndex
        for (ownIndex, otherIndex) in zip(indices, other.indices) {
            if self[ownIndex] == other[otherIndex] {
                end = index(after: end)
            } else {
                break
            }
        }
        return PatternMatch(range: startIndex ..< end, in: self)
    }

    // [_Example 1: Nesting Level_]
    /// Returns the first nesting level found in the specified range.
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
    public func firstNestingLevel<C : Collection, D : Collection>(startingWith openingToken: C, endingWith closingToken: D, in searchRange: Range<Index>? = nil) -> NestingLevel<Self>? where C.Element == Element, D.Element == Element {
        var searchArea = searchRange ?? bounds

        guard let start = firstMatch(for: LiteralPattern(openingToken), in: searchArea)?.range else {
            return nil
        }
        searchArea = start.upperBound ..< searchArea.upperBound

        var level = 1
        while let hit = firstMatch(for: AlternativePatterns([
            LiteralPattern(openingToken),
            LiteralPattern(closingToken)
            ]), in: searchArea) {

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

    // [_Define Documentation: SDGCornerstone.Collection.advance(_: over:)_]
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @discardableResult public func advance(_ index: inout Index, over pattern: Pattern<Element>) -> Bool {
        if let match = pattern.primaryMatch(in: self, at: index) {
            index = match.upperBound
            return true
        } else {
            return false
        }
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.advance(_: over:)_]
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @discardableResult public func advance(_ index: inout Index, over pattern: LiteralPattern<Element>) -> Bool {
        return advance(&index, over: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.advance(_: over:)_]
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @discardableResult public func advance(_ index: inout Index, over pattern: CompositePattern<Element>) -> Bool {
        return advance(&index, over: pattern as Pattern<Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.advance(_: over:)_]
    /// Advances the index over the pattern.
    ///
    /// - Parameters:
    ///     - index: The index to advance.
    ///     - pattern: The pattern to advance over.
    ///
    /// - Returns: `true` if the index was advanced over a match, `false` if there was no match.
    @discardableResult public func advance<C : Collection>(_ index: inout Index, over pattern: C) -> Bool where C.Element == Self.Element {
        return advance(&index, over: LiteralPattern(pattern))
    }
}

extension Collection where Element : Hashable, Index : Hashable {
    // MARK: - where Element: Hashable, Index : Hashable

    /// Returns the collection as a `BjectiveMapping` between the indices and values.
    ///
    /// - Requires: No values are repeated.
    public var bijectiveIndexMapping: BijectiveMapping<Index, Element> {
        return BijectiveMapping(indexMapping)
    }
}

extension Collection where Index : Hashable {
    // MARK: - where Index : Hashable

    /// Returns the collection as a `Dictionary`, with the collection’s indices used as keys.
    public var indexMapping: [Index: Element] {
        var mapping: [Index: Element] = [:]
        for index in indices {
            mapping[index] = self[index]
        }
        return mapping
    }
}

extension Collection where IndexDistance : WholeArithmetic {
    // MARK: - where IndexDistance : WholeArithmetic

    /// Returns a random index from the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    public func randomIndex(fromRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Index {
        let random = IndexDistance(randomInRange: 0 ... count − 1, fromRandomizer: randomizer)
        return index(startIndex, offsetBy: random)
    }

    /// Returns a random element from the collection.
    ///
    /// - Parameters:
    ///     - randomizer: A particular randomizer to use. (A `PseudorandomNumberGenerator` by default.)
    public func randomElement(fromRandomizer randomizer: Randomizer = PseudorandomNumberGenerator.defaultGenerator) -> Element {
        return self[randomIndex(fromRandomizer: randomizer)]
    }
}

extension Collection where Element == UnicodeScalar {
    // MARK: - where Element == UnicodeScalar

    // [_Inherit Documentation: SDGCornerstone.String.isMultiline_]
    /// Whether or not the string contains multiple lines.
    public var isMultiline: Bool {
        return contains(where: { $0 ∈ CharacterSet.newlines })
    }
}
