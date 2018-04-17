/*
 Month.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCornerstoneLocalizations

/// A calendar compenent representing a month of the year.
public protocol Month : TextualPlaygroundDisplay {

    // [_Define Documentation: SDGCornerstone.Month.inEnglish()_]
    /// Returns the English name.
    func inEnglish() -> StrictString
}

extension Month {

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    public var description: String {
        return String(UserFacingText({ (localization: InterfaceLocalization) in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.inEnglish()
            }
        }).resolved())
    }
}
