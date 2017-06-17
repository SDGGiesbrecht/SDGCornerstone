/*
 WholeNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents whole numbers.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
public protocol WholeNumberProtocol : WholeArithmetic {

}

extension WholeNumberProtocol {

    /// Returns the number in digits.
    ///
    /// - Parameters:
    ///     - thousandsSeparator: The character to use as a thousands separator. (Space by default.)
    public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        return wholeDigits(thousandsSeparator: thousandsSeparator)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.inRomanNumerals(lowercase:)_]
    /// Returns the number in roman numerals.
    ///
    /// - Precondition: The number must be in the range I–MMMCMXCIX.
    ///
    /// - Parameters:
    ///     - lowercase: Whether the numeral should be in lowercase. (`false` by default.)
    public func inRomanNumerals(lowercase: Bool = false) -> StrictString {
        return romanNumerals(lowercase: lowercase)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.στουςΕλληνικούςΑριθμούς(μικράΓράμματα:κεραία:)_]
    /// Επιστρέφει τον αριθμό στους ελληνικούς αριθμούς.
    ///
    /// - Precondition: Ο αριθμός είναι σε Αʹ–͵ΘϠϞΘʹ.
    public func στουςΕλληνικούςΑριθμούς(μικράΓράμματα: Bool = false, κεραία: Bool = true) -> StrictString {
        return ελληνικοίΑριθμοί(μικράΓράμματα: μικράΓράμματα, κεραία: κεραία)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.בספרות־עבריות(גרשיים:)_]
    /// מחזירה את המספר בספרות עבריות.
    ///
    /// - Precondition: המספר ב־א׳–ט׳תתקצ״ט.
    public func בספרות־עבריות(גרשיים: Bool = true) -> StrictString {
        return ספרות־עבריות(גרשיים: גרשיים)
    }
}
