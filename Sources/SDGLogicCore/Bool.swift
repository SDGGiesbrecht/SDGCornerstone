/*
 Bool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Bool : Comparable {

    // MARK: - Logical Operatiors

    // [_Define Documentation: SDGCornerstone.Bool.¬_]
    /// Returns the logical inverse of the operand.
    ///
    /// - Parameters:
    ///     - proposition: The proposition to invert.
    @_inlineable public static prefix func ¬ (proposition: Bool) -> Bool {
        return !proposition
    }

    // [_Define Documentation: SDGCornerstone.Bool.¬=_]
    /// Modifies the operand by logical inversion.
    ///
    /// - Parameters:
    ///     - proposition: The proposition to modify by inversion.
    @_inlineable public static postfix func ¬= (proposition: inout Bool) {
        proposition = ¬proposition
    }

    // [_Define Documentation: SDGCornerstone.Bool.∧_]
    /// Returns the logical conjunction of the two Boolean values.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `true`.
    ///
    /// - Parameters:
    ///     - precedingValue: A Boolean value.
    ///     - followingValue: A closure that results in another Boolean value.
    @_inlineable public static func ∧ (precedingValue: Bool, followingValue: @autoclosure () throws -> Bool) rethrows -> Bool {
        return try precedingValue && followingValue
    }

    // [_Define Documentation: SDGCornerstone.Bool.∧=_]
    /// Modifies the preceding operand by logical conjunction with the following operand.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `true`.
    ///
    /// - Parameters:
    ///     - precedingValue: The Boolean value to modify.
    ///     - followingValue: A closure that results in another Boolean value.
    @_inlineable public static func ∧= (precedingValue: inout Bool, followingValue: @autoclosure () throws -> Bool) rethrows {
        precedingValue = try precedingValue ∧ followingValue
    }

    // [_Define Documentation: SDGCornerstone.Bool.∨_]
    /// Returns the logical disjunction of the two Boolean values.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `false`.
    ///
    /// - Parameters:
    ///     - precedingValue: A Boolean value.
    ///     - followingValue: A closure that results in another Boolean value.
    @_inlineable public static func ∨ (precedingValue: Bool, followingValue: @autoclosure () throws -> Bool) rethrows -> Bool {
        return try precedingValue || followingValue
    }

    // [_Define Documentation: SDGCornerstone.Bool.∨=_]
    /// Modifies the preceding operand by logical disjunction with the following operand.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `false`.
    ///
    /// - Parameters:
    ///     - precedingValue: The Boolean value to modify.
    ///     - followingValue: A closure that results in another Boolean value.
    @_inlineable public static func ∨= (precedingValue: inout Bool, followingValue: @autoclosure () throws -> Bool) rethrows {
        precedingValue = try precedingValue ∨ followingValue
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func < (precedingValue: Bool, followingValue: Bool) -> Bool {
        if precedingValue == false ∧ followingValue == true {
            return true
        } else {
            return false
        }
    }
}
