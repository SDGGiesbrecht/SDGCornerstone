/*
 TextConvertibleNumberParseError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText

/// An error that occurs while parsing a number from a string.
public enum TextConvertibleNumberParseError: PresentableError {

  /// A character is present which is not a valid digit.
  case invalidDigit(UnicodeScalar, entireString: StrictString)

  // MARK: - PresentableError

  @usableFromInline internal func unresolvedPresentableDescription() -> UserFacing<
    StrictString, _InterfaceLocalization
  > {
    switch self {
    case .invalidDigit(let scalar, let entireString):
      return UserFacing<StrictString, _InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return StrictString(
            "‘\(entireString)’ could not be parsed as a number because ‘\(scalar.visibleRepresentation)’ is not a valid digit."
          )
        case .englishUnitedStates, .englishCanada:
          return
            "“\(entireString)” could not be parsed as a number because “\(scalar.visibleRepresentation)” is not a valid digit."
        case .deutschDeutschland:
          return
            "„\(entireString)“ konnte nicht als Zahl zerteilt werden, weil „\(scalar.visibleRepresentation)“ keine erkannte Ziffer ist."
        }
      })
    }
  }
  public func presentableDescription() -> StrictString {
    return unresolvedPresentableDescription().resolved()
  }
}
