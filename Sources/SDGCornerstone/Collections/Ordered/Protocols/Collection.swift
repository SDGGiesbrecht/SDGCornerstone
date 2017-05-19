/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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

    /// Returns the backward version of the specified range.
    public func backward(_ range: Range<Self.Index>) -> Range<ReversedIndex<Self>> {
        return ReversedIndex(range.upperBound) ..< ReversedIndex(range.lowerBound)
    }

    /// Returns the forward version of the specified range.
    public func forward(_ range: Range<ReversedIndex<Self>>) ->  Range<Self.Index> {
        return range.upperBound.base ..< range.lowerBound.base
    }
}

extension Collection where Iterator.Element : Equatable {
    // MARK: - where Iterator.Element : Equatable

    // [_Define Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch(for pattern: Pattern<Iterator.Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        let searchArea = searchRange ?? bounds

        var i = searchArea.lowerBound
        while i ≠ searchArea.upperBound {
            if let range = pattern.matches(in: self, at: i).first {
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
    public func firstMatch(for pattern: LiteralPattern<Iterator.Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        return firstMatch(for: pattern as Pattern<Iterator.Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch(for pattern: CompositePattern<Iterator.Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        return firstMatch(for: pattern as Pattern<Iterator.Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch<C : Collection>(for pattern: C, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? where C.Iterator.Element == Self.Iterator.Element {
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
    public func matches(for pattern: Pattern<Iterator.Element>, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] {
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
    public func matches(for pattern: LiteralPattern<Iterator.Element>, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] {
        return matches(for: pattern as Pattern<Iterator.Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.matches(for:in:)_]
    /// Returns a list of all matches for `pattern` in the specified subrange.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func matches(for pattern: CompositePattern<Iterator.Element>, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] {
        return matches(for: pattern as Pattern<Iterator.Element>, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.matches(for:in:)_]
    /// Returns a list of all matches for `pattern` in the specified subrange.
    ///
    /// This does not check for overlapping matches.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func matches<C : Collection>(for pattern: C, in searchRange: Range<Index>? = nil) -> [PatternMatch<Self>] where C.Iterator.Element == Self.Iterator.Element {
        return matches(for: LiteralPattern(pattern), in: searchRange)
    }

    // [_Define Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(upTo pattern: Pattern<Iterator.Element>) -> PatternMatch<Self>? {
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
    public func prefix(upTo pattern: LiteralPattern<Iterator.Element>) -> PatternMatch<Self>? {
        return prefix(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(upTo pattern: CompositePattern<Iterator.Element>) -> PatternMatch<Self>? {
        return prefix(upTo: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(upTo:)_]
    /// Returns the subsequence of `self` up to the start of `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix<C : Collection>(upTo pattern: C) -> PatternMatch<Self>? where C.Iterator.Element == Self.Iterator.Element {
        return prefix(upTo: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(through pattern: Pattern<Iterator.Element>) -> PatternMatch<Self>? {
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
    public func prefix(through pattern: LiteralPattern<Iterator.Element>) -> PatternMatch<Self>? {
        return prefix(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix(through pattern: CompositePattern<Iterator.Element>) -> PatternMatch<Self>? {
        return prefix(through: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.prefix(through:)_]
    /// Returns the subsequence of `self` up to and including `pattern`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func prefix<C : Collection>(through pattern: C) -> PatternMatch<Self>? where C.Iterator.Element == Self.Iterator.Element {
        return prefix(through: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(from pattern: Pattern<Iterator.Element>) -> PatternMatch<Self>? {
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
    public func suffix(from pattern: LiteralPattern<Iterator.Element>) -> PatternMatch<Self>? {
        return suffix(from: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(from pattern: CompositePattern<Iterator.Element>) -> PatternMatch<Self>? {
        return suffix(from: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(from:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix<C : Collection>(from pattern: C) -> PatternMatch<Self>? where C.Iterator.Element == Self.Iterator.Element {
        return suffix(from: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(after pattern: Pattern<Iterator.Element>) -> PatternMatch<Self>? {
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
    public func suffix(after pattern: LiteralPattern<Iterator.Element>) -> PatternMatch<Self>? {
        return suffix(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix(after pattern: CompositePattern<Iterator.Element>) -> PatternMatch<Self>? {
        return suffix(after: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.suffix(after:)_]
    /// Returns the subsequence from the beginning `pattern` to the end of `self`, or `nil` if `pattern` does not occur.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func suffix<C : Collection>(after pattern: C) -> PatternMatch<Self>? where C.Iterator.Element == Self.Iterator.Element {
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
    public func components(separatedBy pattern: Pattern<Iterator.Element>) -> [PatternMatch<Self>] {
        let separators = matches(for: pattern).map() { $0.range }
        return ranges(separatedBy: separators).map({ PatternMatch(range: $0, in: self) })
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components(separatedBy pattern: LiteralPattern<Iterator.Element>) -> [PatternMatch<Self>] {
        return components(separatedBy: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components(separatedBy pattern: CompositePattern<Iterator.Element>) -> [PatternMatch<Self>] {
        return components(separatedBy: pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.components(separatedBy:)_]
    /// Returns the segments of `self` separated by instances of `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func components<C : Collection>(separatedBy pattern: C) -> [PatternMatch<Self>] where C.Iterator.Element == Self.Iterator.Element {
        return components(separatedBy: LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains(_ pattern: Pattern<Iterator.Element>) -> Bool {
        return firstMatch(for: pattern) ≠ nil
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains(_ pattern: LiteralPattern<Iterator.Element>) -> Bool {
        return contains(pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains(_ pattern: CompositePattern<Iterator.Element>) -> Bool {
        return contains(pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.contains(pattern:)_]
    /// Returns `true` if `self` contains an match for `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    public func contains<C : Collection>(_ pattern: C) -> Bool where C.Iterator.Element == Self.Iterator.Element {
        return contains(LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix(_ pattern: Pattern<Iterator.Element>) -> Bool {
        return ¬pattern.matches(in: self, at: startIndex).isEmpty
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix(_ pattern: LiteralPattern<Iterator.Element>) -> Bool {
        return hasPrefix(pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix(_ pattern: CompositePattern<Iterator.Element>) -> Bool {
        return hasPrefix(pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasPrefix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasPrefix<C : Collection>(_ pattern: C) -> Bool where C.Iterator.Element == Self.Iterator.Element {
        return hasPrefix(LiteralPattern(pattern))
    }

    // [_Define Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix(_ pattern: Pattern<Iterator.Element>) -> Bool {
        let backwards = reversed()
        return ¬pattern.reversed().matches(in: backwards, at: backwards.startIndex).isEmpty
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix(_ pattern: LiteralPattern<Iterator.Element>) -> Bool {
        return hasSuffix(pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix(_ pattern: CompositePattern<Iterator.Element>) -> Bool {
        return hasSuffix(pattern as Pattern<Iterator.Element>)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    public func hasSuffix<C : Collection>(_ pattern: C) -> Bool where C.Iterator.Element == Self.Iterator.Element {
        return hasSuffix(LiteralPattern(pattern))
    }
}

extension Collection where Iterator.Element : Equatable, Indices.Iterator.Element == Index {
    // MARK: - where Iterator.Element : Equatable, Indices.Iterator.Element == Index

    // [_Define Documentation: SDGCornerstone.Collection.commonPrefix(with:)_]
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    public func commonPrefix<C : Collection>(with other: C) -> PatternMatch<Self> where C.Iterator.Element == Self.Iterator.Element, C.Indices.Iterator.Element == C.Index {
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
}

extension Collection where Iterator.Element : Equatable, SubSequence.Iterator.Element == Iterator.Element {
    // MARK: - where Iterator.Element : Equatable, SubSequence.Iterator.Element == Iterator.Element

    // [_Example 1: Nesting Level_]
    /// Returns the first nesting level found in the specified range.
    ///
    /// Use this to search for corresponding pairs of delimiters that may be nested. For example:
    ///
    /// ```swift
    /// let equation = "2(3x − (y + 4)) = z"
    /// let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!
    ///
    /// print(String(nestingLevel.container.contents))
    /// // Prints “(3x − (y + 4))”
    ///
    /// print(String(nestingLevel.contents.contents))
    /// // Prints “3x − (y + 4)”
    /// ```
    public func firstNestingLevel<C : Collection, D : Collection>(startingWith openingToken: C, endingWith closingToken: D, in searchRange: Range<Index>? = nil) -> NestingLevel<Self>? where C.Iterator.Element == Iterator.Element, D.Iterator.Element == Iterator.Element {
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
}

extension Collection where Index : Hashable, Indices.Iterator.Element == Index {
    // MARK: - where Index : Hashable, Indices.Iterator.Element == Index

    /// Returns the collection as a `Dictionary`, with the collection’s indices used as keys.
    public var indexMapping: [Index: Iterator.Element] {
        var mapping: [Index: Iterator.Element] = [:]
        for index in indices {
            mapping[index] = self[index]
        }
        return mapping
    }
}

extension Collection where Index : Hashable, Iterator.Element : Hashable, Indices.Iterator.Element == Index {
    // MARK: - where Index : Hashable, Iterator.Element: Hashable, Indices.Iterator.Element == Index

    /// Returns the collection as a `BjectiveMapping` between the indices and values.
    ///
    /// - Requires: No values are repeated.
    public var bijectiveIndexMapping: BijectiveMapping<Index, Iterator.Element> {
        return BijectiveMapping(indexMapping)
    }
}
