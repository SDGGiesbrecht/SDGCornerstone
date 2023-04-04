/*
 RationalNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents rational numbers.
public protocol RationalNumberProtocol: RationalArithmetic {

  /// The type to use for the numerator and denominator.
  associatedtype Integer: IntegerProtocol

  /// Returns the numerator and denominator of the number as a reduced simple fraction.
  func reducedSimpleFraction() -> (numerator: Integer, denominator: Integer)
}

extension RationalNumberProtocol {

  @inlinable public static func ↑= (precedingValue: inout Self, followingValue: Self) {
    precedingValue.raiseRationalNumberToThePowerOf(rationalNumber: followingValue)
  }
}
