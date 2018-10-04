/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension Data : BitField {

    // MARK: - BitField

    // #documentation(SDGCornerstone.BitField.formBitwiseNot())
    /// Inverts the bits.
    @inlinable public mutating func formBitwiseNot() {
        for index in indices {
            self[index].formBitwiseNot()
        }
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseAnd(with:))
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public mutating func formBitwiseAnd(with other: Data) {
        let end = Swift.min(endIndex, other.endIndex)

        for index in startIndex ..< end {
            self[index].formBitwiseAnd(with: other[index])
        }
        removeSubrange(end...)
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseOr(with:))
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public mutating func formBitwiseOr(with other: Data) {
        let end = Swift.min(endIndex, other.endIndex)

        for index in startIndex ..< end {
            self[index].formBitwiseOr(with: other[index])
        }
        append(contentsOf: other[end...])
    }

    // #documentation(SDGCornerstone.BitField.formBitwiseExclusiveOr(with:))
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    @inlinable public mutating func formBitwiseExclusiveOr(with other: Data) {
        let end = Swift.min(endIndex, other.endIndex)

        for index in startIndex ..< end {
            self[index].formBitwiseExclusiveOr(with: other[index])
        }
        append(contentsOf: other[end...])
    }
}
