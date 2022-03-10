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
}

extension Int64: TextConvertibleNumber {}
extension Int32: TextConvertibleNumber {}
extension Int16: TextConvertibleNumber {}
extension Int8: TextConvertibleNumber {}
