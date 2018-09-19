/*
 TwoDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    // @documentation(SDGCornerstone.WholeArithmetic.round(_:))
    /// Rounds the point’s co‐ordinates to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    mutating func round(_ rule: WholeArithmetic.RoundingRule)

    // @documentation(SDGCornerstone.WholeArithmetic.rounded(_:))
    /// Returns the point with its co‐ordinates rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self

    // @documentation(SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:))
    /// Rounds the point’s co‐ordinates to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Scalar)

    // @documentation(SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:))
    /// Returns the point with its co‐ordinates rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Scalar) -> Self
}

extension TwoDimensionalPoint {

    // #documentation(SDGCornerstone.WholeArithmetic.round(_:))
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule) {
        x.round(rule)
        y.round(rule)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.rounded(_:))
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self {
        return nonmutatingVariant(of: { $0.round($1) }, on: self, with: rule)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:))
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @inlinable public mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Scalar) {
        x.round(rule, toMultipleOf: factor)
        y.round(rule, toMultipleOf: factor)
    }

    // #documentation(SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:))
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @inlinable public func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Scalar) -> Self {
        return nonmutatingVariant(of: { $0.round($1, toMultipleOf: $2) }, on: self, with: (rule, factor))
    }

    // MARK: - PointProtocol

    // #documentation(SDGCornerstone.PointProtocol.+=)
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    @inlinable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue.x += followingValue.Δx
        precedingValue.y += followingValue.Δy
    }

    // #documentation(SDGCornerstone.PointProtocol.−)
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    @inlinable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        let Δx = precedingValue.x − followingValue.x
        let Δy = precedingValue.y − followingValue.y
        return Self.Vector(Δx : Δx, Δy : Δy)
    }
}
