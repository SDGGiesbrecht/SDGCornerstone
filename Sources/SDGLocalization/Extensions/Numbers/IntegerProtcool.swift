/*
 IntegerProtcool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension IntegerProtocol {

    // #documentation(SDGCornerstone.WholeNumberProtocol.inDigits(thousandsSeparator:))
    /// Returns the number in digits.
    ///
    /// - Parameters:
    ///     - thousandsSeparator: The character to use as a thousands separator. (Space by default.)
    public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        return integralDigits(thousandsSeparator: thousandsSeparator)
    }

    // #documentation(SDGCornerstone.WholeNumberProtocol.abbreviatedEnglishOrdinal())
    /// Returns the ordinal in its abbreviated English form. (“1st”, “2nd”, “3rd”, etc.)
    public func abbreviatedEnglishOrdinal() -> SemanticMarkup {
        return generateAbbreviatedEnglishOrdinal()
    }

    public func _verkürzteDeutscheOrdnungszahl() -> StrictString {
        // Public for SDGCalendar.
        return verkürzteDeutscheOrdnungszahlErzeugen()
    }

    public func _ordinalFrançaisAbrégé(genre: _GenreGrammatical, nombre: GrammaticalNumber) -> SemanticMarkup {
        return générerOrdinalFrançaisAbrégé(genre: genre, nombre: nombre)
    }

    // #documentation(SDGCornerstone.WholeNumberProtocol.inRomanNumerals(lowercase:))
    /// Returns the number in roman numerals.
    ///
    /// - Parameters:
    ///     - lowercase: Whether the numeral should be in lowercase. (`false` by default.)
    public func inRomanNumerals(lowercase: Bool = false) -> StrictString {
        return romanNumerals(lowercase: lowercase)
    }

    public func _σεΕλληνικούςΑριθμούς(μικράΓράμματα: Bool = false, κεραία: Bool = true) -> StrictString {
        // Public for SDGCalendar
        return ελληνικοίΑριθμοί(μικράΓράμματα: μικράΓράμματα, κεραία: κεραία)
    }

    public func _בספרות־עבריות(גרשיים: Bool = true) -> StrictString {
        // Public for SDGCalendar
        return ספרות־עבריות(גרשיים: גרשיים)
    }
}
