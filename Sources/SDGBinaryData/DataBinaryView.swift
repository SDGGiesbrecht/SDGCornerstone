/*
 DataBinaryView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension Data {

    /// A view of the contents of `Data` as a collection of bits.
    public struct BinaryView : BidirectionalCollection, Collection, CustomStringConvertible, MutableCollection, RandomAccessCollection, TextualPlaygroundDisplay {

        // MARK: - Initialization

        @inlinable internal init(_ data: Data) {
            self.data = data
        }

        // MARK: - Properties

        @usableFromInline internal static let bitsPerByte: IntMax = 8
        @usableFromInline internal var data: Data

        // MARK: - Conversions

        @inlinable internal func byteIndex(_ index: IntMax) -> Data.Index {
            return Data.Index(index.dividedAccordingToEuclid(by: BinaryView.bitsPerByte))
        }

        @inlinable internal func bitIndex(_ index: IntMax) -> SDGBinaryData.BinaryView<UInt8>.Index {
            return SDGBinaryData.BinaryView<UInt8>.Index(index.mod(BinaryView.bitsPerByte))
        }

        // MARK: - BidirectionalCollection

        // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
        /// Returns the index immediately before the specified index.
        ///
        /// - Parameters:
        ///     - i: The following index.
        @inlinable public func index(before i: IntMax) -> IntMax {
            return i − 1
        }

        // MARK: - Collection

        @usableFromInline internal static let startIndex: IntMax = 0
        public var startIndex: IntMax {
            return Data.BinaryView.startIndex
        }
        @inlinable public var endIndex: IntMax {
            return IntMax(data.endIndex) × BinaryView.bitsPerByte
        }

        @inlinable public func index(after i: IntMax) -> IntMax {
            return i + 1
        }

        @inlinable public subscript(position: IntMax) -> Bool {
            get {
                return data[byteIndex(position)].binary[bitIndex(position)]
            }
            set {
                data[byteIndex(position)].binary[bitIndex(position)] = newValue
            }
        }

        // MARK: - CustomStringConvertible

        public var description: String {
            let bytes = data.map { String(describing: $0.binary) }
            return bytes.joined(separator: " ")
        }
    }
}
