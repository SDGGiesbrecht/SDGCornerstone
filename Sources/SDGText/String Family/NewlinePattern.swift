/*
 NewlinePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A pattern representing any newline variant.
public class NewlinePattern : SDGCollections.Pattern<Unicode.Scalar> {

    // MARK: - Static Properties

    private static let carriageReturn: Unicode.Scalar = "\u{D}"
    private static let lineFeed: Unicode.Scalar = "\u{A}"
    @_versioned internal static let newlineCharacters = CharacterSet.newlines
    internal static let newline = NewlinePattern(carriageReturnLineFeed: (carriageReturn, lineFeed))
    @_versioned internal static let reverseNewline = NewlinePattern(carriageReturnLineFeed: (lineFeed, carriageReturn))

    // MARK: - Initialization

    private init(carriageReturnLineFeed: (Unicode.Scalar, Unicode.Scalar)) {
        carriageReturn = carriageReturnLineFeed.0
        lineFeed = carriageReturnLineFeed.1
    }

    // MARK: - Properties

    @_versioned internal let carriageReturn: Unicode.Scalar
    @_versioned internal let lineFeed: Unicode.Scalar

    // MARK: - Pattern

    // #documentation(SDGCornerstone.Pattern.match(in:at:))
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @_inlineable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Unicode.Scalar {

        let scalar = collection[location]
        guard scalar ∈ NewlinePattern.newlineCharacters else {
            return []
        }
        var result = [(location ... location).relative(to: collection)]

        if scalar == carriageReturn {
            let nextIndex = collection.index(after: location)
            if nextIndex ≠ collection.endIndex,
                collection[nextIndex] == lineFeed {
                result.prepend(location ..< collection.index(location, offsetBy: 2))
            }
        }
        return result
    }

    // #documentation(SDGCornerstone.Pattern.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @_inlineable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Unicode.Scalar {

        let scalar = collection[location]
        guard scalar ∈ NewlinePattern.newlineCharacters else {
            return nil
        }

        if scalar == carriageReturn {
            let nextIndex = collection.index(after: location)
            if nextIndex ≠ collection.endIndex,
                collection[nextIndex] == lineFeed {
                return location ..< collection.index(location, offsetBy: 2)
            }
        }
        return (location ... location).relative(to: collection)
    }

    // #documentation(SDGCornerstone.Pattern.reverse())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @_inlineable public override func reversed() -> NewlinePattern {
        return NewlinePattern.reverseNewline
    }
}
