/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Collection {

    // MARK: - Conformance

    // [_Define Documentation: SDGCornerstone.Collection.Element_]
    /// The type of the elements of the collection.

    // [_Define Documentation: SDGCornerstone.Collection.Index_]
    /// The type of the indices of the collection.

    // [_Define Documentation: SDGCornerstone.Collection.IndexDistance_]
    /// The type that represents the number of steps between a pair of indices.

    // [_Define Documentation: SDGCornerstone.Collection.Indices_]
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.

    // [_Define Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.

    // [_Define Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.

    // [_Define Documentation: SDGCornerstone.Collection.subscript(position:)_]
    /// Accesses the element at the specified position.

    // [_Define Documentation: SDGCornerstone.Collection.count_]
    /// The number of elements in the collection.

    // [_Define Documentation: SDGCornerstone.Collection.index(after:)_]
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.

    // MARK: - Searching

    /// Returns the range and contents of the first match for `pattern` in the specified subrange.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to search for.
    ///     - searchRange: A subrange to search. (Defaults to the entire collection.)
    public func firstMatch<P : Pattern>(for pattern: P, in searchRange: Range<Index>? = nil) -> (range: Range<Index>, contents: SubSequence)? where P.Element == Iterator.Element {
        let bounds = searchRange ?? startIndex ..< endIndex

        var i = bounds.lowerBound
        while i ≠ bounds.upperBound {
            if let range = pattern.match(in: self, at: i) {
                return (range, self[range])
            }
            i = index(after: i)
        }
        return nil
    }
}
