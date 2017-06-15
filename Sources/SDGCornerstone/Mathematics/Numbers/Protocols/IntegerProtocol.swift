/*
 IntegerProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents integers.
///
/// Conformance Requirements:
///
/// - `IntegralArithmetic`
public protocol IntegerProtocol : IntegralArithmetic {

}

extension IntegerProtocol {

    /// Returns the number in digits.
    ///
    /// - Paramters:
    ///     - thousandsSeparator: The character to use as a thousands separator. (Space by default.)
    public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        return integralDigits(thousandsSeparator: thousandsSeparator)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeNumberProtocol.inRomanNumerals(lowercase:)_]
    /// Returns the number in roman numerals.
    ///
    /// - Parameters:
    ///     - lowercase: Whether the numeral should be in lowercase. (`false` by default.)
    public func inRomanNumerals(lowercase: Bool = false) -> StrictString {
        return wholeRomanNumerals(lowercase: lowercase)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeNumberProtocol.στουςΕλληνικούςΑριθμούς(μικράΓράμματα:κεραία:)_]
    /// Επιστρέφει τον αριθμό στους ελληνικούς αριθμούς.
    ///
    /// - Precondition: Ο αριθμός είναι σε Αʹ–͵ΘϠϞΘʹ.
    public func στουςΕλληνικούςΑριθμούς(μικράΓράμματα: Bool = false, κεραία: Bool = true) -> StrictString {
        return φυσικοίΕλληνικοίΑριθμοί(μικράΓράμματα: μικράΓράμματα, κεραία: κεραία)
    }
}
