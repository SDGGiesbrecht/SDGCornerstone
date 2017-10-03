/*
 VectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An value that can be used with ×(_:_) and ÷(_:_:) in conjunction with a scalar.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
/// - `static func ×= (lhs: inout Self, rhs: Scalar)`
/// - `static func ÷= (lhs: inout Self, rhs: Scalar)`
public protocol VectorProtocol : AdditiveArithmetic {

    // [_Define Documentation: SDGCornerstone.VectorProtocol.Scalar_]
    // The scalar type.
    associatedtype Scalar : RationalArithmetic

    // [_Define Documentation: SDGCornerstone.VectorProtocol.×(_:scalar:)_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: A scalar coefficient.
    ///
    /// - MutatingVariant: ×=
    static func × (lhs: Self, rhs: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.VectorProtocol.×(scalar:_:)_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A scalar coefficient.
    ///     - rhs: A value.
    static func × (lhs: Scalar, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.VectorProtocol.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The scalar coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    static func ×= (lhs: inout Self, rhs: Scalar)

    // [_Define Documentation: SDGCornerstone.VectorProtocol.÷_]
    /// Returns the quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    static func ÷ (lhs: Self, rhs: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.VectorProtocol.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    static func ÷= (lhs: inout Self, rhs: Scalar)
}

extension VectorProtocol {

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×(_:scalar:)_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: A scalar coefficient.
    ///
    /// - MutatingVariant: ×=
    public static func × (lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ×= rhs
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×(scalar:_:)_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A scalar coefficient.
    ///     - rhs: A value.
    public static func × (lhs: Scalar, rhs: Self) -> Self {
        return rhs × lhs
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.÷_]
    /// Returns the quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    public static func ÷ (lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ÷= rhs
        return result
    }
}

extension VectorProtocol where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The scalar coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    public static func ×=(lhs: inout Self, rhs: Scalar) {
        lhs.Δx ×= rhs
        lhs.Δy ×= rhs
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.÷=_]
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    public static func ÷=(lhs: inout Self, rhs: Scalar) {
        lhs.Δx ÷= rhs
        lhs.Δy ÷= rhs
    }
}
