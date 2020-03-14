/*
 RationalNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText

extension RationalNumberProtocol {

  // MARK: - Text Representations

  private func digitsOnly(_ number: StrictString) -> Bool {
    // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
    #if !canImport(Foundation)
      return false
    #else
      return ¬number.contains(where: { $0 ∉ CharacterSet.decimalDigits ∪ ["−"] })
    #endif
  }

  private func parenthesizeIfNecessary(_ number: inout StrictString) {
    if ¬digitsOnly(number) {
      number.prepend("(")
      number.append(")")
    }
  }

  /// Returns the number as a simple fraction. (“−19⁄2”, “6”, “(50 001)⁄(10 000)”,  etc.)
  ///
  /// - Parameters:
  ///     - thousandsSeparator: Optional. An older thousands separator to use instead of the modern, internationally standard space.
  public func asSimpleFraction(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    let (numerator, denominator) = reducedSimpleFraction()

    if denominator == 1 {
      return numerator.inDigits(thousandsSeparator: thousandsSeparator)
    } else {

      var a = numerator.inDigits(thousandsSeparator: thousandsSeparator)
      var b = denominator.inDigits(thousandsSeparator: thousandsSeparator)

      parenthesizeIfNecessary(&a)
      parenthesizeIfNecessary(&b)

      return a + "⁄" + b
    }
  }

  /// Returns the number as a mixed fraction. (“−9 1⁄2”, “6”, “5 + 1⁄(10 000)”,  etc.)
  ///
  /// - Parameters:
  ///     - thousandsSeparator: Optional. An older thousands separator to use instead of the modern, internationally standard space.
  public func asMixedFraction(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    let wholeString = integralDigits(thousandsSeparator: thousandsSeparator)

    let fraction = (|self|).mod(1)
    if fraction == 0 {
      return wholeString
    } else {

      let fractionString = fraction.asSimpleFraction(thousandsSeparator: thousandsSeparator)
      if ¬fractionString.contains("(") {
        return wholeString + " " + fractionString
      } else {
        return wholeString + " + " + fractionString
      }
    }
  }

  /// Returns the number as a ratio. (“−19 ∶ 2”, “6 ∶ 1”, “50 001 ∶ 10 000”,  etc.)
  ///
  /// - Parameters:
  ///     - thousandsSeparator: Optional. An older thousands separator to use instead of the modern, internationally standard space.
  public func asRatio(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    let (numerator, denominator) = reducedSimpleFraction()
    return numerator.integralDigits(thousandsSeparator: thousandsSeparator) + " ∶ "
      + denominator.integralDigits(thousandsSeparator: thousandsSeparator)
  }
}
