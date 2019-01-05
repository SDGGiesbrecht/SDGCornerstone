/*
 CGPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)

import CoreGraphics

extension CGPoint : TwoDimensionalPoint {

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.Vector)
    /// The type to be used as a vector.
    public typealias Vector = CGVector

    // MARK: - TwoDimensionalPoint

    // #documentation(SDGCornerstone.TwoDimensionalPoint.Scalar)
    /// The scalar type.
    public typealias Scalar = Vector.Scalar
}

#endif
