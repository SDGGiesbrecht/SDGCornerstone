/*
 TextConvertibleNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText

/// A number that can be converted to and from localized text representations.
public protocol TextConvertibleNumber: ExpressibleByStringLiteral, WholeArithmetic {

  // MARK: - Initialization

  /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
  ///
  /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
  ///
  /// - Parameters:
  ///     - representation: The string to interpret.
  ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
  ///     - radixCharacters: The set of characters that can mark the radix position.
  ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
  static func parse(
    fromRepresentation representation: StrictString,
    usingDigits digits: [[UnicodeScalar]],
    radixCharacters: Set<UnicodeScalar>,
    formattingSeparators: Set<UnicodeScalar>
  ) -> Result<Self, TextConvertibleNumberParseError>
}

extension TextConvertibleNumber {

  @inlinable internal init(forcing parse: () -> Result<Self, TextConvertibleNumberParseError>) {
    switch parse() {
    case .success(let value):
      self = value
    case .failure(let error):
      // @exempt(from: tests)
      preconditionFailure(error.unresolvedPresentableDescription())
    }
  }

  /// Creates an instance from a decimal representation.
  ///
  /// - Precondition: The representation must be valid. This initializer is intended for use with string literals. Dynamically acquired representations should instead be converted using the failable static `parse` methods instead.
  ///
  /// - Parameters:
  ///     - decimal: The decimal representation.
  @inlinable public init(_ decimal: StrictString) {
    self.init(forcing: { Self.parse(possibleDecimal: decimal) })
  }

  /// Creates an instance from a hexadecimal representation.
  ///
  /// - Precondition: The representation must be valid. This initializer is intended for use with string literals. Dynamically acquired representations should instead be converted using the failable static `parse` methods instead.
  ///
  /// - Parameters:
  ///     - hexadecimal: The hexadecimal representation.
  @inlinable public init(hexadecimal: StrictString) {
    self.init(forcing: { Self.parse(possibleHexadecimal: hexadecimal) })
  }

  /// Creates an instance from a octal representation.
  ///
  /// - Precondition: The representation must be valid. This initializer is intended for use with string literals. Dynamically acquired representations should instead be converted using the failable static `parse` methods instead.
  ///
  /// - Parameters:
  ///     - octal: The octal representation.
  @inlinable public init(octal: StrictString) {
    self.init(forcing: { Self.parse(possibleOctal: octal) })
  }

  /// Creates an instance from a binary representation.
  ///
  /// - Precondition: The representation must be valid. This initializer is intended for use with string literals. Dynamically acquired representations should instead be converted using the failable static `parse` methods instead.
  ///
  /// - Parameters:
  ///     - binary: The binary representation.
  @inlinable public init(binary: StrictString) {
    self.init(forcing: { Self.parse(possibleBinary: binary) })
  }

  /// Creates an instance from a decimal representation.
  ///
  /// - Parameters:
  ///     - decimal: The decimal representation.
  @inlinable public static func parse(
    possibleDecimal decimal: StrictString
  ) -> Result<Self, TextConvertibleNumberParseError> {
    return parse(decimal, base: 10)
  }

  /// Creates an instance from a hexadecimal representation.
  ///
  /// - Parameters:
  ///     - hexadecimal: The hexadecimal representation.
  @inlinable public static func parse(
    possibleHexadecimal hexadecimal: StrictString
  ) -> Result<Self, TextConvertibleNumberParseError> {
    return parse(hexadecimal, base: 16)
  }

  /// Creates an instance from a octal representation.
  ///
  /// - Parameters:
  ///     - octal: The octal representation.
  @inlinable public static func parse(
    possibleOctal octal: StrictString
  ) -> Result<Self, TextConvertibleNumberParseError> {
    return parse(octal, base: 8)
  }

  /// Creates an instance from a binary representation.
  ///
  /// - Parameters:
  ///     - binary: The binary representation.
  @inlinable public static func parse(
    possibleBinary binary: StrictString
  ) -> Result<Self, TextConvertibleNumberParseError> {
    return parse(binary, base: 2)
  }

  /// Creates an instance by interpreting `representation` in a particular base.
  ///
  /// - Precondition: `2 ≤ base ≤ 16`, `base` ∈ Z
  ///
  /// - Parameters:
  ///     - representation: The string to interpret.
  ///     - base: The base of the number system.
  @inlinable public static func parse(
    _ representation: StrictString,
    base: Int
  ) -> Result<Self, TextConvertibleNumberParseError> {

    assert(
      base.isIntegral ∧ 2 ≤ base ∧ base ≤ 16,
      UserFacing<StrictString, _APILocalization>(  // @exempt(from: tests)
        { localization in
          switch localization {
          case .englishCanada:
            return
              "Base \(base.inDigits()) is not supported. The base must be an integer between 2 and 16 inclusive."
          }
        })
    )

    let digits: [[UnicodeScalar]] = [
      //    arb  pes  hi   bn   ta   my   km   th   lo
      ["0", "٠", "۰", "०", "০", "௦", "၀", "០", "๐", "໐"],
      ["1", "١", "۱", "१", "১", "௧", "၁", "១", "๑", "໑"],
      ["2", "٢", "۲", "२", "২", "௨", "၂", "២", "๒", "໒"],
      ["3", "٣", "۳", "३", "৩", "௩", "၃", "៣", "๓", "໓"],
      ["4", "٤", "۴", "४", "৪", "௪", "၄", "៤", "๔", "໔"],
      ["5", "٥", "۵", "५", "৫", "௫", "၅", "៥", "๕", "໕"],
      ["6", "٦", "۶", "६", "৬", "௬", "၆", "៦", "๖", "໖"],
      ["7", "٧", "۷", "७", "৭", "௭", "၇", "៧", "๗", "໗"],
      ["8", "٨", "۸", "८", "৮", "௮", "၈", "៨", "๘", "໘"],
      ["9", "٩", "۹", "९", "৯", "௯", "၉", "៩", "๙", "໙"],
      ["A", "a"],
      ["B", "b"],
      ["C", "c"],
      ["D", "d"],
      ["E", "e"],
      ["F", "f"]
    ]

    let selectedDigits = [[UnicodeScalar]](digits[..<base])

    return parse(
      fromRepresentation: representation,
      usingDigits: selectedDigits,
      radixCharacters: [",", ".", "٫"],
      formattingSeparators: [" ", "٬"]
    )
  }

  @inlinable internal static func assertNFKD(
    digits: [[UnicodeScalar]],
    radixCharacters: Set<UnicodeScalar>,
    formattingSeparators: Set<UnicodeScalar>
  ) {

    let assertNFKD = { () -> [UnicodeScalar] in
      var scalars = digits.reduce([]) { $0 + $1 }
      scalars += radixCharacters
      scalars += formattingSeparators

      var set: Set<UnicodeScalar> = []
      for scalar in scalars where scalar.isDecomposableInNFKD {
        set.insert(scalar)
      }

      return set.sorted()
    }
    assert(
      assertNFKD().isEmpty,
      UserFacing<StrictString, _APILocalization>(
        { localization in  // @exempt(from: tests)
          let scalars: [StrictString] = assertNFKD().map { scalar in
            return "\(scalar.visibleRepresentation) \(scalar.hexadecimalCode)"
          }
          switch localization {
          case .englishCanada:
            return "Some scalars are not in NFKD: \(scalars.joined(separator: ", "))"
          }
        })
    )
  }

  @inlinable public static func parse(
    fromRepresentation representation: StrictString,
    usingDigits digits: [[UnicodeScalar]],
    radixCharacters: Set<UnicodeScalar>,
    formattingSeparators: Set<UnicodeScalar>
  ) -> Result<Self, TextConvertibleNumberParseError> {

    Self.assertNFKD(
      digits: digits,
      radixCharacters: radixCharacters,
      formattingSeparators: formattingSeparators
    )

    return parse(
      wholeNumber: representation,
      base: getBase(digits),
      digits: getMapping(digits),
      formattingSeparators: formattingSeparators
    )
  }

  @inlinable internal static func getBase(_ digits: [[UnicodeScalar]]) -> Self {
    return Self(UInt(digits.count))
  }

  @inlinable internal static func getMapping(_ digits: [[UnicodeScalar]]) -> [UnicodeScalar: Self] {
    var digitMapping: [UnicodeScalar: Self] = [:]
    for index in digits.indices {
      let characters = digits[index]

      let value = Self(UInt(index))
      for character in characters {
        digitMapping[character] = value
      }
    }
    return digitMapping
  }

  @inlinable internal static func parse(
    wholeNumber representation: StrictString,
    base: Self,
    digits digitMapping: [UnicodeScalar: Self],
    formattingSeparators: Set<UnicodeScalar>
  ) -> Result<Self, TextConvertibleNumberParseError> {

    var value: Self = 0
    var position: Self = 0
    for character in representation.reversed() {
      if let digit = digitMapping[character], digit < base {
        value += (base ↑ position) × digit
        position += 1 as Self
      } else {
        if character ∉ formattingSeparators {
          return .failure(
            TextConvertibleNumberParseError.invalidDigit(character, entireString: representation)
          )
        }
      }
    }
    return .success(value)
  }

  // MARK: - ExpressibleByStringLiteral

  @inlinable public init(stringLiteral: String) {
    self.init(StrictString(stringLiteral))
  }
}

extension TextConvertibleNumber where Self: IntegralArithmetic {

  @inlinable public static func parse(
    fromRepresentation representation: StrictString,
    usingDigits digits: [[UnicodeScalar]],
    radixCharacters: Set<UnicodeScalar>,
    formattingSeparators: Set<UnicodeScalar>
  ) -> Result<Self, TextConvertibleNumberParseError> {

    Self.assertNFKD(
      digits: digits,
      radixCharacters: radixCharacters,
      formattingSeparators: formattingSeparators
    )

    return parse(
      integer: representation,
      base: getBase(digits),
      digits: getMapping(digits),
      formattingSeparators: formattingSeparators
    )
  }

  @inlinable internal static func parse(
    integer representation: StrictString,
    base: Self,
    digits digitMapping: [UnicodeScalar: Self],
    formattingSeparators: Set<UnicodeScalar>
  ) -> Result<Self, TextConvertibleNumberParseError> {

    var representation = representation

    let negative = representation.scalars.first == "−"
    if negative {
      representation.scalars.removeFirst()
    }

    return parse(
      wholeNumber: representation,
      base: base,
      digits: digitMapping,
      formattingSeparators: formattingSeparators
    ).map { value in

      if negative {
        return −value
      } else {
        return value
      }
    }
  }
}

extension TextConvertibleNumber where Self: RationalArithmetic {

  @inlinable public static func parse(
    fromRepresentation representation: StrictString,
    usingDigits digits: [[UnicodeScalar]],
    radixCharacters: Set<UnicodeScalar>,
    formattingSeparators: Set<UnicodeScalar>
  ) -> Result<Self, TextConvertibleNumberParseError> {
    Self.assertNFKD(
      digits: digits,
      radixCharacters: radixCharacters,
      formattingSeparators: formattingSeparators
    )

    let base = Self.getBase(digits)
    let digitMapping = Self.getMapping(digits)

    var radixLocation: StrictString.Index?
    for index in representation.indices where representation[index] ∈ radixCharacters {
      radixLocation = index
      break
    }

    let wholeString: StrictString
    let numeratorString: StrictString
    if let radix = radixLocation {
      wholeString = StrictString(representation[..<radix])
      numeratorString = StrictString(representation[representation.index(after: radix)...])
    } else {
      wholeString = representation
      numeratorString = ""
    }

    func flattenToZeroes(_ value: StrictString) -> StrictString {
      return StrictString(value.map({ digitMapping[$0] ≠ nil ? "0" : $0 }))
    }

    func component(_ value: StrictString) -> Result<Self, TextConvertibleNumberParseError> {
      return parse(
        integer: value,
        base: base,
        digits: digitMapping,
        formattingSeparators: formattingSeparators
      )
    }

    return component(wholeString).flatMap { whole in
      return component(numeratorString).flatMap { numerator in
        return component("1" + flattenToZeroes(numeratorString)).flatMap { denominator in
          return .success(whole + numerator ÷ denominator)
        }
      }
    }
  }
}

/// A type that conforms to `Codable` through its `TextConvertibleNumber` interface.
public protocol CodableViaTextConvertibleNumber: TextConvertibleNumber {}

extension CodableViaTextConvertibleNumber {

  public init(from decoder: Decoder) throws {
    try self.init(
      from: decoder,
      via: StrictString.self,
      convert: { try Self.parse(possibleDecimal: $0).get() }
    )
  }
}

extension CodableViaTextConvertibleNumber where Self: IntegerProtocol {

  public func encode(to encoder: Encoder) throws {
    try encode(to: encoder, via: inDigits())
  }
}

extension CodableViaTextConvertibleNumber where Self: WholeNumberProtocol {

  public func encode(to encoder: Encoder) throws {
    try encode(to: encoder, via: inDigits())
  }
}
