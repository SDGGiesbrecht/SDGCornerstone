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

    // @documentation(SDGCornerstone.Bool.¬)
    /// Returns the logical inverse of the operand.
    ///
    /// - Parameters:
    ///     - proposition: The proposition to invert.
    @inlinable public static prefix func ¬ (proposition: Bool) -> Bool {
        return !proposition
    }

    // @documentation(SDGCornerstone.Bool.∧)
    /// Returns the logical conjunction of the two Boolean values.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `true`.
    ///
    /// - Parameters:
    ///     - precedingValue: A Boolean value.
    ///     - followingValue: A closure that results in another Boolean value.
    @inlinable public static func ∧ (precedingValue: Bool, followingValue: @autoclosure () throws -> Bool) rethrows -> Bool {
        return try precedingValue && followingValue
    }

    // @documentation(SDGCornerstone.Bool.∧=)
    /// Modifies the preceding operand by logical conjunction with the following operand.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `true`.
    ///
    /// - Parameters:
    ///     - precedingValue: The Boolean value to modify.
    ///     - followingValue: A closure that results in another Boolean value.
    @inlinable public static func ∧= (precedingValue: inout Bool, followingValue: @autoclosure () throws -> Bool) rethrows {
        precedingValue = try precedingValue ∧ followingValue
    }

    // @documentation(SDGCornerstone.Bool.∨)
    /// Returns the logical disjunction of the two Boolean values.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` evaluates to `false`.
    ///
    /// - Parameters:
    ///     - precedingValue: A Boolean value.
    ///     - followingValue: A closure that results in another Boolean value.
    @inlinable public static func ∨ (precedingValue: Bool, followingValue: @autoclosure () throws -> Bool) rethrows -> Bool {
        return try precedingValue || followingValue
    }

    // @documentation(SDGCornerstone.Bool.∨=)
    /// Modifies the preceding operand by logical disjunction with the following operand.
    ///
    /// This operator uses short‐circuit evaluation; `followingValue` is only evaluated if `precedingValue` is `false`.
    ///
    /// - Parameters:
    ///     - precedingValue: The Boolean value to modify.
    ///     - followingValue: A closure that results in another Boolean value.
    @inlinable public static func ∨= (precedingValue: inout Bool, followingValue: @autoclosure () throws -> Bool) rethrows {
        precedingValue = try precedingValue ∨ followingValue
    }

    // MARK: - Comparable

    // #documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func < (precedingValue: Bool, followingValue: Bool) -> Bool {
        if precedingValue == false ∧ followingValue == true {
            return true
        } else {
            return false
        }
    }
}
