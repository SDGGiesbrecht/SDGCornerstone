/*
 Data.BinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension Data {

    /// A view of the contents of `Data` as a collection of bits.
    public struct BinaryView : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection {

        // MARK: - Initialization

        internal init(_ data: Data) {
            self.data = data
        }

        // MARK: - Properties

        private static let bitsPerByte: IntMax = 8
        internal var data: Data

        // MARK: - Conversions

        private func byteIndex(_ index: IntMax) -> Data.Index {
            return Data.Index(index.dividedAccordingToEuclid(by: BinaryView.bitsPerByte))
        }

        private func bitIndex(_ index: IntMax) -> SDGCornerstone.BinaryView<UInt8>.Index {
            return SDGCornerstone.BinaryView<UInt8>.Index(index.mod(BinaryView.bitsPerByte))
        }

        // MARK: - BidirectionalCollection

        // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
        /// Returns the index immediately before the specified index.
        ///
        /// - Parameters:
        ///     - i: The following index.
        public func index(before i: IntMax) -> IntMax {
            return i − 1
        }

        // MARK: - Collection

        // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
        /// The position of the first element in a non‐empty collection.
        public var startIndex: IntMax = 0
        // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
        /// The position following the last valid index.
        public var endIndex: IntMax {
            return IntMax(data.endIndex) × BinaryView.bitsPerByte
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
        /// Returns the index immediately after the specified index.
        ///
        /// - Parameters:
        ///     - i: The preceding index.
        public func index(after i: IntMax) -> IntMax {
            return i + 1
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
        /// Accesses the element at the specified position.
        public subscript(position: IntMax) -> Bool {
            get {
                return data[byteIndex(position)].binary[bitIndex(position)]
            }
            set {
                data[byteIndex(position)].binary[bitIndex(position)] = newValue
            }
        }
    }
}
