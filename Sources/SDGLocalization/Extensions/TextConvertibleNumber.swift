/*
 TextConvertibleNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections

/// A number that can be converted to and from localized text representations.
public protocol TextConvertibleNumber : ExpressibleByStringLiteral, WholeArithmetic {

    // MARK: - Initialization

    // @documentation(SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:))
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    init(fromRepresentation representation: StrictString, usingDigits digits:  [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws
}

extension TextConvertibleNumber {

    @_inlineable @_versioned internal init(forceParsing parse: () throws -> Self) {
        do {
            self = try parse()
        } catch let error as TextConvertibleNumberParseError {
            // @exempt(from: tests)
            switch error {
            case .invalidDigit(let scalar):
                preconditionFailure(UserFacing<StrictString, _APILocalization>({ localization in
                    switch localization {
                    case .englishCanada: // @exempt(from: tests)
                        return StrictString("\(scalar) is not a valid digit.")
                    }
                }))
            }
        } catch {
            unreachable()
        }
    }

    /// Creates an instance from a decimal representation.
    ///
    /// - Parameters:
    ///     - decimal: The decimal representation.
    @_inlineable public init(_ decimal: StrictString) {
        self.init(forceParsing: { try Self(possibleDecimal: decimal) })
    }

    /// Creates an instance from a hexadecimal representation.
    ///
    /// - Parameters:
    ///     - hexadecimal: The hexadecimal representation.
    @_inlineable public init(hexadecimal: StrictString) {
        self.init(forceParsing: { try Self(possibleHexadecimal: hexadecimal) })
    }

    /// Creates an instance from a octal representation.
    ///
    /// - Parameters:
    ///     - octal: The octal representation.
    @_inlineable public init(octal: StrictString) {
        self.init(forceParsing: { try Self(possibleOctal: octal) })
    }

    /// Creates an instance from a binary representation.
    ///
    /// - Parameters:
    ///     - binary: The binary representation.
    @_inlineable public init(binary: StrictString) {
        self.init(forceParsing: { try Self(possibleBinary: binary) })
    }

    /// Creates an instance from a decimal representation.
    ///
    /// - Parameters:
    ///     - decimal: The decimal representation.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(possibleDecimal decimal: StrictString) throws {
        try self.init(decimal, base: 10)
    }

    /// Creates an instance from a hexadecimal representation.
    ///
    /// - Parameters:
    ///     - hexadecimal: The hexadecimal representation.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(possibleHexadecimal hexadecimal: StrictString) throws {
        try self.init(hexadecimal, base: 16)
    }

    /// Creates an instance from a octal representation.
    ///
    /// - Parameters:
    ///     - octal: The octal representation.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(possibleOctal octal: StrictString) throws {
        try self.init(octal, base: 8)
    }

    /// Creates an instance from a binary representation.
    ///
    /// - Parameters:
    ///     - binary: The binary representation.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(possibleBinary binary: StrictString) throws {
        try self.init(binary, base: 2)
    }

    /// Creates an instance by interpreting `representation` in a particular base.
    ///
    /// - Precondition: `2 ≤ base ≤ 16`, `base` ∈ Z
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - base: The base of the number system.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(_ representation: StrictString, base: Int) throws {
        assert(base.isIntegral ∧ 2 ≤ base ∧ base ≤ 16, UserFacing<StrictString, _APILocalization>({ localization in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return StrictString("Base \(base.inDigits()) is not supported. The base must be an integer between 2 and 16 inclusive.")
            }
        }))

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

        let selectedDigits = [[UnicodeScalar]](digits[0 ..< base])

        try self.init(fromRepresentation: representation, usingDigits: selectedDigits, radixCharacters: [",", ".", "٫"], formattingSeparators: [" ", "٬"])
    }

    @_inlineable @_versioned internal static func assertNFKD(digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) {

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
        assert(assertNFKD().isEmpty, UserFacing<StrictString, _APILocalization>({ localization in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return StrictString("Some scalars are not in NFKD: \(assertNFKD().map({ $0.visibleRepresentation }))")
            }
        }))
    }

    // #documentation(SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:))
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(fromRepresentation representation: StrictString, usingDigits digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws {
        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

        try self.init(whole: representation, base: Self.getBase(digits), digits: Self.getMapping(digits), formattingSeparators: formattingSeparators)
    }

    @_inlineable @_versioned internal static func getBase(_ digits: [[UnicodeScalar]]) -> Self {
        return Self(UInt(digits.count))
    }

    @_inlineable @_versioned internal static func getMapping(_ digits: [[UnicodeScalar]]) -> [UnicodeScalar: Self] {
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

    @_inlineable @_versioned internal init(whole representation: StrictString, base: Self, digits digitMapping: [UnicodeScalar: Self], formattingSeparators: Set<UnicodeScalar>) throws {

        self = 0
        var position: Self = 0
        for character in representation.reversed() {
            if let digit = digitMapping[character], digit < base {
                self += (base ↑ position) × digit
                position += 1 as Self
            } else {
                if character ∉ formattingSeparators {
                    throw TextConvertibleNumberParseError.invalidDigit(character, entireString: representation)
                }
            }
        }
    }

    // MARK: - ExpressibleByStringLiteral

    // #documentation(SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:))
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    @_inlineable public init(stringLiteral: String) {
        self.init(StrictString(stringLiteral))
    }
}

extension TextConvertibleNumber where Self : IntegralArithmetic {
    // MARK: - where Self : IntegralArithmetic

    // #documentation(SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:))
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(fromRepresentation representation: StrictString, usingDigits digits:  [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws {

        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

        try self.init(integer: representation, base: Self.getBase(digits), digits: Self.getMapping(digits), formattingSeparators: formattingSeparators)
    }

    @_inlineable @_versioned internal init(integer representation: StrictString, base: Self, digits digitMapping: [UnicodeScalar: Self], formattingSeparators: Set<UnicodeScalar>) throws {
        var representation = representation

        let negative = representation.scalars.first == "−"
        if negative {
            representation.scalars.removeFirst()
        }

        try self.init(whole: representation, base: base, digits: digitMapping, formattingSeparators: formattingSeparators)

        if negative {
            self−=
        }
    }
}

extension TextConvertibleNumber where Self : RationalArithmetic {
    // MARK: - where Self : RationalArithmetic

    // #documentation(SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:))
    /// Creates an instance by interpreting `representation` as a place value system using the provided digits and radix characters.
    ///
    /// - Precondition: `digits`, `radixCharacters` and `formattingSeparators` only contain scalars that are valid in NFKD (they should not be decomposable).
    ///
    /// - Parameters:
    ///     - representation: The string to interpret.
    ///     - digits: The digits to use. Each entry in the array defines a set of digit characters that have the value corresponding to the array index. The length of the array determines the base.
    ///     - radixCharacters: The set of characters that can mark the radix position.
    ///     - formattingSeparators: A set of characters, such as thousands separators, that should be ignored.
    ///
    /// - Throws: `TextConvertibleNumberParseError`
    @_inlineable public init(fromRepresentation representation: StrictString, usingDigits digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws {
        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

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
            wholeString = StrictString(representation[representation.startIndex ..< radix])
            numeratorString = StrictString(representation[representation.index(after: radix) ..< representation.endIndex])
        } else {
            wholeString = representation
            numeratorString = ""
        }

        func flattenToZeroes(_ value: StrictString) -> StrictString {
            return StrictString(value.map({ digitMapping[$0] ≠ nil ? "0" : $0 }))
        }

        func component(_ value: StrictString) throws -> Self {
            return try Self(integer: value, base: base, digits: digitMapping, formattingSeparators: formattingSeparators)
        }

        let whole = try component(wholeString)
        let numerator = try component(numeratorString)
        let denominator = try component("1" + flattenToZeroes(numeratorString))

        self = whole + numerator ÷ denominator
    }
}

/// A type that conforms to `Codable` through its `TextConvertibleNumber` interface.
///
/// Conformance Requirements:
///
/// - `TextConvertibleNumber`
/// - `WholeNumberProtocol` or `IntegerProtocol`
public protocol CodableViaTextConvertibleNumber : TextConvertibleNumber {

}

extension CodableViaTextConvertibleNumber {

    // #documentation(SDGCornerstone.Decodable.init(from:))
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    @_inlineable public init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: StrictString.self, convert: { try Self(possibleDecimal: $0) })
    }
}

extension CodableViaTextConvertibleNumber where Self : IntegerProtocol {
    // MARK: - where Self : IntegerProtocol

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: inDigits())
    }
}

extension CodableViaTextConvertibleNumber where Self : WholeNumberProtocol {
    // MARK: - where Self : WholeNumberProtocol

    // #documentation(SDGCornerstone.Encodable.encode(to:))
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    @_inlineable public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: inDigits())
    }
}
