/*
 VectorProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An value that can be used with ×(_:_) in conjunction with a scalar.
///
/// Conformance Requirements:
///
/// - `GenericAdditiveArithmetic`
/// - `static func ×= (precedingValue: inout Self, followingValue: Scalar)`
public protocol VectorProtocol : GenericAdditiveArithmetic {

    /// The scalar type.
    associatedtype Scalar : WholeArithmetic

    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: A scalar coefficient.
    static func × (precedingValue: Self, followingValue: Scalar) -> Self

    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The scalar coefficient by which to multiply.
    static func ×= (precedingValue: inout Self, followingValue: Scalar)
}

extension VectorProtocol {

    @inlinable public static func × (precedingValue: Self, followingValue: Scalar) -> Self {
        return nonmutatingVariant(of: ×=, on: precedingValue, with: followingValue)
    }

    @inlinable public static func × (precedingValue: Scalar, followingValue: Self) -> Self {
        return followingValue × precedingValue
    }
}
