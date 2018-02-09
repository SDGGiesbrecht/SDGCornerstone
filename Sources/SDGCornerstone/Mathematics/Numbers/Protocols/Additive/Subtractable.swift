/*
 Subtractable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
/// Returns the difference of the preceding value minus the following value.
///
/// - Parameters:
///     - precedingValue: The starting value.
///     - followingValue: The value to subtract.
infix operator −: AdditionPrecedence

// [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
/// Subtracts the following value from the preceding value.
///
/// - Parameters:
///     - precedingValue: The value to modify.
///     - followingValue: The value to subtract.
infix operator −=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.Subtractable.±_]
/// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
///
/// - Parameters:
///     - precedingValue: The augend/minuend.
///     - followingValue: The addend/subtrahend.
infix operator ±: AdditionPrecedence

/// A type that can do scalar subtraction.
///
/// - Note: `Subtractable` is distinct from `Negatable` to allow whole number types to perform subtraction.
///
/// - Note: Unlike `Numeric`, `Subtractable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `Addable`
/// - `static func −= (precedingValue: inout Self, followingValue: Self)`
public protocol Subtractable : Addable {

    // [_Define Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    static func − (precedingValue: Self, followingValue: Self) -> Self

    // [_Define Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    static func −= (precedingValue: inout Self, followingValue: Self)

    // [_Define Documentation: SDGCornerstone.Subtractable.±_]
    /// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The augend/minuend.
    ///     - followingValue: The addend/subtrahend.
    static func ± (precedingValue: Self, followingValue: Self) -> (sum: Self, difference: Self)
}

extension Subtractable {

    fileprivate static func subtractAsSubtractable(_ precedingValue: Self, _ followingValue: Self) -> Self {
        var result = precedingValue
        result −= followingValue
        return result
    }
    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return subtractAsSubtractable(precedingValue, followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.±_]
    /// Returns a tuple containing the sum and difference of `precedingValue` and `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The augend/minuend.
    ///     - followingValue: The addend/subtrahend.
    public static func ± (precedingValue: Self, followingValue: Self) -> (sum: Self, difference: Self) {
        return (precedingValue + followingValue, precedingValue − followingValue)
    }
}

extension FloatFamily {
    // Disambiguate FloatingPoint.−= vs Strideable.−=
    fileprivate static func subtractAndAssignAsFloatingPoint(_ precedingValue: inout Self, _ followingValue: Self) {
        precedingValue -= followingValue
    }
}
extension Subtractable where Self : FloatFamily, Self.Vector == Self {
    // MARK: - where Self : FloatFamily, Vector == Self

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Self, followingValue: Self) {
        subtractAndAssignAsFloatingPoint(&precedingValue, followingValue)
    }
}

extension Subtractable where Self : IntFamily /* Self.Vector ≠ Self */ {
    // MARK: - where Self : IntFamily

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue -= followingValue
    }
}

extension Subtractable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return Self(rawValue: precedingValue.rawValue − followingValue.rawValue)
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.rawValue −= followingValue.rawValue
    }
}

extension Subtractable where Self : PointProtocol, Self.Vector == Self {
    // MARK: - where Self : PointProtocol, Vector == Self

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    public static func − (precedingValue: Self, followingValue: Self) -> Self { // [_Exempt from Test Coverage_] Apparently unreachable.
        // Disambiguate Subtractable.− vs PointProtocol.−
        return subtractAsSubtractable(precedingValue, followingValue)
    }
}

extension Subtractable where Self : TwoDimensionalVector {
    // MARK: - where Self : TwoDimensionalVector

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Self, followingValue: Self) {
        precedingValue.Δx −= followingValue.Δx
        precedingValue.Δy −= followingValue.Δy
    }
}

extension Subtractable where Self : UIntFamily {
    // MARK: - where Self : UIntFamily

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−_]
    /// Returns the difference of the preceding value minus the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The starting value.
    ///     - followingValue: The value to subtract.
    public static func − (precedingValue: Self, followingValue: Self) -> Self {
        return precedingValue - followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout Self, followingValue: Self) {
        assert(precedingValue ≥ followingValue, UserFacingText({ [precedingValue] (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return StrictString("\(precedingValue.inDigits()) − \(followingValue.inDigits()) is impossible for \(Self.self).")
            }
        }))

        // func −=
        precedingValue -= followingValue
    }
}
