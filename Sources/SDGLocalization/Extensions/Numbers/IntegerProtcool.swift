/*
 IntegerProtcool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText

extension IntegerProtocol {

    // @localization(🇩🇪DE) @crossReference(IntegerProtocol.inDigits(thousandsSeparator:))
    // #documentation(SDGCornerstone.WholeNumberProtocol.inZahlzeichen(tausendertrennzeichen:))
    /// Gibt die Zahl in Zahlzeichen zurück.
    ///
    /// - Parameters:
    ///     - tausendertrennzeichen: Das Tausendertrennzeichen. (Ein Leerzeichen, wenn nicht angegeben.)
    @inlinable public func inZahlzeichen(tausendertrennzeichen: Unicode.Skalar = " ") -> StrengeZeichenkette {
        return inDigits(thousandsSeparator: tausendertrennzeichen)
    }
    // @localization(🇨🇦EN) @crossReference(IntegerProtocol.inDigits(thousandsSeparator:))
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

    // @localization(🇩🇪DE) @crossReference(IntegerProtocol.inRomanNumerals(lowercase:))
    // #documentation(SDGCornerstone.WholeNumberProtocol.inRömischerZahlschrift(kleinbuchstaben:))
    /// Gibt die Zahl in römischer Zahlschrift zurück.
    ///
    /// - Parameters:
    ///     - kleinbuchstaben: Ob Kleinbuchstaben verwendet werden sollen. (`falsch` wenn nicht angegeben.)
    @inlinable public func inRömischerZahlschrift(kleinbuchstaben: Bool = falsch) -> StrengeZeichenkette {
        return inRomanNumerals(lowercase: kleinbuchstaben)
    }
    // @localization(🇨🇦EN) @crossReference(IntegerProtocol.inRomanNumerals(lowercase:))
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
