/*
 PatternMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The result of a pattern search.
public struct PatternMatch<Searched : SearchableCollection> {

    // MARK: - Initialization

    /// Creates a description of a match.
    ///
    /// - Parameters:
    ///     - range: The range of the match.
    ///     - contents: The contents of the match.
    @_inlineable public init(range: Range<Searched.Index>, in collection: Searched) {
        self.range = range
        self.contents = collection[range]
    }

    // MARK: - Properties

    /// The range.
    public let range: Range<Searched.Index>
    /// The contents of the match.
    public let contents: Searched.SubSequence

    // MARK: - Conversions

    /// Returns the same match in another collection whose indices are shared with the collection originally searched; this is intended for converting a match found in a subsequence into a match in the base collection or vice versa.
    ///
    /// - Requires: The range is valid for the target collection and points to the same elements.
    public func `in`<C>(_ otherCollection: C) -> PatternMatch<C> where C : SearchableCollection, C.Index == Searched.Index {
        return PatternMatch<C>(range: range, in: otherCollection)
    }
}
