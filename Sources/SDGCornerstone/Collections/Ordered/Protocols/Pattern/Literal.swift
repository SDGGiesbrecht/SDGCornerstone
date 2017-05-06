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
public struct LiteralPattern<Elements : Collection> : Pattern where Elements.Iterator.Element : Equatable {

    // MARK: - Initialization

    /// Creates a literal pattern from a collection.
    public init(_ literal: Elements) {
        elements = literal
    }

    // MARK: - Properties

    private let elements: Elements

    // MARK: - Pattern

    // [_Inherit Documentation: SDGCornerstone.Pattern.Element_]
    public typealias Element = Elements.Iterator.Element

    // [_Inherit Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    public func match<C : Collection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Iterator.Element == Element {

        var checkingIndex = elements.startIndex
        var collectionIndex = location
        while checkingIndex ≠ elements.endIndex {
            guard collectionIndex ≠ collection.endIndex else {
                // Ran out of space to check.
                return nil
            }

            if elements[checkingIndex] ≠ collection[collectionIndex] {
                // Mis‐match.
                return nil
            }

            checkingIndex = elements.index(after: checkingIndex)
            collectionIndex = collection.index(after: collectionIndex)
        }

        return location ..< collectionIndex
    }
}
