/*
 Year.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A calendar compenent representing a year.
public protocol Year : TextualPlaygroundDisplay {

    // [_Define Documentation: SDGCornerstone.Year.inEnglishDigits()_]
    /// Returns the year in English digits.
    func inEnglishDigits() -> StrictString

    /// :nodoc:
    func _inDeutschenZiffern() -> StrictString

    /// :nodoc:
    func _enChiffresFrançais() -> StrictString

    /// :nodoc:
    func _σεΕλληνικάΨηφία() -> StrictString

    /// :nodoc:
    func _בעברית־בספרות() -> StrictString
}

extension Year {

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inEnglishDigits()
            case .deutschDeutschland:
                return self._inDeutschenZiffern()
            case .françaisFrance:
                return self._enChiffresFrançais()
            case .ελληνικάΕλλάδα:
                return self._σεΕλληνικάΨηφία()
            case .עברית־ישראל:
                return self._בעברית־בספרות()
            }
        }).resolved())
    }
}
