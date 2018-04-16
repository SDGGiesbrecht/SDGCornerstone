/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    // MARK: - Indices

    /// Returns the range for all of `self`.
    @_inlineable public var bounds: Range<Index> {
        return startIndex ..< endIndex
    }

    /// Returns the backward version of the specified range.
    @_inlineable public func backward(_ range: Range<Self.Index>) -> Range<ReversedIndex<Self>> {
        return ReversedIndex(range.upperBound) ..< ReversedIndex(range.lowerBound)
    }

    /// Returns the forward version of the specified range.
    @_inlineable public func forward(_ range: Range<ReversedIndex<Self>>) -> Range<Self.Index> {
        return range.upperBound.base ..< range.lowerBound.base
    }
}

extension Collection where Index : Hashable {
    // MARK: - where Index : Hashable

    /// Returns the collection as a `Dictionary`, with the collection’s indices used as keys.
    @_inlineable public var indexMapping: [Index: Element] {
        var mapping: [Index: Element] = [:]
        for index in indices {
            mapping[index] = self[index]
        }
        return mapping
    }
}

extension Collection where Element : Hashable, Index : Hashable {
    // MARK: - where Element: Hashable, Index : Hashable

    /// Returns the collection as a `BjectiveMapping` between the indices and values.
    ///
    /// - Requires: No values are repeated.
    @_inlineable public var bijectiveIndexMapping: BijectiveMapping<Index, Element> {
        return BijectiveMapping(indexMapping)
    }
}
