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
    /// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` evaluates to `true`.
    ///
    /// - Parameters:
    ///     - lhs: A Boolean value.
    ///     - rhs: A closure that results in another Boolean value.
    @_inlineable public static func ∧ (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
        return try lhs && rhs
    }

    // [_Define Documentation: SDGCornerstone.Bool.∧=_]
    /// Modifies the left value by logical conjunction with the right.
    ///
    /// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` is `true`.
    ///
    /// - Parameters:
    ///     - lhs: The Boolean value to modify.
    ///     - rhs: A closure that results in another Boolean value.
    @_inlineable public static func ∧= (lhs: inout Bool, rhs: @autoclosure () throws -> Bool) rethrows {
        lhs = try lhs ∧ rhs
    }

    // [_Define Documentation: SDGCornerstone.Bool.∨_]
    /// Returns the logical disjunction of the two Boolean values.
    ///
    /// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` evaluates to `false`.
    ///
    /// - Parameters:
    ///     - lhs: A Boolean value.
    ///     - rhs: A closure that results in another Boolean value.
    @_inlineable public static func ∨ (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
        return try lhs || rhs
    }

    // [_Define Documentation: SDGCornerstone.Bool.∨=_]
    /// Modifies the left value by logical disjunction with the right.
    ///
    /// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` is `false`.
    ///
    /// - Parameters:
    ///     - lhs: The Boolean value to modify.
    ///     - rhs: A closure that results in another Boolean value.
    @_inlineable public static func ∨= (lhs: inout Bool, rhs: @autoclosure () throws -> Bool) rethrows {
        lhs = try lhs ∨ rhs
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    @_inlineable public static func < (lhs: Bool, rhs: Bool) -> Bool {
        if lhs == false ∧ rhs == true {
            return true
        } else {
            return false
        }
    }
}
