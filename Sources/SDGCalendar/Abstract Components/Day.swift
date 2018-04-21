/*
 Day.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGCornerstoneLocalizations

/// A calendar compenent representing a day of the month.
public protocol Day : ConsistentlyOrderedCalendarComponent, TextualPlaygroundDisplay
where Vector : IntegerProtocol {

}

extension Day {

    // MARK: - Text Representations

    /// Returns the day in English digits. (“1”, “2”, “3”, etc.)
    @_inlineable public func inEnglishDigits() -> StrictString {
        return ordinal.inDigits()
    }

    @_inlineable @_versioned internal func inDeutschenZiffern() -> StrictString {
        return ordinal._verkürzteDeutscheOrdnungszahl()
    }

    @_inlineable @_versioned internal func enChiffresFrançais() -> SemanticMarkup {
        if ordinal == 1 {
            return ordinal._ordinalFrançaisAbrégé(genre: .masculin, nombre: .singular)
        } else {
            return SemanticMarkup(ordinal.inDigits())
        }
    }

    @_inlineable @_versioned internal func σεΕλληνικάΨηφία() -> StrictString {
        return ordinal.inDigits()
    }

    @_inlineable @_versioned internal func בעברית־בספרות() -> StrictString {
        return ordinal.inDigits()
    }

    public func localizedDescription() -> SemanticMarkup {
        return UserFacing<SemanticMarkup, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return SemanticMarkup(self.inEnglishDigits())
            case .deutschDeutschland:
                return SemanticMarkup(self.inDeutschenZiffern())
            case .françaisFrance:
                return self.enChiffresFrançais()
            case .ελληνικάΕλλάδα:
                return SemanticMarkup(self.σεΕλληνικάΨηφία())
            case .עברית־ישראל:
                return SemanticMarkup(self.בעברית־בספרות())
            }
        }).resolved()
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription_]
    /// Returns the custom playground description for this instance.
    @_inlineable public var playgroundDescription: Any {
        return localizedDescription().richText(font: Font.systemFont(ofSize: Font.systemFontSize))
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(localizedDescription().rawTextApproximation())
    }
}
