/*
 IntegerProtcool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension IntegerProtocol {

    // [_Inherit Documentation: SDGCornerstone.WholeNumberProtocol.inDigits(thousandsSeparator:)_]
    /// Returns the number in digits.
    ///
    /// - Parameters:
    ///     - thousandsSeparator: The character to use as a thousands separator. (Space by default.)
    @_transparent public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        return integralDigits(thousandsSeparator: thousandsSeparator)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeNumberProtocol.abbreviatedEnglishOrdinal()_]
    /// Returns the ordinal in its abbreviated English form. (“1st”, “2nd”, “3rd”, etc.)
    @_transparent public func abbreviatedEnglishOrdinal() -> SemanticMarkup {
        return generateAbbreviatedEnglishOrdinal()
    }

    // [_Inherit Documentation: SDGCornerstone.WholeNumberProtocol.inRomanNumerals(lowercase:)_]
    /// Returns the number in roman numerals.
    ///
    /// - Parameters:
    ///     - lowercase: Whether the numeral should be in lowercase. (`false` by default.)
    @_transparent public func inRomanNumerals(lowercase: Bool = false) -> StrictString {
        return romanNumerals(lowercase: lowercase)
    }
}
