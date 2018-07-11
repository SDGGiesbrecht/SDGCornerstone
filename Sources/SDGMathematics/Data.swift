/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@_exported import struct Foundation.Data // #workaround(The export works around a compiler bug. (Swift 4.1.2))

extension Data : BitField {

    // MARK: - BitField

    // #documentation(SDGCornerstone.BitField.formBitwiseNot())
    /// Inverts the bits.
    @_inlineable public mutating func formBitwiseNot() {
        for index in indices {
            self[index].formBitwiseNot()
        }
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseAnd(with:))
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseAnd(with other: Data) {
        let end = Swift.min(endIndex, other.endIndex)

        for index in startIndex ..< end {
            self[index].formBitwiseAnd(with: other[index])
        }
        removeSubrange(end ..< endIndex)
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseOr(with:))
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseOr(with other: Data) {
        let end = Swift.min(endIndex, other.endIndex)

        for index in startIndex ..< end {
            self[index].formBitwiseOr(with: other[index])
        }
        append(contentsOf: other[end ..< other.endIndex])
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseExclusiveOr(with:))
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @_inlineable public mutating func formBitwiseExclusiveOr(with other: Data) {
        let end = Swift.min(endIndex, other.endIndex)

        for index in startIndex ..< end {
            self[index].formBitwiseExclusiveOr(with: other[index])
        }
        append(contentsOf: other[end ..< other.endIndex])
    }
}
