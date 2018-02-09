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
/// - `static func += (precedingValue: inout Self, followingValue: Self)`
public protocol Addable {

    // [_Define Documentation: SDGCornerstone.Addable.+_]
    /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to add.
    static func + (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    static func += (precedingValue: inout Self, followingValue: Self)
}

extension Addable {

    fileprivate static func addAsAddable(_ precedingValue: Self, _ followingValue: Self) -> Self {
        var result = precedingValue
        result += followingValue
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.Addable.+_]
    /// Returns the sum, concatenation, or the result of a similar operation on two values implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to add.
    public static func + (precedingValue: Self, followingValue: Self) -> Self {
        return addAsAddable(precedingValue, followingValue)
    }

    // [_Define Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.

    // [_Define Documentation: SDGCornerstone.Addable(Summation).+=_]
    /// Adds the following value to the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
}

extension Addable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func + (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue + followingValue.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+=_]
    /// Adds the following value to the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    public static func += (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue += followingValue.rawValue
    }
}

extension Addable where Self : PointProtocol, Self.Vector == Self {
    // MARK: - where Self : PointProtocol, Vector == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func + (precedingValue: Self, followingValue: Self) -> Self {
        // Disambiguate Addable.+ vs PointProtocol.+
        return addAsAddable(precedingValue, followingValue)
    }
}

extension Addable where Self : PointProtocol, Self : Strideable, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : PointProtocol, Self : Strideable, Vector == Self, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func + (precedingValue: Self, followingValue: Self) -> Self {
        // Disambiguate Addable.+ vs PointProtocol.+ vs Strideable.+
        return addAsAddable(precedingValue, followingValue)
    }
}

extension Addable where Self : Strideable, Self.Stride == Self {
    // MARK: - where Self : Strideable, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Addable(Summation).+_]
    /// Returns the sum of the two values.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func + (precedingValue: Self, followingValue: Self) -> Self {
        // Disambiguate Addable.+ vs Strideable.+
        return addAsAddable(precedingValue, followingValue)
    }
}

extension Addable where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    public static func += (precedingValue: inout Self, followingValue: Self) {
        precedingValue.Δx += followingValue.Δx
        precedingValue.Δy += followingValue.Δy
    }
}
