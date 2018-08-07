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

    // @documentation(SDGCornerstone.Collection.Element)
    /// The type of the elements of the collection.

    // @documentation(SDGCornerstone.Collection.Index)
    /// The type of the indices of the collection.

    // @documentation(SDGCornerstone.Collection.Indices)
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.

    // @documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.

    // @documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.

    // @documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.

    // @documentation(SDGCornerstone.Collection.count)
    /// The number of elements in the collection.

    // @documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.

    // MARK: - Indices

    /// Returns the range for all of `self`.
    @_inlineable public var bounds: Range<Index> {
        return startIndex ..< endIndex
    }

    #if !swift(>=4.1.50)
    // MARK: - #if swift(>=4.1.50)
    // #workaround(Swift 4.1.2, This section can be removed in Swift 4.2)

    /// Returns the backward version of the specified range.
    @_inlineable public func backward<R>(_ range: R) -> Range<ReversedIndex<Self>> where R : RangeExpression, R.Bound == Self.Index {
        let resolved = range.relative(to: self)
        return ReversedIndex(resolved.upperBound) ..< ReversedIndex(resolved.lowerBound)
    }

    /// Returns the forward version of the specified range.
    @_inlineable public func forward(_ range: Range<ReversedIndex<Self>>) -> Range<Self.Index> {
        return range.upperBound.base ..< range.lowerBound.base
    }
    #endif
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
