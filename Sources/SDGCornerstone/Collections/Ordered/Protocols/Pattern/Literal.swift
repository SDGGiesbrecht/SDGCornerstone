/*
 Literal.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that matches an exact subsequence.
public final class Literal<Element : Equatable> : Pattern<Element>, ExpressibleByArrayLiteral {

    // MARK: - Initialization

    /// Creates a literal pattern from a collection.
    ///
    /// - Parameters:
    ///     - literal: The collection to match as a literal.
    public init<C : Collection>(_ literal: C) where C.Iterator.Element == Element {
        startIndex = literal.startIndex
        endIndex = literal.endIndex
        // swiftlint:disable force_cast
        indexesAreInequal = { $0 as! C.Index ≠ $1 as! C.Index }
        indexAfter = { literal.index(after: $0 as! C.Index) }
        elementAt = { literal[$0 as! C.Index] }
        // swiftlint:enable force_cast
    }

    // MARK: - Properties

    private typealias Index = Any
    private var startIndex: Index
    private var endIndex: Index
    private var indexesAreInequal: (Index, Index) -> Bool
    private var indexAfter: (Index) -> Index
    private var elementAt: (Index) -> Element

    // MARK: - ExpressibleByArrayLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByArrayLiteral.init(arrayLiteral:)_]
    /// Creates an instance from an array literal.
    public convenience init(arrayLiteral: Element...) {
        self.init(arrayLiteral)
    }

    // MARK: - Pattern

    // [_Inherit Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    public override func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Iterator.Element == Element {

        var checkingIndex = startIndex
        var collectionIndex = location
        while indexesAreInequal(checkingIndex, endIndex) {
            guard collectionIndex ≠ collection.endIndex else {
                // Ran out of space to check.
                return []
            }

            if elementAt(checkingIndex) ≠ collection[collectionIndex] {
                // Mis‐match.
                return []
            }

            checkingIndex = indexAfter(checkingIndex)
            collectionIndex = collection.index(after: collectionIndex)
        }

        return [location ..< collectionIndex]
    }
}
