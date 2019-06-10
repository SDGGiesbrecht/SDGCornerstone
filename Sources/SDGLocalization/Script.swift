/*
 Script.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

internal enum Script : String {

    // MARK: - Cases

    case 简化字 = "Hans"
    case 正體字 = "Hant"

    // MARK: - Description

    func isolatedEnglishName() -> StrictString {
        switch self {
        case .简化字:
            return "Simplified Chinese"
        case .正體字:
            return "Traditional Chinese"
        }
    }

    internal func localizedIsolatedName() -> StrictString {
        return UserFacing<StrictString, _InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return self.isolatedEnglishName()
            }
        }).resolved()
    }
}
