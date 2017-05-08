/*
 Match.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The result of a pattern search.
public struct PatternMatch<Searched : Collection> {

    // MARK: - Initiailzation

    internal init(range: Range<Searched.Index>, contents: Searched.SubSequence) {
        self.range = range
        self.contents = contents
    }

    // MARK: - Properties

    /// The range.
    public let range: Range<Searched.Index>
    /// The contents of the match.
    public let contents: Searched.SubSequence
}
