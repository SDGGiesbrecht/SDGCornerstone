/*
 Integer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

// #example(1, wholeNumberLiterals)
/// An arbitrary‐precision integer.
///
/// ```swift
/// let million: WholeNumber = 1_000_000
/// let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
/// let yobiMultiplier = WholeNumber(
///   binary:
///     "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000"
/// )
/// ```
public struct Integer: Addable, CodableViaTextConvertibleNumber, Comparable, Equatable, Hashable,
  IntegerProtocol, IntegralArithmetic, Negatable, PointProtocol, Subtractable,
  TextConvertibleNumber, WholeArithmetic & _WholeArithmeticRandomness, TextualPlaygroundDisplay
{

  // MARK: - Initialization

  private init(magnitude: WholeNumber, isNegative: Bool) {
    self.definition = Definition(magnitude: magnitude, isNegative: isNegative)
  }

  /// Creates an instance from a whole number.
  public init(_ wholeNumber: WholeNumber) {
    self.init(magnitude: wholeNumber, isNegative: false)
  }

  // MARK: - Properties

  private struct Definition: Equatable, Hashable {
    fileprivate var magnitude: WholeNumber
    fileprivate var isNegative: Bool
  }
  private var unsafeDefinition = Definition(magnitude: 0, isNegative: false)
  private var definition: Definition {
    get {
      return unsafeDefinition
    }
    set {
      unsafeDefinition = newValue

      // Normalize

      if unsafeDefinition.isNegative ∧ unsafeDefinition.magnitude == 0 {
        unsafeDefinition.isNegative = false
      }
    }
  }

  internal private(set) var wholeMagnitude: WholeNumber {
    get {
      return definition.magnitude
    }
    set {
      definition.magnitude = newValue
    }
  }

  // NumericAdditiveArithmetic
  public private(set) var isNegative: Bool {
    get {
      return definition.isNegative
    }
    set {
      definition.isNegative = newValue
    }
  }

  // MARK: - Addable

  public static func += (precedingValue: inout Integer, followingValue: Integer) {

    if precedingValue.isNegative == followingValue.isNegative {
      // Moving away from zero.
      precedingValue.wholeMagnitude += followingValue.wholeMagnitude
    } else {
      // Approaching zero...
      if precedingValue.wholeMagnitude ≥ followingValue.wholeMagnitude {
        // ...but stopping short of crossing it.
        precedingValue.wholeMagnitude −= followingValue.wholeMagnitude
      } else {
        // ...and crossing it.
        precedingValue.wholeMagnitude = followingValue.wholeMagnitude
          − precedingValue.wholeMagnitude
        precedingValue.isNegative.toggle()
      }
    }
  }

  // MARK: - Comparable

  public static func < (precedingValue: Integer, followingValue: Integer) -> Bool {
    if precedingValue.isNegative {
      if followingValue.isNegative {
        // − vs −
        return precedingValue.wholeMagnitude > followingValue.wholeMagnitude
      } else {
        // − vs +/0
        return true
      }
    } else {
      if followingValue.isNegative {
        // +/0 vs −
        return false
      } else {
        // +/0 vs +/0
        return precedingValue.wholeMagnitude < followingValue.wholeMagnitude
      }
    }
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada, .deutschDeutschland,
          .françaisFrance, .ελληνικάΕλλάδα, .עברית־ישראל:
          return self.inDigits()
        }
      }).resolved()
    )
  }

  // MARK: - Equatable

  public static func == (precedingValue: Integer, followingValue: Integer) -> Bool {
    return precedingValue.definition == followingValue.definition
  }

  // MARK: - IntegralArithmetic

  public init(_ int: IntMax) {
    let magnitude: UIntMax
    if int == IntMax.min {  // |int| would overflow.
      magnitude = UIntMax(|(int + 1)|) + 1
    } else {
      magnitude = UIntMax(|int|)
    }
    wholeMagnitude = WholeNumber(magnitude)
    isNegative = int.isNegative
  }

  // MARK: - Negatable

  public mutating func negate() {
    isNegative.toggle()
  }

  // MARK: - Numeric

  public init?<T>(exactly source: T) where T: BinaryInteger {
    if let whole = WholeNumber(exactly: source) {
      self.init(whole)
      return
    } else if let integer = IntMax(exactly: source) {
      self.init(integer)
      return
    } else {
      unreachable()
    }
  }

  // MARK: - PointProtocol

  public typealias Vector = Integer

  // MARK: - Subtractable

  public static func −= (precedingValue: inout Integer, followingValue: Integer) {
    precedingValue += −followingValue
  }

  // MARK: - WholeArithmetic

  public init(_ uInt: UIntMax) {
    self.init(WholeNumber(uInt))
  }

  public static func ×= (precedingValue: inout Integer, followingValue: Integer) {
    precedingValue.wholeMagnitude ×= followingValue.wholeMagnitude
    if precedingValue.isNegative == followingValue.isNegative {
      precedingValue.isNegative = false
    } else {
      precedingValue.isNegative = true
    }
  }

  public mutating func divideAccordingToEuclid(by divisor: Integer) {

    let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

    let needsToWrapToPrevious = negative ∧ ¬wholeMagnitude.isDivisible(by: divisor.wholeMagnitude)
    // Wrap to previous if negative (ignoring when exactly even)

    wholeMagnitude.divideAccordingToEuclid(by: divisor.wholeMagnitude)
    isNegative = negative

    if needsToWrapToPrevious {
      self −= 1
    }
  }

  public static func random<R>(in range: ClosedRange<Integer>, using generator: inout R) -> Integer
  where R: RandomNumberGenerator {
    if range.lowerBound.isWhole {
      let wholeRange: ClosedRange<WholeNumber> =
        range.lowerBound.wholeMagnitude...range.upperBound.wholeMagnitude
      let whole = WholeNumber.random(in: wholeRange, using: &generator)
      return Integer(whole)
    } else {
      let span = range.upperBound − range.lowerBound
      let wholeRange: ClosedRange<WholeNumber> = 0...span.wholeMagnitude
      let whole = WholeNumber.random(in: wholeRange, using: &generator)
      return range.lowerBound + Integer(whole)
    }
  }
}
