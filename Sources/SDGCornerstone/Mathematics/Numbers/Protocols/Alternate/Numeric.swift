/*
 Numeric.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Numeric {

    // [_Define Documentation: SDGCornerstone.Numeric.init(exactly:)_]
    /// Creates a new instance from the given integer, if it can be represented exactly.
}

extension Numeric where Self : NumericAdditiveArithmetic {
    // MARK: - where Self : NumericAdditiveArithmetic

    /// The magnitude of this value.
    public var magnitude: Self {
        return |self|
    }
}

extension Numeric where Self : Subtractable {
    // MARK: - where Self : Subtractable

    /// Subtracts one value from another and produces their difference.
    public static func - (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue − followingValue
    }

    /// Subtracts the second value from the first and stores the difference in the left‐hand‐side variable.
    public static func -= (precedingValue: inout Self, followingValue: Self) {
        precedingValue −= followingValue
    }
}

extension Numeric where Self : Subtractable, Self : Strideable, Self.Stride == Self {
    // MARK: - where Self : Subtractable, Self : Strideable, Self.Stride == Self

    /// Subtracts one value from another and produces their difference.
    public static func - (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue − followingValue
    }

    /// Subtracts the second value from the first and stores the difference in the left‐hand‐side variable.
    public static func -= (precedingValue: inout Self, followingValue: Self) {
        precedingValue −= followingValue
    }
}

extension Numeric where Self : WholeArithmetic {
    // MARK: - where Self : WholeArithmetic

    /// Multiplies two values and produces their product.
    public static func * (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue × followingValue
    }

    /// Multiplies two values and stores the result in the left‐hand‐side variable.
    public static func *= (precedingValue: inout Self, followingValue: Self) {
        precedingValue ×= followingValue
    }
}
