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
where Vector : TwoDimensionalVector, Vector.Scalar == Scalar {

    //typealias Scalar = Vector.Scalar
    // [_Workaround: Related to the workaround at the top of the file. (Swift 4.0.3)_]
    associatedtype Scalar

    // [_Define Documentation: SDGCornerstone.TwoDimensionalPoint.x_]
    /// The *x* co‐ordinate.
    var x: Scalar { get set }

    // [_Define Documentation: SDGCornerstone.TwoDimensionalPoint.y_]
    /// The *y* co‐ordinate.
    var y: Scalar { get set }

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the point’s co‐ordinates to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    mutating func round(_ rule: WholeArithmetic.RoundingRule)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the point with its co‐ordinates rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the point’s co‐ordinates to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Scalar)

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the point with its co‐ordinates rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Self.Scalar) -> Self
}

extension TwoDimensionalPoint {

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:)_]
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @_inlineable public mutating func round(_ rule: WholeArithmetic.RoundingRule) {
        x.round(rule)
        y.round(rule)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:)_]
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    @_inlineable public func rounded(_ rule: WholeArithmetic.RoundingRule) -> Self {
        return nonmutatingVariant(of: Self.round, on: self, with: rule)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.round(_:toMultipleOf:)_]
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @_inlineable public mutating func round(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Scalar) {
        x.round(rule, toMultipleOf: factor)
        y.round(rule, toMultipleOf: factor)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.rounded(_:toMultipleOf:)_]
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    @_inlineable public func rounded(_ rule: WholeArithmetic.RoundingRule, toMultipleOf factor: Scalar) -> Self {
        return nonmutatingVariant(of: Self.round, on: self, with: (rule, factor))
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    @_inlineable public static func += (precedingValue: inout Self, followingValue: Vector) {
        precedingValue.x += followingValue.Δx
        precedingValue.y += followingValue.Δy
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    @_inlineable public static func − (precedingValue: Self, followingValue: Self) -> Vector {
        let Δx = precedingValue.x − followingValue.x
        let Δy = precedingValue.y − followingValue.y
        return Self.Vector(Δx : Δx, Δy : Δy)
    }
}
