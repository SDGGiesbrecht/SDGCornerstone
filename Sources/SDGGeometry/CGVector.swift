/*
 CGVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)

  import CoreGraphics

  import SDGMathematics

  extension CGVector: GenericAdditiveArithmetic, Negatable, RationalVector,
    TwoDimensionalVectorProtocol
  {

    // MARK: - TwoDimensionalVector

    public typealias Scalar = CGFloat

    @inlinable public init(Δx: Scalar, Δy: Scalar) {
      self = CGVector(dx: Δx, dy: Δy)
    }

    @inlinable public var Δx: Scalar {
      get {
        return dx
      }
      set {
        dx = newValue
      }
    }

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
