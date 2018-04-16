/*
 SearchableBidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An bidirectional ordered collection which can be searched for elements, subsequences and patterns.
public protocol SearchableBidirectionalCollection : BidirectionalCollection, SearchableCollection {

    // [_Define Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    // [_Example 1: lastMatch(for:in:) Backwards Differences 1_] [_Example 2: lastMatch(for:in:) Backwards Differences 2_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search.
    func lastMatch(for pattern: Pattern<Element>, in searchRange: Range<Index>) -> PatternMatch<Self>?
    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    func lastMatch<C : SearchableCollection>(for pattern: C, in searchRange: Range<Index>) -> PatternMatch<Self>? where C.Element == Self.Element
    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    func lastMatch(for pattern: Self, in searchRange: Range<Index>) -> PatternMatch<Self>?
}

extension SearchableBidirectionalCollection {

    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    // [_Example 1: lastMatch(for:in:) Backwards Differences 1_] [_Example 2: lastMatch(for:in:) Backwards Differences 2_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch(for pattern: Pattern<Element>, in searchRange: Range<Index>) -> PatternMatch<Self>? {
        guard let range = reversed().firstMatch(for: pattern.reversed(), in: backward(searchRange))?.range else {
            return nil
        }
        return PatternMatch(range: forward(range), in: self)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch(for pattern: CompositePattern<Element>, in searchRange: Range<Index>) -> PatternMatch<Self>? {
        return lastMatch(for: pattern as Pattern<Element>, in: searchRange)
    }

    @_inlineable @_versioned internal func _lastMatch<C : SearchableCollection>(for pattern: C, in searchRange: Range<Index>) -> PatternMatch<Self>? where C.Element == Self.Element {
        guard let range = reversed().firstMatch(for: pattern.reversed(), in: backward(searchRange))?.range else {
            return nil
        }
        return PatternMatch(range: forward(range), in: self)
    }
    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch<C : SearchableCollection>(for pattern: C, in searchRange: Range<Index>) -> PatternMatch<Self>? where C.Element == Self.Element {
        return _lastMatch(for: pattern, in: searchRange)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch(for pattern: Self, in searchRange: Range<Index>) -> PatternMatch<Self>? {
        return _lastMatch(for: pattern, in: searchRange)
    }

    // [_Define Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    // [_Example 1: lastMatch(for:in:) Backwards Differences 1_] [_Example 2: lastMatch(for:in:) Backwards Differences 2_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch(for pattern: Pattern<Element>) -> PatternMatch<Self>? {
        return lastMatch(for: pattern, in: bounds)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch(for pattern: CompositePattern<Element>) -> PatternMatch<Self>? {
        return lastMatch(for: pattern, in: bounds)
    }
    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch<C : SearchableCollection>(for pattern: C) -> PatternMatch<Self>? where C.Element == Self.Element {
        return lastMatch(for: pattern, in: bounds)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.lastMatch(for:in:)_]
    /// Returns the last match for `pattern` in the specified subrange.
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
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    @_inlineable public func lastMatch(for pattern: Self) -> PatternMatch<Self>? {
        return lastMatch(for: pattern, in: bounds)
    }

    // MARK: - Searchable Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @_inlineable public func hasSuffix(_ pattern: Pattern<Element>) -> Bool {
        // This is faster than on a non‐bidirectional collection,
        // because “reversed()” returns a ReversedCollection, which is lazy,
        // instead of reallocating into an Array.
        let backwards = reversed()
        return pattern.reversed().primaryMatch(in: backwards, at: backwards.startIndex) ≠ nil
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @_inlineable public func hasSuffix<C : SearchableCollection>(_ pattern: C) -> Bool where C.Element == Self.Element {
        let backwards = reversed()
        return pattern.reversed().primaryMatch(in: backwards, at: backwards.startIndex) ≠ nil
    }

    @_inlineable @_versioned internal func _hasSuffix<C : SearchableBidirectionalCollection>(_ pattern: C) -> Bool where C.Element == Self.Element {
        let backwards = reversed()
        return pattern.reversed().primaryMatch(in: backwards, at: backwards.startIndex) ≠ nil
    }
    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @_inlineable public func hasSuffix<C : SearchableBidirectionalCollection>(_ pattern: C) -> Bool where C.Element == Self.Element {
        return _hasSuffix(pattern)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.hasSuffix(_:)_]
    /// Returns `true` if `self` begins with `pattern`.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to try.
    @_inlineable public func hasSuffix(_ pattern: Self) -> Bool {
        return _hasSuffix(pattern)
    }
}
