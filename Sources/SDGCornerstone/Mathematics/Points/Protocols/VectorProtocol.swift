/*
 VectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension VectorProtocol where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The scalar coefficient by which to multiply.
    public static func ×=(precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.Δx ×= followingValue
        precedingValue.Δy ×= followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.÷=_]
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The divisor.
    public static func ÷=(precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.Δx ÷= followingValue
        precedingValue.Δy ÷= followingValue
    }
}
