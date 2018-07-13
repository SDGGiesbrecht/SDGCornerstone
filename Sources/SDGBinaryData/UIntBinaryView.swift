/*
 UIntBinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCollections

/// A view of the contents of a fixed‐length unsigned integer as a collection of bits.
public struct BinaryView<UIntValue : UIntFamily> : BidirectionalCollection, Collection, CustomStringConvertible, MutableCollection, RandomAccessCollection, TextualPlaygroundDisplay {

    // MARK: - Initialization

    @_inlineable @_versioned internal init(_ uInt: UIntValue) {
        self.uInt = uInt
    }

    // MARK: - Static Properties

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    @_inlineable public static var startIndex: Index {
        return 0
    }

    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    @_inlineable public static var endIndex: Index {
        return Index(count)
    }

    // #documentation(SDGCornerstone.Collection.count)
    /// The number of elements in the collection.
    @_inlineable public static var count: Int {
        let bytes = MemoryLayout<UIntValue>.size
        return bytes × 8
    }

    // MARK: - Properties

    @_versioned internal var uInt: UIntValue

    // MARK: - BidirectionalCollection

    // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    @_specialize(exported: true, where UIntValue == UInt)
    @_specialize(exported: true, where UIntValue == UInt64)
    @_specialize(exported: true, where UIntValue == UInt32)
    @_specialize(exported: true, where UIntValue == UInt16)
    @_specialize(exported: true, where UIntValue == UInt8)
    @_inlineable public func index(before i: Index) -> Index {
        return i − (1 as Index)
    }

    // MARK: - Collection

    // #documentation(SDGCornerstone.Collection.Element)
    /// The type of the elements of the collection.
    public typealias Element = Bool
    // #documentation(SDGCornerstone.Collection.Index)
    /// The type of the indices of the collection.
    public typealias Index = UIntValue

    #if !swift(>=4.1.50)
    // #workaround(Swift 4.1.2, This section can be removed in Swift 4.2)
    // #documentation(SDGCornerstone.Collection.Indices)
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.
    public typealias Indices = DefaultRandomAccessIndices<BinaryView>
    #endif

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    @_inlineable public var startIndex: Index {
        return BinaryView.startIndex
    }
    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    @_inlineable public var endIndex: Index {
        return BinaryView.endIndex
    }

    // #documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @_specialize(exported: true, where UIntValue == UInt)
    @_specialize(exported: true, where UIntValue == UInt64)
    @_specialize(exported: true, where UIntValue == UInt32)
    @_specialize(exported: true, where UIntValue == UInt16)
    @_specialize(exported: true, where UIntValue == UInt8)
    @_inlineable public func index(after i: Index) -> Index {
        return i + (1 as Index)
    }

    @_inlineable @_versioned internal func assertIndexExists(_ index: Index) {
        _assert(index ∈ bounds, { (localization: _APILocalization) in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "Index out of bounds."
            }
        })
    }

    // #documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.
    @_inlineable public subscript(index: Index) -> Element {
        @_specialize(exported: true, where UIntValue == UInt)
        @_specialize(exported: true, where UIntValue == UInt64)
        @_specialize(exported: true, where UIntValue == UInt32)
        @_specialize(exported: true, where UIntValue == UInt16)
        @_specialize(exported: true, where UIntValue == UInt8)
        get {
            assertIndexExists(index)
            return uInt.bitwiseAnd(with: 1 << index) >> index == 1
        }
        @_specialize(exported: true, where UIntValue == UInt)
        @_specialize(exported: true, where UIntValue == UInt64)
        @_specialize(exported: true, where UIntValue == UInt32)
        @_specialize(exported: true, where UIntValue == UInt16)
        @_specialize(exported: true, where UIntValue == UInt8)
        set {
            assertIndexExists(index)
            let oldErased = uInt.bitwiseAnd(with: ((1 as Index) << index).bitwiseNot())
            uInt = oldErased.bitwiseOr(with: (newValue ? 1 : 0) << index)
        }
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        let bits = self.map { bit in
            return bit ? "1" : "0"
        }
        return bits.joined()
    }
}
