/*
 TwoDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A point in a two‐dimensional space.
///
/// Conformance Requirements:
///
/// - `var x: Vector.Scalar { get set }`
/// - `var y: Vector.Scalar { get set }`
public protocol TwoDimensionalPoint : PointProtocol {

    // [_Define Documentation: SDGCornerstone.TwoDimensionalPoint.Vector_]
    /// The vector type.
    associatedtype Vector : TwoDimensionalVector

    // [_Define Documentation: SDGCornerstone.TwoDimensionalPoint.x_]
    /// The *x* co‐ordinate.
    var x: Vector.Scalar { get set }

    // [_Define Documentation: SDGCornerstone.TwoDimensionalPoint.y_]
    /// The *y* co‐ordinate.
    var y: Vector.Scalar { get set }

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the point’s co‐ordinates to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - NonmutatingVariant: rounded
    mutating func round(_ rule: WholeArithmetic.RoundingRule)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the point with its co‐ordinates rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - MutatingVariant: round
    func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the point’s co‐ordinates to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - NonmutatingVariant: rounded
    mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Vector.Scalar)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the point with its co‐ordinates rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - MutatingVariant: round
    func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Vector.Scalar) -> Self
}

extension TwoDimensionalPoint {

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the point’s co‐ordinates to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: WholeArithmetic.RoundingRule) {
        x.round(rule)
        y.round(rule)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the point with its co‐ordinates rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - MutatingVariant: round
    public func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self {
        var result = self
        result.round(rule)
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the point’s co‐ordinates to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - NonmutatingVariant: rounded
    public mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) {
        x.round(rule, toMultipleOf: factor)
        y.round(rule, toMultipleOf: factor)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the point with its co‐ordinates rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - MutatingVariant: round
    public func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Vector.Scalar) -> Self {
        var result = self
        result.round(rule, toMultipleOf: factor)
        return result
    }
}
