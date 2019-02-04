/*
 TwoDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A point in a two‐dimensional space.
///
/// Conformance Requirements:
///
/// - `var x: Scalar { get set }`
/// - `var y: Scalar { get set }`
public protocol TwoDimensionalPoint : PointProtocol
where Vector : TwoDimensionalVector {

    // @documentation(SDGCornerstone.TwoDimensionalPoint.Scalar)
    /// The scalar type.
    typealias Scalar = Vector.Scalar

    // @documentation(SDGCornerstone.TwoDimensionalPoint.x)
    /// The *x* co‐ordinate.
    var x: Scalar { get set }

    // @documentation(SDGCornerstone.TwoDimensionalPoint.y)
    /// The *y* co‐ordinate.
    var y: Scalar { get set }

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
    mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Scalar)

    /// Returns the point with its co‐ordinates rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Scalar) -> Self
}

extension TwoDimensionalPoint {

    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule) {
        x.round(rule)
        y.round(rule)
    }

    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self {
        return nonmutatingVariant(of: { $0.round($1) }, on: self, with: rule)
    }

    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Scalar) {
        x.round(rule, toMultipleOf: factor)
        y.round(rule, toMultipleOf: factor)
    }

    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Scalar) -> Self {
        return nonmutatingVariant(of: { $0.round($1, toMultipleOf: $2) }, on: self, with: (rule, factor))
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
