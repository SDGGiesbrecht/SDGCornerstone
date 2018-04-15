/*
 CGPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
// MARK: - #if canImport(CoreGraphics)

import CoreGraphics

extension CGPoint : TwoDimensionalPoint {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = CGVector

    // MARK: - TwoDimensionalPoint

    // [_Inherit Documentation: SDGCornerstone.TwoDimensionalPoint.Scalar_]
    /// The scalar type.
    public typealias Scalar = Vector.Scalar
}

#endif
