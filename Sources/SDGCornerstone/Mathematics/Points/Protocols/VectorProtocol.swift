/*
 VectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An value that can be used with ×(_:_) and ÷(_:_:) in conjunction with a scalar.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
/// - `static func ×= (precedingValue: inout Self, followingValue: Scalar)`
/// - `static func ÷= (precedingValue: inout Self, followingValue: Scalar)`
public protocol VectorProtocol : AdditiveArithmetic {

    // [_Define Documentation: SDGCornerstone.VectorProtocol.Scalar_]
    /// The scalar type.
    associatedtype Scalar : RationalArithmetic

    // [_Define Documentation: SDGCornerstone.VectorProtocol.×(_:scalar:)_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: A scalar coefficient.
    ///
    /// - MutatingVariant: ×=
    static func × (precedingValue: Self, followingValue: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.VectorProtocol.×(scalar:_:)_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A scalar coefficient.
    ///     - followingValue: A value.
    static func × (precedingValue: Scalar, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.VectorProtocol.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The scalar coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    static func ×= (precedingValue: inout Self, followingValue: Scalar)

    // [_Define Documentation: SDGCornerstone.VectorProtocol.÷_]
    /// Returns the quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    ///
    /// - MutatingVariant: ×
    static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self

    // [_Define Documentation: SDGCornerstone.VectorProtocol.÷=_]
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    static func ÷= (precedingValue: inout Self, followingValue: Scalar)
}

extension VectorProtocol {

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×(_:scalar:)_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: A scalar coefficient.
    ///
    /// - MutatingVariant: ×=
    public static func × (precedingValue: Self, followingValue: Scalar) -> Self {
        var result = precedingValue
        result ×= followingValue
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×(scalar:_:)_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A scalar coefficient.
    ///     - followingValue: A value.
    public static func × (precedingValue: Scalar, followingValue: Self) -> Self {
        return followingValue × precedingValue
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.÷_]
    /// Returns the quotient of the preceding value divided by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The dividend.
    ///     - followingValue: The divisor.
    ///
    /// - MutatingVariant: ×
    public static func ÷ (precedingValue: Self, followingValue: Scalar) -> Self {
        var result = precedingValue
        result ÷= followingValue
        return result
    }
}

extension VectorProtocol where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The scalar coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    public static func ×=(precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.Δx ×= followingValue
        precedingValue.Δy ×= followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.VectorProtocol.÷=_]
    /// Modifies the preceding value by dividing it by the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    public static func ÷=(precedingValue: inout Self, followingValue: Scalar) {
        precedingValue.Δx ÷= followingValue
        precedingValue.Δy ÷= followingValue
    }
}
