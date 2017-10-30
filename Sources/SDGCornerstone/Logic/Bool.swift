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

extension Bool : Comparable, PropertyListValue {

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

    // MARK: - Text Representations

    /// Returns “✓” or “✗”.
    public func checkOrX() -> StrictString {
        switch self {
        case true:
            return "✓"
        case false:
            return "✗"
        }
    }

    /// Returns “true” or “false”.
    public func trueOrFalse(_ casing: EnglishCasing) -> StrictString {
        switch self {
        case true:
            return casing.applySimpleAlgorithm(to: "true")
        case false:
            return casing.applySimpleAlgorithm(to: "false")
        }
    }

    /// Returns “yes” or “no”.
    public func yesOrNo(_ casing: EnglishCasing) -> StrictString {
        switch self {
        case true:
            return casing.applySimpleAlgorithm(to: "yes")
        case false:
            return casing.applySimpleAlgorithm(to: "no")
        }
    }

    /// Gibt „wahr“ oder „falsch“ zurück.
    public func wahrOderFalsch(_ großschreibung: Casing) -> StrictString {
        switch self {
        case true:
            return großschreibung.applySimpleAlgorithm(to: "wahr")
        case false:
            return großschreibung.applySimpleAlgorithm(to: "falsch")
        }
    }

    /// Gibt „ja“ oder „nein“ zurück.
    public func jaOderNein(_ großschreibung: Casing) -> StrictString {
        switch self {
        case true:
            return großschreibung.applySimpleAlgorithm(to: "ja")
        case false:
            return großschreibung.applySimpleAlgorithm(to: "nein")
        }
    }

    /// Retourne « vrai » ou « faux ».
    public func vraiOuFaux(_ majuscules: Casing) -> StrictString {
        switch self {
        case true:
            return majuscules.applySimpleAlgorithm(to: "vrai")
        case false:
            return majuscules.applySimpleAlgorithm(to: "faux")
        }
    }

    /// Retourne « oui »  ou « non ».
    public func ouiOuNon(_ majuscules: Casing) -> StrictString {
        switch self {
        case true:
            return majuscules.applySimpleAlgorithm(to: "oui")
        case false:
            return majuscules.applySimpleAlgorithm(to: "non")
        }
    }

    /// Επιστρέφει «αληθής» ή «ψευδής».
    public func αληθήςΉΨευδής(_ κεφαλαία: Casing) -> StrictString {
        switch self {
        case true:
            return κεφαλαία.applySimpleAlgorithm(to: "αληθής")
        case false:
            return κεφαλαία.applySimpleAlgorithm(to: "ψευδής")
        }
    }

    /// Επιστρέφει «ναι» ή «όχι».
    public func ναιΉΌχι(_ κεφαλαία: Casing) -> StrictString {
        switch self {
        case true:
            return κεφαλαία.applySimpleAlgorithm(to: "ναι")
        case false:
            return κεφαλαία.applySimpleAlgorithm(to: "όχι")
        }
    }

    /// מחזירה את ”חיובי“ או את ”שלילי“.
    public func חיובי־או־שלילי() -> StrictString {
        switch self {
        case true:
            return "חיובי"
        case false:
            return "שלילי"
        }
    }

    /// מחזירה את ”כן“ או את ”לא“.
    public func כן־או־לא() -> StrictString {
        switch self {
        case true:
            return "כן"
        case false:
            return "לא"
        }
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
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// // ...
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
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), false)
    /// XCTAssertEqual(Bool(fromRandomizer: alternating), true)
    /// // ...
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
