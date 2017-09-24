/*
 BidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension BidirectionalCollection {

    // [_Define Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
}

extension BidirectionalCollection where Element : Equatable {
    // MARK: - where Element : Equatable

    // MARK: - Searching

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
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 3 ..< 5
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 2 ..< 4
    /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
    /// ```
    ///
    /// ```swift
    /// let collection = [0, 0, 1]
    /// let pattern = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
    ///
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 1 ..< 3
    /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 0 ..< 3
    /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func lastMatch(for pattern: Pattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        let searchArea = searchRange ?? bounds

        guard let range = reversed().firstMatch(for: pattern.reversed(), in: backward(searchArea))?.range else {
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
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 3 ..< 5
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 2 ..< 4
    /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
    /// ```
    ///
    /// ```swift
    /// let collection = [0, 0, 1]
    /// let pattern = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
    ///
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 1 ..< 3
    /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 0 ..< 3
    /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func lastMatch(for pattern: LiteralPattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        return lastMatch(for: pattern as Pattern<Element>, in: searchRange)
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
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 3 ..< 5
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 2 ..< 4
    /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
    /// ```
    ///
    /// ```swift
    /// let collection = [0, 0, 1]
    /// let pattern = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
    ///
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 1 ..< 3
    /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 0 ..< 3
    /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func lastMatch(for pattern: CompositePattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        return lastMatch(for: pattern as Pattern<Element>, in: searchRange)
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
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 3 ..< 5
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 2 ..< 4
    /// // (Here the matches are 0 ..< 2 and 2 ..< 4; the final zero is incomplete.)
    /// ```
    ///
    /// ```swift
    /// let collection = [0, 0, 1]
    /// let pattern = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
    ///
    /// print("Backwards: \(collection.lastMatch(for: pattern)!)")
    /// // Backwards: 1 ..< 3
    /// // (Backwards, the pattern has already matched the 1, so the lazy consumption stops after the first 0 it encounteres.)
    ///
    /// print("Forwards: \(collection.matches(for: pattern).last!)")
    /// // Forwards: 0 ..< 3
    /// // (Forwards, the lazy consumption keeps consuming zeros until the pattern can be completed with a one.)
    /// ```
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func lastMatch<C : Collection>(for pattern: C, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? where C.Element == Self.Element {
        return lastMatch(for: LiteralPattern(pattern), in: searchRange)
    }

    // [_Define Documentation: SDGCornerstone.Collection.commonPrefix(with:)_]
    /// Returns the longest suffix subsequence shared with the other collection.
    ///
    /// - Parameters:
    ///     - other: The other collection
    public func commonSuffix<C : Collection>(with other: C) -> PatternMatch<Self> where C.Element == Self.Element {
        return PatternMatch(range: forward(reversed().commonPrefix(with: other.reversed()).range), in: self)
    }
}
