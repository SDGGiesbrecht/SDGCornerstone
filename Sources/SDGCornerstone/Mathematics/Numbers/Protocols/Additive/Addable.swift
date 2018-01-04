/*
 Addable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that can be used with `+(_:_:)`.
///
/// The precise behaviour of `+` depends on the conforming type. It may be arithmetic addition, string concatenation, etc.
///
/// Conformance Requirements:
///
/// - `static func += (lhs: inout Self, rhs: Self)`
public protocol Addable {

    // [_Define Documentation: SDGCornerstone.Addable.+_]
    /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to add.
    ///
    /// - MutatingVariant: +=
    static func + (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the right value to the left, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
    static func += (lhs: inout Self, rhs: Self)
}

extension Addable {

    fileprivate static func addAsAddable(_ lhs: Self, _ rhs: Self) -> Self {
        var result = lhs
        result += rhs
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.Addable.+_]
    /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to add.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Self) -> Self {
        return addAsAddable(lhs, rhs)
    }

    // [_Define Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: +=

    // [_Define Documentation: SDGCornerstone.Addable(Summation).+=_]
    /// Adds the right value to the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
}

extension Addable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Self(rawValue: lhs.rawValue + rhs.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+=_]
    /// Adds the right value to the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.rawValue += rhs.rawValue
    }
}

extension Addable where Self : PointProtocol, Self.Vector == Self {
    // MARK: - where Self : PointProtocol, Vector == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Self) -> Self {
        // Disambiguate Addable.+ vs PointProtocol.+
        return addAsAddable(lhs, rhs)
    }
}

extension Addable where Self : PointProtocol, Self : Strideable, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : PointProtocol, Self : Strideable, Vector == Self, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Self) -> Self {
        // Disambiguate Addable.+ vs PointProtocol.+ vs Strideable.+
        return addAsAddable(lhs, rhs)
    }
}

extension Addable where Self : Strideable, Self.Stride == Self {
    // MARK: - where Self : Strideable, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: +=
    public static func + (lhs: Self, rhs: Self) -> Self {
        // Disambiguate Addable.+ vs Strideable.+
        return addAsAddable(lhs, rhs)
    }
}

extension Addable where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the right value to the left, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.Δx += rhs.Δx
        lhs.Δy += rhs.Δy
    }
}
