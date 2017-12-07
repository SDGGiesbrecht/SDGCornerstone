/*
 PatternMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The result of a pattern search.
public struct PatternMatch<Searched : Collection> {

    // MARK: - Initialization

    /// Creates a description of a match.
    ///
    /// - Parameters:
    ///     - range: The range of the match.
    ///     - contents: The contents of the match.
    public init(range: Range<Searched.Index>, in collection: Searched) {
        self.range = range
        self.contents = collection[range]
    }

    // MARK: - Properties

    /// The range.
    public let range: Range<Searched.Index>
    /// The contents of the match.
    public let contents: Searched.SubSequence
}
