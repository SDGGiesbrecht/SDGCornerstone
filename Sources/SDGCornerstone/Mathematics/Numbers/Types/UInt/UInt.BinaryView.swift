/*
 UInt.BinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

//extension UInt {
// [_Workaround: Linux compiler cannot nest generic types in extensions. (Swift 3.1.0)_]

    /// A view of the contents of a fixed‐length unsigned integer as a collection of bits.
    public struct BinaryView<UIntValue : UIntFamily> : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection {

        // MARK: - Initialization

        internal init(_ uInt: UIntValue) {
            self.uInt = uInt
        }

        // MARK: - Static Properties

        // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
        /// The position following the last valid index.
        public static var endIndex: Index {
            return Index(count)
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.count_]
        /// The number of elements in the collection.
        public static var count: IndexDistance {
            let bytes = MemoryLayout<UIntValue>.size
            return bytes × 8
        }

        // MARK: - Properties

        internal var uInt: UIntValue

        // MARK: - BidirectionalCollection

        // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
        /// Returns the index immediately before the specified index.
        ///
        /// - Parameters:
        ///     - i: The following index.
        public func index(before i: Index) -> Index {
            return i − (1 as Index)
        }

        // MARK: - Collection

        // [_Inherit Documentation: SDGCornerstone.Collection.Element_]
        /// The type of the elements of the collection.
        public typealias Element = Bool
        // [_Inherit Documentation: SDGCornerstone.Collection.Index_]
        /// The type of the indices of the collection.
        public typealias Index = UIntValue
        // [_Inherit Documentation: SDGCornerstone.Collection.IndexDistance_]
        /// The type that represents the number of steps between a pair of indices.
        public typealias IndexDistance = Int

        // [_Inherit Documentation: SDGCornerstone.Collection.Indices_]
        /// The type that represents the indices that are valid for subscripting the collection, in ascending order.
        public typealias Indices = DefaultRandomAccessIndices<BinaryView>

        // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
        /// The position of the first element in a non‐empty collection.
        public let startIndex: Index = 0
        // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
        /// The position following the last valid index.
        public let endIndex: Index = BinaryView.endIndex

        // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
        /// Returns the index immediately after the specified index.
        ///
        /// - Parameters:
        ///     - i: The preceding index.
        public func index(after i: Index) -> Index {
            return i + (1 as Index)
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
        /// Accesses the element at the specified position.
        public subscript(index: Index) -> Element {
            get {
                assertIndexExists(index)
                return uInt.bitwiseAnd(with: 1 << index) >> index == 1
            }
            set {
                assertIndexExists(index)
                let oldErased = uInt.bitwiseAnd(with: ((1 as Index) << index).bitwiseNot())
                uInt = oldErased.bitwiseOr(with: (newValue ? 1 : 0) << index)
            }
        }
    }
//}
