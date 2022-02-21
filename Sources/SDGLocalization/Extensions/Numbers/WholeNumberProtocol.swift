/*
 WholeNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText

extension _NumericIfNotInherited where Self: WholeNumberProtocol {

  // @localization(🇩🇪DE) @crossReference(WholeNumberProtcol.inDigits(thousandsSeparator:))
  // @documentation(SDGCornerstone.WholeNumberProtocol.inZahlzeichen(tausendertrennzeichen:))
  /// Gibt die Zahl in Zahlzeichen zurück.
  ///
  /// - Parameters:
  ///     - tausendertrennzeichen: Das Tausendertrennzeichen. (Ein Leerzeichen, wenn nicht angegeben.)
  @inlinable public func inZahlzeichen(
    tausendertrennzeichen: Unicode.Skalar = " "
  ) -> StrengeZeichenkette {
    return inDigits(thousandsSeparator: tausendertrennzeichen)
  }
  // @localization(🇨🇦EN) @crossReference(WholeNumberProtcol.inDigits(thousandsSeparator:))
  // @documentation(SDGCornerstone.WholeNumberProtocol.inDigits(thousandsSeparator:))
  /// Returns the number in digits.
  ///
  /// - Parameters:
  ///     - thousandsSeparator: The character to use as a thousands separator. (Space by default.)
  public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    return wholeDigits(thousandsSeparator: thousandsSeparator)
  }

  // @documentation(SDGCornerstone.WholeNumberProtocol.abbreviatedEnglishOrdinal())
  /// Returns the ordinal in its abbreviated English form.
  ///
  /// i.e. “1st”, “2nd”, “3rd”...
  public func abbreviatedEnglishOrdinal() -> SemanticMarkup {
    return generateAbbreviatedEnglishOrdinal()
  }

  // @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
  // @documentation(SDGCornerstone.WholeNumberProtocol.abgekürzteDeutscheOrdnungszahl())
  /// Gibt die Ordnungszahl in deutscher abgekürzter Form zurück.
  ///
  /// d. h. „1.“, „2.“, „3.“ ...
  public func abgekürzteDeutscheOrdnungszahl() -> StrictString {
    return abgekürzteDeutscheOrdnungszahlErzeugen()
  }

  // @localization(🇫🇷FR) @notLocalized(🇨🇦EN)
  // @documentation(SDGCornerstone.WholeNumberProtocol.ordinalFrançaisAbrégé())
  /// Renvoie l’ordinal dans la forme abrégée française.
  ///
  /// c.‐à‐d. « 1er », « 2e », « 3e »...
  public func ordinalFrançaisAbrégé(
    genre: GenreGrammatical,
    nombre: GrammaticalNumber
  ) -> SemanticMarkup {
    return générerOrdinalFrançaisAbrégé(genre: genre, nombre: nombre)
  }

  // @localization(🇩🇪DE) @crossReference(WholeNumberProtcol.inRomanNumerals(lowercase:))
  // @documentation(SDGCornerstone.WholeNumberProtocol.inRömischerZahlschrift(kleinbuchstaben:))
  /// Gibt die Zahl in römischer Zahlschrift zurück.
  ///
  /// - Parameters:
  ///     - kleinbuchstaben: Ob Kleinbuchstaben verwendet werden sollen. (`falsch` wenn nicht angegeben.)
  @inlinable public func inRömischerZahlschrift(
    kleinbuchstaben: Bool = falsch
  ) -> StrengeZeichenkette {
    return inRomanNumerals(lowercase: kleinbuchstaben)
  }
  // @localization(🇨🇦EN) @crossReference(WholeNumberProtcol.inRomanNumerals(lowercase:))
  // @documentation(SDGCornerstone.WholeNumberProtocol.inRomanNumerals(lowercase:))
  /// Returns the number in roman numerals.
  ///
  /// - Parameters:
  ///     - lowercase: Whether the numeral should be in lowercase. (`false` by default.)
  public func inRomanNumerals(lowercase: Bool = false) -> StrictString {
    return romanNumerals(lowercase: lowercase)
  }

  // @localization(🇬🇷ΕΛ) @notLocalized(🇨🇦EN)
  // @documentation(SDGCornerstone.WholeNumberProtocol.σεΕλληνικούςΑριθμούς())
  /// Επιστρέφει τον αριθμός σε ελληνικούς αριθμούς.
  public func σεΕλληνικούςΑριθμούς(
    μικράΓράμματα: Bool = false,
    κεραία: Bool = true
  ) -> StrictString {
    return ελληνικοίΑριθμοί(μικράΓράμματα: μικράΓράμματα, κεραία: κεραία)
  }

  // @localization(🇮🇱עב) @notLocalized(🇨🇦EN)
  // @documentation(SDGCornerstone.WholeNumberProtocol.בספרות־עבריות())
  /// משיבה את המספר בספרות עבריות.
  public func בספרות־עבריות(גרשיים: Bool = true) -> StrictString {
    return ספרות־עבריות(גרשיים: גרשיים)
  }
}
