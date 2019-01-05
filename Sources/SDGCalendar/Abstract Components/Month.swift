/*
 Month.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A calendar compenent representing a month of the year.
public protocol Month : TextualPlaygroundDisplay {

    // @documentation(SDGCornerstone.Month.inEnglish())
    /// Returns the English name.
    func inEnglish() -> StrictString

    func _aufDeutsch() -> StrictString
    func _enFrançais(_ majuscules: Casing) -> StrictString
    func _σεΕλληνικά(_ πτώση: _ΓραμματικήΠτώση) -> StrictString
    func _בעברית() -> StrictString
}

extension Month {

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacing<StrictString, FormatLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inEnglish()
            case .deutschDeutschland:
                return self._aufDeutsch()
            case .françaisFrance:
                return self._enFrançais(.sentenceMedial)
            case .ελληνικάΕλλάδα:
                return self._σεΕλληνικά(.ονομαστική)
            case .עברית־ישראל:
                return self._בעברית()
            }
        }).resolved())
    }
}
