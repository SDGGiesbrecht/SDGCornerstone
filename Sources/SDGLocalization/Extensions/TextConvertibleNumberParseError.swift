/*
 TextConvertibleNumberParseError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An error that occurs while parsing a number from a string.
public enum TextConvertibleNumberParseError : PresentableError {

    /// A character is present which is not a valid digit.
    case invalidDigit(UnicodeScalar, entireString: StrictString)

    // MARK: - PresentableError

    // [_Inherit Documentation: SDGCornerstone.PresentableError.presentableDescription()_]
    /// Returns a localized description of the error.
    public func presentableDescription() -> StrictString {
        switch self {
        case .invalidDigit(let scalar, let entireString):
            return UserFacing<StrictString, _InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom:
                    return StrictString("‘\(entireString)’ could not be parsed as a number because ‘\(scalar.visibleRepresentation)’ is not a valid digit.")
                case .englishUnitedStates, .englishCanada:
                    return StrictString("“\(entireString)” could not be parsed as a number because “\(scalar.visibleRepresentation)” is not a valid digit.")
                }
            }).resolved()
        }
    }
}
