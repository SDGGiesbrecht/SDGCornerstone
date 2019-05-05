/*
 TwoDimensionalVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A two‐dimensional vector.
public struct TwoDimensionalVector<Scalar> : TwoDimensionalVectorProtocol
where Scalar : WholeArithmetic {

    // MARK: - AdditiveArithmetic

    @inlinable public static var zero: TwoDimensionalVector {
        return TwoDimensionalVector(Δx: 0, Δy: 0)
    }

    // MARK: - TwoDimensionalVectorProtocol

    @inlinable public init(Δx: Scalar, Δy: Scalar) {
        self.Δx = Δx
        self.Δy = Δy
    }

    public var Δx: Scalar
    public var Δy: Scalar
}

extension TwoDimensionalVector : RationalVector where Scalar : RationalArithmetic {}
