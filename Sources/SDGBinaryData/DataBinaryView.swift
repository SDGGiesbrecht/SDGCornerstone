/*
 DataBinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension Data {

    /// A view of the contents of `Data` as a collection of bits.
    public struct BinaryView : BidirectionalCollection, Collection, CustomStringConvertible, MutableCollection, RandomAccessCollection {

        // MARK: - Initialization

        @_inlineable @_versioned internal init(_ data: Data) {
            self.data = data
        }

        // MARK: - Properties

        @_versioned internal static let bitsPerByte: IntMax = 8
        @_versioned internal var data: Data

        // MARK: - Conversions

        @_inlineable @_versioned internal func byteIndex(_ index: IntMax) -> Data.Index {
            return Data.Index(index.dividedAccordingToEuclid(by: BinaryView.bitsPerByte))
        }

        @_inlineable @_versioned internal func bitIndex(_ index: IntMax) -> SDGBinaryData.BinaryView<UInt8>.Index {
            return SDGBinaryData.BinaryView<UInt8>.Index(index.mod(BinaryView.bitsPerByte))
        }

        // MARK: - BidirectionalCollection

        // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
        /// Returns the index immediately before the specified index.
        ///
        /// - Parameters:
        ///     - i: The following index.
        @_inlineable public func index(before i: IntMax) -> IntMax {
            return i − 1
        }

        // MARK: - Collection

        @_versioned internal static let startIndex: IntMax = 0
        // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
        /// The position of the first element in a non‐empty collection.
        public var startIndex: IntMax {
            return Data.BinaryView.startIndex
        }
        // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
        /// The position following the last valid index.
        @_inlineable public var endIndex: IntMax {
            return IntMax(data.endIndex) × BinaryView.bitsPerByte
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
        /// Returns the index immediately after the specified index.
        ///
        /// - Parameters:
        ///     - i: The preceding index.
        @_inlineable public func index(after i: IntMax) -> IntMax {
            return i + 1
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
        /// Accesses the element at the specified position.
        @_inlineable public subscript(position: IntMax) -> Bool {
            get {
                return data[byteIndex(position)].binary[bitIndex(position)]
            }
            set {
                data[byteIndex(position)].binary[bitIndex(position)] = newValue
            }
        }
        
        // MARK: - CustomStringConvertible
        
        // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
        public var description: String {
            let bytes = data.map { $0.binary.description }
            return bytes.joined(separator: " ")
        }
    }
}
