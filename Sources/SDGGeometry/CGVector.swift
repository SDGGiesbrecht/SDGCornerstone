/*
 CGVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)

import CoreGraphics

import SDGMathematics

extension CGVector : AdditiveArithmetic, Negatable, TwoDimensionalVector {

    // MARK: - AdditiveArithmetic

    // #documentation(SDGCornerstone.AdditiveArithmetic.additiveIdentity)
    /// The additive identity (origin).
    public static let additiveIdentity: CGVector = zero

    // MARK: - TwoDimensionalVector

    // #documentation(SDGCornerstone.VectorProtocol.Scalar)
    /// The scalar type.
    // The scalar type.
    public typealias Scalar = CGFloat

    // #documentation(SDGCornerstone.TwoDimensionalVector.init(Δx:Δy:))
    /// The difference in *y*.
    public init(Δx: Scalar, Δy: Scalar) {
        self = CGVector(dx: Δx, dy: Δy)
    }

    // #documentation(SDGCornerstone.TwoDimensionalVector.Δx)
    /// The difference in *x*.
    @inlinable public var Δx: Scalar {
        get {
            return dx
        }
        set {
            dx = newValue
        }
    }

    // #documentation(SDGCornerstone.TwoDimensionalVector.Δy)
    /// The difference in *y*.
    @inlinable public var Δy: Scalar {
        get {
            return dy
        }
        set {
            dy = newValue
        }
    }
}

#endif
