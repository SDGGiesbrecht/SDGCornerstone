/*
 WholeNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents whole numbers.
public protocol WholeNumberProtocol: WholeArithmetic {}

extension WholeNumberProtocol {

  @inlinable public static func ↑= (precedingValue: inout Self, followingValue: Self) {
    precedingValue.raiseWholeNumberToThePowerOf(wholeNumber: followingValue)
  }

  @inlinable public var isWhole: Bool {
    return true
  }

  @inlinable public var isIntegral: Bool {
    return true
  }

  @inlinable public mutating func round(_ rule: RoundingRule) {
    // self = self
  }

  // MARK: - NumericAdditiveArithmetic

  @inlinable public var isNegative: Bool {
    return false
  }

  @inlinable public var isNonNegative: Bool {
    return true
  }

  @inlinable public mutating func formAbsoluteValue() {
    // self = self
  }
}
