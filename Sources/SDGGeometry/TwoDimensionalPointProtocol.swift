/*
 TwoDimensionalPointProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

/// A point in a two‐dimensional space.
public protocol TwoDimensionalPointProtocol : PointProtocol
where Vector : TwoDimensionalVectorProtocol {

    /// The co‐ordinate type.
    typealias Coordinate = Vector.Scalar

    /// Creates a point from two co‐ordinates.
    ///
    /// - Parameters:
    ///     - x: The *x* co‐ordinate.
    ///     - y: The *y* co‐ordinate.i
    init(_ x: Coordinate, _ y: Coordinate)

    /// The *x* co‐ordinate.
    var x: Coordinate { get set }

    /// The *y* co‐ordinate.
    var y: Coordinate { get set }

    /// Rounds the point’s co‐ordinates to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    mutating func round(_ rule: WholeArithmetic.RoundingRule)

    /// Returns the point with its co‐ordinates rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self

    /// Rounds the point’s co‐ordinates to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar)

    /// Returns the point with its co‐ordinates rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) -> Self
}

extension TwoDimensionalPointProtocol {

    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule) {
        x.round(rule)
        y.round(rule)
    }

    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self {
        return nonmutatingVariant(of: { $0.round($1) }, on: self, with: rule)
    }

    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) {
        x.round(rule, toMultipleOf: factor)
        y.round(rule, toMultipleOf: factor)
    }

    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) -> Self {
        return nonmutatingVariant(of: { $0.round($1, toMultipleOf: $2) }, on: self, with: (rule, factor))
    }

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        var coordinates = try decoder.unkeyedContainer()
        let x = try coordinates.decode(Coordinate.self)
        let y = try coordinates.decode(Coordinate.self)
        self.init(x, y)
    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        var coordinates = encoder.unkeyedContainer()
        try coordinates.encode(x)
        try coordinates.encode(y)
    }

    // MARK: - Equatable

    @inlinable public static func == (precedingValue: Self, followingValue: Self) -> Bool {
        return (precedingValue.x, precedingValue.y) == (followingValue.x, followingValue.y)
    }

    // MARK: - PointProtocol

    @inlinable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue.x += followingValue.Δx
        precedingValue.y += followingValue.Δy
    }

    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        let Δx = precedingValue.x − followingValue.x
        let Δy = precedingValue.y − followingValue.y
        return Self.Vector(Δx: Δx, Δy: Δy)
    }
}
