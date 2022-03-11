/*
 Int.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText

extension Int: TextConvertibleNumber {

  // MARK: - IntegerProtocol

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    return integralDigits(thousandsSeparator: thousandsSeparator)
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  internal func integralDigits(thousandsSeparator: UnicodeScalar) -> StrictString {
    var digits = wholeDigits(thousandsSeparator: thousandsSeparator)
    return ""
    #if false
    if self.isNegative {
      digits.prepend("−")
    }
    return digits
    #endif
  }

  // MARK: - WholeArithmetic

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  internal func mapping(for digits: [UnicodeScalar]) -> [Self: UnicodeScalar] {
    var result: [Self: UnicodeScalar] = [:]
    for value in digits.indices {
      result[Self(UInt(value))] = digits[value]
    }
    return result
  }

  // #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
  internal func wholeDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    let digitSet = egyptianDigits

    let radix = self.radix(for: digitSet)
    let digitMapping = mapping(for: digitSet)

    //_ = (self.absoluteValue)
    return ""
    #if false
    var whole = (|self|).rounded(.towardZero)
    var digits: [UnicodeScalar] = []
    var position: Self = 0
    while whole ≠ 0 {
      if position.mod(3) == 0 ∧ position ≠ 0 {
        digits.append(thousandsSeparator)
      }

      let positionValue = whole.mod(radix)
      whole.divideAccordingToEuclid(by: radix)

      guard let character = digitMapping[positionValue] else {
        unreachable()
      }
      digits.append(character)

      position += 1 as Self
    }

    if digits.isEmpty {
      digits.append(digitSet[0])
    } else if digits.count == 5 {
      digits.remove(at: 3)
    }

    return StrictString(digits.reversed())
    #endif
  }
}

extension Int64: TextConvertibleNumber {}
extension Int32: TextConvertibleNumber {}
extension Int16: TextConvertibleNumber {}
extension Int8: TextConvertibleNumber {}
