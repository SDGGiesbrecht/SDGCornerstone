/*
 NewlinePattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A pattern representing any newline variant.
public final class NewlinePattern : SDGCollections.Pattern<Unicode.Scalar> {

    // MARK: - Static Properties

    private static let carriageReturn: Unicode.Scalar = "\u{D}"
    private static let lineFeed: Unicode.Scalar = "\u{A}"
    @usableFromInline internal static let newlineCharacters = CharacterSet.newlines
    internal static let newline = NewlinePattern(carriageReturnLineFeed: (carriageReturn, lineFeed))
    @usableFromInline internal static let reverseNewline = NewlinePattern(carriageReturnLineFeed: (lineFeed, carriageReturn))

    // MARK: - Initialization

    private init(carriageReturnLineFeed: (Unicode.Scalar, Unicode.Scalar)) {
        carriageReturn = carriageReturnLineFeed.0
        lineFeed = carriageReturnLineFeed.1
    }

    // MARK: - Properties

    @usableFromInline internal let carriageReturn: Unicode.Scalar
    @usableFromInline internal let lineFeed: Unicode.Scalar

    // MARK: - Pattern

    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Unicode.Scalar {

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

    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Unicode.Scalar {

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

    @inlinable public override func reversed() -> NewlinePattern {
        return NewlinePattern.reverseNewline
    }
}
