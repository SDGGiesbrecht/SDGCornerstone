/*
 TwoDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A point in a two‐dimensional space.
public struct TwoDimensionalPoint<Coordinate> : TwoDimensionalPointProtocol
where Coordinate : IntegralArithmetic {

    // MARK: - TwoDimensionalPointProtocol

    public typealias Vector = TwoDimensionalVector<Coordinate>

    @inlinable public init(_ x: Coordinate, _ y: Coordinate) {
        self.x = x
        self.y = y
    }

    public var x: Coordinate
    public var y: Coordinate
}
