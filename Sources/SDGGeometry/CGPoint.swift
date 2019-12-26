/*
 CGPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(CoreGraphics)
  import CoreGraphics  // Not included in Foundation on iOS.
#endif

import SDGMathematics

extension CGPoint {

  // MARK: - Conversions

  #if canImport(AppKit) || canImport(UIKit)
    internal init(_ point: TwoDimensionalPoint<Double>) {
      self = CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))
    }
  #endif
}

#if canImport(CoreGraphics)
  extension CGPoint: TwoDimensionalPointProtocol {

    // MARK: - PointProtocol

    public typealias Vector = CGVector

    // MARK: - TwoDimensionalPointProtocol

    @inlinable public init(_ x: Vector.Scalar, _ y: Vector.Scalar) {
      self.init(x: x, y: y)
    }
  }
#endif
