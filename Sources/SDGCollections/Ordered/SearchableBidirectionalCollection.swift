/*
 SearchableBidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An bidirectional ordered collection which can be searched for elements, subsequences and patterns.
///
/// Conformance Requirements:
///
/// - `BidirectionalCollection`
/// - `SearchableCollection`
/// - `SubSequence : SearchableBidirectionalCollection`
public protocol SearchableBidirectionalCollection : BidirectionalCollection, SearchableCollection
where SubSequence : SearchableBidirectionalCollection {

    // @documentation(SDGCornerstone.Collection.lastMatch(for:))
    // #example(1, lastMatchBackwardsDifferences1) #example(2, lastMatchBackwardsDifferences2)
    /// Returns the last match for `pattern` in the collection.
    ///
    /// This mathod searches backward from the end of the search range. This is not always the same thing as the last forward‐searched match:
    ///
    /// ```swift
    /// let collection = [0, 0, 0, 0, 0]
    /// let pattern = [0, 0]
    ///
    /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 3 ..< 5)
    ///
    /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 2 ..< 4)
    /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
    /// ```
    ///
    /// ```swift
    /// let collection = [0, 0, 1]
    /// let pattern = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
    ///
    /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 1 ..< 3)
    /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
    ///
    /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 0 ..< 3)
    /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func lastMatch<P>(for pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.lastMatch(for:))
    /// Returns the last match for `pattern` in the collection.
    ///
    /// This mathod searches backward from the end of the search range. This is not always the same thing as the last forward‐searched match:
    ///
    /// ```swift
    /// let collection = [0, 0, 0, 0, 0]
    /// let pattern = [0, 0]
    ///
    /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 3 ..< 5)
    ///
    /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 2 ..< 4)
    /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
    /// ```
    ///
    /// ```swift
    /// let collection = [0, 0, 1]
    /// let pattern = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
    ///
    /// XCTAssertEqual(collection.lastMatch(for: pattern)?.range, 1 ..< 3)
    /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
    ///
    /// XCTAssertEqual(collection.matches(for: pattern).last?.range, 0 ..< 3)
    /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    func lastMatch(for pattern: Self) -> PatternMatch<Self>?

    // @documentation(SDGCornerstone.Collection.hasSuffix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    func hasSuffix<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element
    // #documentation(SDGCornerstone.Collection.hasSuffix(_:))
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    func hasSuffix(_ pattern: Self) -> Bool

    // @documentation(SDGCornerstone.Collection.commonPrefix(with:))
    /// Returns the longest suffix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    func commonSuffix<C : SearchableBidirectionalCollection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element
    // #documentation(SDGCornerstone.Collection.commonPrefix(with:))
    /// Returns the longest prefix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    func commonSuffix(with other: Self) -> PatternMatch<Self>

    // #documentation(SDGCornerstone.Collection.difference(from:))
    /// Returns the sequence of changes necessary to transform the other collection to be the same as this one.
    ///
    /// - Parameters:
    ///     - other: The other collection. (The starting point.)
    func difference<C>(from other: C) -> [Change<C.Index, Index>] where C : SearchableBidirectionalCollection, C.Element == Self.Element
    // #documentation(SDGCornerstone.Collection.difference(from:))
    /// Returns the sequence of changes necessary to transform the other collection to be the same as this one.
    ///
    /// - Parameters:
    ///     - other: The other collection. (The starting point.)
    func difference(from other: Self) -> [Change<Index, Index>]
}

extension SearchableBidirectionalCollection {

    @inlinable internal func _lastMatch<P>(for pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        let backwards: ReversedCollection<Self> = reversed()
        guard let range = backwards.firstMatch(for: pattern.reversed())?.range else {
            return nil
        }
        return PatternMatch(range: forward(range), in: self)
    }
    @inlinable public func lastMatch<P>(for pattern: P) -> PatternMatch<Self>? where P : PatternProtocol, P.Element == Element {
        return _lastMatch(for: pattern)
    }
    @inlinable public func lastMatch(for pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return _lastMatch(for: pattern)
    }
    @inlinable public func lastMatch(for pattern: Self) -> PatternMatch<Self>? {
        // #workaround(Swift 5, Duplicate implementation works around compiler bug.)
        let backwards: ReversedCollection<Self> = reversed()
        let reversedPattern: ReversedCollection<Self> = pattern.reversed()
        guard let range = backwards.firstMatch(for: reversedPattern)?.range else {
            return nil
        }
        return PatternMatch(range: forward(range), in: self)
    }

    @inlinable internal func _hasSuffix<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        let backwards: ReversedCollection<Self> = reversed()
        return pattern.reversed().primaryMatch(in: backwards, at: backwards.startIndex) ≠ nil
    }
    @inlinable public func hasSuffix<P>(_ pattern: P) -> Bool where P : PatternProtocol, P.Element == Element {
        return _hasSuffix(pattern)
    }
    @inlinable public func hasSuffix(_ pattern: CompositePattern<Element>) -> Bool {
        return _hasSuffix(pattern)
    }
    @inlinable public func hasSuffix(_ pattern: Self) -> Bool {
        return _hasSuffix(pattern)
    }

    @inlinable internal func _commonSuffix<C : SearchableBidirectionalCollection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element {
        return PatternMatch(range: forward(reversed().commonPrefix(with: other.reversed()).range), in: self)
    }
    @inlinable public func commonSuffix<C : SearchableBidirectionalCollection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element {
        return _commonSuffix(with: other)
    }
    @inlinable public func commonSuffix(with other: Self) -> PatternMatch<Self> {
        return _commonSuffix(with: other)
    }

    @inlinable internal func _difference<C>(from other: C) -> [Change<C.Index, Index>] where C : SearchableBidirectionalCollection, C.Element == Self.Element {

        let suffixStart = commonSuffix(with: other).range.lowerBound
        let suffixLength = distance(from: suffixStart, to: endIndex)
        let otherSuffixStart = other.index(other.endIndex, offsetBy: −suffixLength)

        var difference: [Change<C.Index, Index>] = prefix(upTo: suffixStart).suffixIgnorantDifference(from: other.prefix(upTo: otherSuffixStart))

        if suffixLength ≠ 0 {
            difference.append(.keep((otherSuffixStart...).relative(to: other)))
        }

        return difference
    }
    @inlinable public func difference<C>(from other: C) -> [Change<C.Index, Index>] where C : SearchableBidirectionalCollection, C.Element == Self.Element {
        return _difference(from: other)
    }
    @inlinable public func difference(from other: Self) -> [Change<Index, Index>] {
        return _difference(from: other)
    }
}
