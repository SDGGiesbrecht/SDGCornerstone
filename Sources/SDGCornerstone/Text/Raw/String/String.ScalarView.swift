/*
 String.ScalarView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String.UnicodeScalarView : UnicodeScalarView {
    // [_Workaround: The previous line should read “String.ScalarView” but a compiler bug prevents it. (Swift 4.0.3)_]

    // [_Inherit Documentation: SDGCornerstone.Collection.firstMatch(for:in:)_]
    /// Returns the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch(for pattern: Pattern<Element>, in searchRange: Range<Index>? = nil) -> PatternMatch<String.ScalarView>? {
        let searchArea = searchRange ?? bounds

        // [_Workaround: This is redundant, but solves performance until generics can be forcibly specialized. (Swift 4.0.3)_]

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
    public func firstMatch(for pattern: String.ScalarView, in searchRange: Range<Index>? = nil) -> PatternMatch<String.ScalarView>? {

        // [_Workaround: This is redundant, but solves performance until generics can be forcibly specialized. (Swift 4.0.3)_]

        return firstMatch(for: LiteralPattern(pattern), in: searchRange)
    }
}
