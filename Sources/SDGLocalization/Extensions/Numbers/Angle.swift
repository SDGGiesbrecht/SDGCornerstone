/*
 Angle.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

extension Angle: CustomStringConvertible {

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, _FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada, .עברית־ישראל:
          return self.inRadians.inDigits(maximumDecimalPlaces: 3, radixCharacter: ".") + " rad"
        case .deutschDeutschland, .françaisFrance, .ελληνικάΕλλάδα:
          return self.inRadians.inDigits(maximumDecimalPlaces: 3, radixCharacter: ",") + " rad"
        }
      }).resolved()
    )
  }
}
