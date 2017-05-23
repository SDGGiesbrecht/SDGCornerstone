/*
 Subtractable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
/// Returns the difference of the left minus the right.
///
/// - Parameters:
///     - lhs: The starting value.
///     - rhs: The value to subtract.
///
/// - MutatingVariant: −=
///
/// - RecommendedOver: -
infix operator −: AdditionPrecedence

// [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
/// Subtracts the right from the left.
///
/// - Parameters:
///     - lhs: The value to modify.
///     - rhs: The value to subtract.
///
/// - NonmutatingVariant: −
///
/// - RecommendedOver: -=
infix operator −=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.Subtractable.±_]
/// Returns a tuple containing the sum and difference of `lhs` and `rhs`.
///
/// - Parameters:
///     - lhs: The augend/minuend.
///     - rhs: The addend/subtrahend.
infix operator ±: AdditionPrecedence

/// A type that can do scalar subtraction.
///
/// - Note: `Subtractable` is distinct from `Negatable` to allow whole number types to perform subtraction.
///
/// - Note: Unlike `SignedNumber`, `Subtractable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `Addable`
/// - `static func −= (lhs: inout Self, rhs: Self)`
public protocol Subtractable : Addable {

    // [_Define Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    static func − (lhs: Self, rhs: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    static func −= (lhs: inout Self, rhs: Self)

    // [_Define Documentation: SDGCornerstone.Subtractable.±_]
    /// Returns a tuple containing the sum and difference of `lhs` and `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The augend/minuend.
    ///     - rhs: The addend/subtrahend.
    static func ± (lhs: Self, rhs: Self) -> (sum: Self, difference: Self)
}

extension Subtractable {

    fileprivate static func subtractAsSubtractable(_ lhs: Self, _ rhs: Self) -> Self {
        var result = lhs
        result −= rhs
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return subtractAsSubtractable(lhs, rhs)
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.±_]
    /// Returns a tuple containing the sum and difference of `lhs` and `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The augend/minuend.
    ///     - rhs: The addend/subtrahend.
    public static func ± (lhs: Self, rhs: Self) -> (sum: Self, difference: Self) {
        return (lhs + rhs, lhs − rhs)
    }
}

extension FloatFamily {
    // Disambiguate FloatingPoint.−= vs Strideable.−=
    fileprivate static func subtractAndAssignAsFloatingPoint(_ lhs: inout Self, _ rhs: Self) {
        lhs -= rhs
    }
}
extension Subtractable where Self : FloatFamily, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : FloatFamily, Vector == Self, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        subtractAndAssignAsFloatingPoint(&lhs, rhs)
    }
}

extension Subtractable where Self : IntFamily /* Self.Stride ≠ Self */ {
    // MARK: - where Self : IntFamily

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        lhs -= rhs
    }
}

extension Subtractable where Self : IntFamily, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : IntFamily, Vector == Self, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
        // Disambiguate Subtractable(where IntFamily).− vs Subtractable(where PointProtocol, Strideable, Stride == Self).−
    }
}

extension Subtractable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return Self(rawValue: lhs.rawValue − rhs.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        lhs.rawValue −= rhs.rawValue
    }
}

extension Subtractable where Self : PointProtocol, Self.Vector == Self {
    // MARK: - where Self : PointProtocol, Vector == Self

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self { // [_Exempt from Code Coverage_] Apparently unreachable.
        // Disambiguate Subtractable.− vs PointProtocol.−
        return subtractAsSubtractable(lhs, rhs)
    }
}

extension Subtractable where Self : PointProtocol, Self : Strideable, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : PointProtocol, Self : Strideable, Vector == Self, Stride == Self

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        // Disambiguate Subtractable(where PointProtocol).− vs PointProtocol(where Strideable).−
        return subtractAsSubtractable(lhs, rhs)
    }
}

extension Subtractable where Self : UIntFamily {
    // MARK: - where Self : UIntFamily

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        assert(lhs ≥ rhs, "\(lhs) − \(rhs) is impossible for \(Self.self).")

        // func −=
        lhs -= rhs
    }
}
