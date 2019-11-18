/*
 IntegralArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

extension IntegralArithmetic {

  internal func integralDigits(thousandsSeparator: UnicodeScalar) -> StrictString {
    var digits = wholeDigits(thousandsSeparator: thousandsSeparator)
    if self.isNegative {
      digits.prepend("−")
    }
    return digits
  }
}
