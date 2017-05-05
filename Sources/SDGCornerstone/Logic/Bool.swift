/*
 Bool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Inherit Documentation: SDGCornerstone.Bool.¬_]
/// Returns the logical inverse of the operand.
///
/// - Parameters:
///     - proposition: The proposition to invert.
///
/// - MutatingVariant: ¬=
///
/// - RecommendedOver: !
prefix operator ¬

// [_Inherit Documentation: SDGCornerstone.Bool.¬=_]
/// Modifies the operand by logical inversion.
///
/// - Parameters:
///     - proposition: The proposition to modify by inversion.
///
/// - NonmutatingVariant: ¬
postfix operator ¬=

// [_Inherit Documentation: SDGCornerstone.Bool.∧_]
/// Returns the logical conjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` evaluates to `true`.
///
/// - Parameters:
///     - lhs: A Boolean value.
///     - rhs: A closure that results in another Boolean value.
///
/// - MutatingVariant: ∧=
///
/// - RecommendedOver: &&
infix operator ∧: LogicalConjunctionPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∧=_]
/// Modifies the left value by logical conjunction with the right.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` is `true`.
///
/// - Parameters:
///     - lhs: The Boolean value to modify.
///     - rhs: A closure that results in another Boolean value.
///
/// - NonmutatingVariant: ∧
infix operator ∧=: AssignmentPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∨_]
/// Returns the logical disjunction of the two Boolean values.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` evaluates to `false`.
///
/// - Parameters:
///     - lhs: A Boolean value.
///     - rhs: A closure that results in another Boolean value.
///
/// - MutatingVariant: ∨=
///
/// - RecommendedOver: ||
infix operator ∨: LogicalDisjunctionPrecedence

// [_Inherit Documentation: SDGCornerstone.Bool.∨=_]
/// Modifies the left value by logical disjunction with the right.
///
/// This operator uses short‐circuit evaluation; `rhs` is only evaluated if `lhs` is `false`.
///
/// - Parameters:
///     - lhs: The Boolean value to modify.
///     - rhs: A closure that results in another Boolean value.
///
/// - NonmutatingVariant: ∨
infix operator ∨=: AssignmentPrecedence

extension Bool : Comparable {

    // MARK: - Logical Operatiors

    // [_Define Documentation: SDGCornerstone.Bool.¬_]
    /// Returns the logical inverse of the operand.
    ///
    /// - Parameters:
    ///     - proposition: The proposition to invert.
    ///
    /// - MutatingVariant: ¬=
    ///
    /// - RecommendedOver: !
    public static prefix func ¬ (proposition: Bool) -> Bool {
        return !proposition
    }

    // [_Define Documentation: SDGCornerstone.Bool.¬=_]
    /// Modifies the operand by logical inversion.
    ///
    /// - Parameters:
    ///     - proposition: The proposition to modify by inversion.
    ///
    /// - NonmutatingVariant: ¬
    public static postfix func ¬= (proposition: inout Bool) {
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
    ///
    /// - MutatingVariant: ∧=
    ///
    /// - RecommendedOver: &&
    public static func ∧ (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
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
    ///
    /// - NonmutatingVariant: ∧
    public static func ∧= (lhs: inout Bool, rhs: @autoclosure () throws -> Bool) rethrows {
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
    ///
    /// - MutatingVariant: ∨=
    ///
    /// - RecommendedOver: ||
    public static func ∨ (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
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
    ///
    /// - NonmutatingVariant: ∨
    public static func ∨= (lhs: inout Bool, rhs: @autoclosure () throws -> Bool) rethrows {
        lhs = try lhs ∨ rhs
    }

    // MARK: - Randomization

    private static let randomizationBit: UInt64 = 1 << 48

    // [_Example 1: Alternating Booleans_]
    /// A value a `Randomizer` can return that will result in `false`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let alternating = CyclicalNumberGenerator([
    ///     Bool.falseRandomizerValue,
    ///     Bool.trueRandomizerValue
    ///     ])
    ///
    /// // Booleans created using...
    /// _ = Bool(fromRandomizer: alternating)
    /// // ...now alternate between “false” and “true”.
    /// ```
    public static let falseRandomizerValue: UInt64 = 0

    // [_Example 1: Alternating Booleans_]
    /// A value a `Randomizer` can return that will result in `true`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let alternating = CyclicalNumberGenerator([
    ///     Bool.falseRandomizerValue,
    ///     Bool.trueRandomizerValue
    ///     ])
    ///
    /// // Booleans created using...
    /// _ = Bool(fromRandomizer: alternating)
    /// // ...now alternate between “false” and “true”.
    /// ```
    public static let trueRandomizerValue: UInt64 = randomizationBit

    /// Returns a random Boolean value.
    public static func random() -> Bool {
        return Bool(fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    /// Creates a random Boolean value derived from a particular randomizer.
    ///
    /// - Parameters:
    ///     - randomizer: The randomizer.
    public init(fromRandomizer randomizer: Randomizer) {
        self = randomizer.randomNumber().bitwiseAnd(with: Bool.randomizationBit) == Bool.randomizationBit
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        if lhs == false ∧ rhs == true {
            return true
        } else {
            return false
        }
    }
}
