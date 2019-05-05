/*
 TwoDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/*
import SDGControlFlow

/// A point in a two‐dimensional space.
public struct TwoDimensionalPoint<Coordinate> : TwoDimensionalPointProtocol
where Coordinate : IntegralArithmetic {

    // MARK: - TwoDimensionalPointProtocol

    public typealias Vector = TwoDimensionalVector<Coordinate>
    public typealias Scalar = Coordinate

    @inlinable public init(_ x: Coordinate, _ y: Coordinate) {
        self.x = x
        self.y = y
    }

    public var x: Coordinate
    public var y: Coordinate






    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule) {
        x.round(rule)
        y.round(rule)
    }

    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule) -> TwoDimensionalPoint {
        return nonmutatingVariant(of: { $0.round($1) }, on: self, with: rule)
    }

    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) {
        x.round(rule, toMultipleOf: factor)
        y.round(rule, toMultipleOf: factor)
    }

    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) -> TwoDimensionalPoint {
        return nonmutatingVariant(of: { $0.round($1, toMultipleOf: $2) }, on: self, with: (rule, factor))
    }

    // MARK: - Decodable

    @inlinable public init(from decoder: Decoder) throws {
        var coordinates = try decoder.unkeyedContainer()
        let x = try coordinates.decode(Vector.Scalar.self)
        let y = try coordinates.decode(Vector.Scalar.self)
        self.init(x, y)
    }

    // MARK: - Encodable

    @inlinable public func encode(to encoder: Encoder) throws {
        var coordinates = encoder.unkeyedContainer()
        try coordinates.encode(x)
        try coordinates.encode(y)
    }

    // MARK: - Equatable

    @inlinable public static func == (precedingValue: TwoDimensionalPoint, followingValue: TwoDimensionalPoint) -> Bool {
        return (precedingValue.x, precedingValue.y) == (followingValue.x, followingValue.y)
    }

    // MARK: - PointProtocol

    @inlinable public static func += (precedingValue: inout TwoDimensionalPoint, followingValue: Vector) {
        precedingValue.x += followingValue.Δx
        precedingValue.y += followingValue.Δy
    }

    @inlinable public static func − (precedingValue: TwoDimensionalPoint, followingValue: TwoDimensionalPoint) -> Vector {
        let Δx = precedingValue.x − followingValue.x
        let Δy = precedingValue.y − followingValue.y
        return TwoDimensionalPoint.Vector(Δx: Δx, Δy: Δy)
    }

    @inlinable public static func + (precedingValue: TwoDimensionalPoint, followingValue: Vector) -> TwoDimensionalPoint {
        return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
    }

    @inlinable public static func − (precedingValue: TwoDimensionalPoint, followingValue: Vector) -> TwoDimensionalPoint {
        return nonmutatingVariant(of: −=, on: precedingValue, with: followingValue)
    }

    @inlinable public static func −= (precedingValue: inout TwoDimensionalPoint, followingValue: Vector) {
        precedingValue += −followingValue
    }
}*/
