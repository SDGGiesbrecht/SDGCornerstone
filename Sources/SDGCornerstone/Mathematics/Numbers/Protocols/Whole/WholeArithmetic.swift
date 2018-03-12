/*
 WholeArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogicCore
import SDGMathematicsCore
import SDGCornerstoneLocalizations

/// A type that can be used for whole‐number arithmetic.
///
/// Conformance Requirements:
///
/// - `NumericAdditiveArithmetic`
/// - `FixedScaleOneDimensionalPoint`
/// - `init(_ uInt: UIntMax)`
/// - `init?<T>(exactly source: T) where T : BinaryInteger`
/// - `static func ×= (precedingValue: inout Self, followingValue: Self)`
/// - `mutating func divideAccordingToEuclid(by divisor: Self)`
/// - `WholeNumberProtocol`, `IntegerProtocol`, `RationalNumberProtocol` or `static func ↑= (precedingValue: inout Self, followingValue: Self)`
/// - `init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)`
public protocol WholeArithmetic : ExpressibleByStringLiteral, RandomizableNumber {

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
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
    /// - Throws: `WholeArithmeticParseError`
    init(fromRepresentation representation: StrictString, usingDigits digits:  [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws
}

extension WholeArithmetic {

    private init(forceParsing parse: () throws -> Self) {
        do {
            self = try parse()
        } catch let error as WholeArithmeticParseError { // [_Exempt from Test Coverage_]
            switch error {
            case .invalidDigit(let scalar):
                preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                    switch localization {
                    case .englishCanada: // [_Exempt from Test Coverage_]
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
    public init(_ decimal: StrictString) {
        self.init(forceParsing: { try Self(possibleDecimal: decimal) })
    }

    /// Creates an instance from a hexadecimal representation.
    ///
    /// - Parameters:
    ///     - hexadecimal: The hexadecimal representation.
    public init(hexadecimal: StrictString) {
        self.init(forceParsing: { try Self(possibleHexadecimal: hexadecimal) })
    }

    /// Creates an instance from a octal representation.
    ///
    /// - Parameters:
    ///     - octal: The octal representation.
    public init(octal: StrictString) {
        self.init(forceParsing: { try Self(possibleOctal: octal) })
    }

    /// Creates an instance from a binary representation.
    ///
    /// - Parameters:
    ///     - binary: The binary representation.
    public init(binary: StrictString) {
        self.init(forceParsing: { try Self(possibleBinary: binary) })
    }

    /// Creates an instance from a decimal representation.
    ///
    /// - Parameters:
    ///     - decimal: The decimal representation.
    ///
    /// - Throws: `WholeArithmeticParseError`
    public init(possibleDecimal decimal: StrictString) throws {
        try self.init(decimal, base: 10)
    }

    /// Creates an instance from a hexadecimal representation.
    ///
    /// - Parameters:
    ///     - hexadecimal: The hexadecimal representation.
    ///
    /// - Throws: `WholeArithmeticParseError`
    public init(possibleHexadecimal hexadecimal: StrictString) throws {
        try self.init(hexadecimal, base: 16)
    }

    /// Creates an instance from a octal representation.
    ///
    /// - Parameters:
    ///     - octal: The octal representation.
    ///
    /// - Throws: `WholeArithmeticParseError`
    public init(possibleOctal octal: StrictString) throws {
        try self.init(octal, base: 8)
    }

    /// Creates an instance from a binary representation.
    ///
    /// - Parameters:
    ///     - binary: The binary representation.
    ///
    /// - Throws: `WholeArithmeticParseError`
    public init(possibleBinary binary: StrictString) throws {
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
    /// - Throws: `WholeArithmeticParseError`
    public init(_ representation: StrictString, base: Int) throws {
        assert(base.isIntegral ∧ 2 ≤ base ∧ base ≤ 16, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
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

    fileprivate static func assertNFKD(digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) {

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
        assert(assertNFKD().isEmpty, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return StrictString("Some scalars are not in NFKD: \(assertNFKD().map({ $0.visibleRepresentation }))")
            }
        }))
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
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
    /// - Throws: `WholeArithmeticParseError`
    public init(fromRepresentation representation: StrictString, usingDigits digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws {
        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

        try self.init(whole: representation, base: Self.getBase(digits), digits: Self.getMapping(digits), formattingSeparators: formattingSeparators)
    }

    fileprivate static func getBase(_ digits: [[UnicodeScalar]]) -> Self {
        return Self(UInt(digits.count))
    }

    fileprivate static func getMapping(_ digits: [[UnicodeScalar]]) -> [UnicodeScalar: Self] {
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

    fileprivate init(whole representation: StrictString, base: Self, digits digitMapping: [UnicodeScalar: Self], formattingSeparators: Set<UnicodeScalar>) throws {

        self = 0
        var position: Self = 0
        for character in representation.reversed() {
            if let digit = digitMapping[character], digit < base {
                self += (base ↑ position) × digit
                position += 1 as Self
            } else {
                if character ∉ formattingSeparators {
                    throw WholeArithmeticParseError.invalidDigit(character)
                }
            }
        }
    }

    internal var egyptianDigits: [UnicodeScalar] {
        return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    }

    internal func radix(for digits: [UnicodeScalar]) -> Self {
        return Self(UInt(digits.count))
    }

    internal func mapping(for digits: [UnicodeScalar]) -> [Self: UnicodeScalar] {
        var result: [Self: UnicodeScalar] = [:]
        for value in digits.indices {
            result[Self(UInt(value))] = digits[value]
        }
        return result
    }

    internal func wholeDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        let digitSet = egyptianDigits

        let radix = self.radix(for: digitSet)
        let digitMapping = mapping(for: digitSet)

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
    }

    internal func generateAbbreviatedEnglishOrdinal() -> SemanticMarkup {
        let digits = SemanticMarkup(wholeDigits())
        guard let last = digits.last else {
            unreachable()
        }

        if digits.count ≥ 2 ∧ digits[digits.index(before: digits.index(before: digits.endIndex))] == "1" {
            // 11, 12, 13, etc.
            return digits + SemanticMarkup("th").superscripted()
        }

        switch last {
        case "1":
            return digits + SemanticMarkup("st").superscripted()
        case "2":
            return digits + SemanticMarkup("nd").superscripted()
        case "3":
            return digits + SemanticMarkup("rd").superscripted()
        default:
            return digits + SemanticMarkup("th").superscripted()
        }
    }

    internal func verkürzteDeutscheOrdnungszahlErzeugen() -> StrictString {
        return wholeDigits() + "."
    }

    internal func générerOrdinalFrançaisAbrégé(genre: GenreGrammatical, nombre: GrammaticalNumber) -> SemanticMarkup {
        var singulier: StrictString

        if self == 1 {
            switch genre {
            case .masculin:
                singulier = "er"
            case .féminin:
                singulier = "re"
            }
        } else {
            singulier = "e"
        }

        switch nombre {
        case .singular:
            break
        case .plural:
            singulier += "s"
        }

        return SemanticMarkup(wholeDigits()) + SemanticMarkup(singulier).superscripted()
    }

    internal func παραγωγήΣυντομογραφίαςΕλληνικούΤακτικούΑριθμού(γένος: GrammaticalGender, πτώση: ΓραμματικήΠτώση, αριθμός: GrammaticalNumber) -> SemanticMarkup {
        switch αριθμός {
        case .singular:
            switch γένος {
            case .masculine:
                switch πτώση {
                case .ονομαστική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ος").superscripted()
                case .αιτιατική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ο").superscripted()
                case .γενική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ου").superscripted()
                case .κλητική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ε").superscripted()
                }
            case .feminine:
                switch πτώση {
                case .ονομαστική, .αιτιατική, .κλητική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("η").superscripted()
                case .γενική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ης").superscripted()
                }
            case .neuter:
                switch πτώση {
                case .ονομαστική, .αιτιατική, .κλητική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ο").superscripted()
                case .γενική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ου").superscripted()
                }
            }
        case .plural:
            switch γένος {
            case .masculine:
                switch πτώση {
                case .ονομαστική, .κλητική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("οι").superscripted()
                case .αιτιατική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ους").superscripted()
                case .γενική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ων").superscripted()
                }
            case .feminine:
                switch πτώση {
                case .ονομαστική, .αιτιατική, .κλητική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ες").superscripted()
                case .γενική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ων").superscripted()
                }
            case .neuter:
                switch πτώση {
                case .ονομαστική, .αιτιατική, .κλητική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("α").superscripted()
                case .γενική:
                    return SemanticMarkup(wholeDigits()) + SemanticMarkup("ων").superscripted()
                }
            }
        }
    }

    internal func romanNumerals(lowercase: Bool) -> StrictString {
        let warning = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "Roman numerals are only supported in the range I–MMMCMXCIX."
            }
        })
        assert(0 < self ∧ (self is Int8 ∨ self is UInt8 ∨ self < 4000), warning)

        func format(_ string: StrictString) -> StrictString {
            if lowercase {
                return StrictString(String(string).lowercased())
            } else {
                return string
            }
        }

        var number = self
        var result: StrictString = ""

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("I"))
        case 2:
            result.prepend(contentsOf: format("II"))
        case 3:
            result.prepend(contentsOf: format("III"))
        case 4:
            result.prepend(contentsOf: format("IV"))
        case 5:
            result.prepend(contentsOf: format("V"))
        case 6:
            result.prepend(contentsOf: format("VI"))
        case 7:
            result.prepend(contentsOf: format("VII"))
        case 8:
            result.prepend(contentsOf: format("VIII"))
        case 9:
            result.prepend(contentsOf: format("IX"))
        default:
            preconditionFailure(warning)
        }
        number.divideAccordingToEuclid(by: 10)

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("X"))
        case 2:
            result.prepend(contentsOf: format("XX"))
        case 3:
            result.prepend(contentsOf: format("XXX"))
        case 4:
            result.prepend(contentsOf: format("XL"))
        case 5:
            result.prepend(contentsOf: format("L"))
        case 6:
            result.prepend(contentsOf: format("LX"))
        case 7:
            result.prepend(contentsOf: format("LXX"))
        case 8:
            result.prepend(contentsOf: format("LXXX"))
        case 9:
            result.prepend(contentsOf: format("XC"))
        default:
            preconditionFailure(warning)
        }
        number.divideAccordingToEuclid(by: 10)

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("C"))
        case 2:
            result.prepend(contentsOf: format("CC"))
        case 3:
            result.prepend(contentsOf: format("CCC"))
        case 4:
            result.prepend(contentsOf: format("CD"))
        case 5:
            result.prepend(contentsOf: format("D"))
        case 6:
            result.prepend(contentsOf: format("DC"))
        case 7:
            result.prepend(contentsOf: format("DCC"))
        case 8:
            result.prepend(contentsOf: format("DCCC"))
        case 9:
            result.prepend(contentsOf: format("CM"))
        default:
            preconditionFailure(warning)
        }
        number.divideAccordingToEuclid(by: 10)

        switch number.mod(10) {
        case 0:
            break
        case 1:
            result.prepend(contentsOf: format("M"))
        case 2:
            result.prepend(contentsOf: format("MM"))
        case 3:
            result.prepend(contentsOf: format("MMM"))
        default:
            preconditionFailure(warning)
        }

        return result
    }

    internal func ελληνικοίΑριθμοί(μικράΓράμματα: Bool, κεραία: Bool) -> StrictString {
        let προειδοποίηση = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "Greek numerals are only supported in the range Αʹ–͵ΘϠϞΘʹ."
            }
        })
        assert(0 < self ∧ (self is Int8 ∨ self is UInt8 ∨ self < 10_000), προειδοποίηση)

        func μορφοποίηση(_ κείμενο: StrictString) -> StrictString {
            if μικράΓράμματα {
                return StrictString(String(κείμενο).lowercased())
            } else {
                return κείμενο
            }
        }

        var αριθμός = self
        var αποτέλεσμα: StrictString = ""

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Α"))
        case 2:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Β"))
        case 3:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Γ"))
        case 4:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Δ"))
        case 5:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ε"))
        case 6:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ϛ"))
        case 7:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ζ"))
        case 8:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Η"))
        case 9:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Θ"))
        default:
            preconditionFailure(προειδοποίηση)
        }
        αριθμός.divideAccordingToEuclid(by: 10)

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ι"))
        case 2:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Κ"))
        case 3:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Λ"))
        case 4:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Μ"))
        case 5:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ν"))
        case 6:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ξ"))
        case 7:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ο"))
        case 8:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Π"))
        case 9:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ϟ"))
        default:
            preconditionFailure(προειδοποίηση)
        }
        αριθμός.divideAccordingToEuclid(by: 10)

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ρ"))
        case 2:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Σ"))
        case 3:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Τ"))
        case 4:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Υ"))
        case 5:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Φ"))
        case 6:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Χ"))
        case 7:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ψ"))
        case 8:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ω"))
        case 9:
            αποτέλεσμα.prepend(contentsOf: μορφοποίηση("Ϡ"))
        default:
            preconditionFailure(προειδοποίηση)
        }
        αριθμός.divideAccordingToEuclid(by: 10)

        if κεραία ∧ ¬αποτέλεσμα.isEmpty {
            αποτέλεσμα.append("ʹ")
        }

        var χιλιάδες: StrictString = ""

        switch αριθμός.mod(10) {
        case 0:
            break
        case 1:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Α"))
        case 2:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Β"))
        case 3:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Γ"))
        case 4:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Δ"))
        case 5:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Ε"))
        case 6:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Ϛ"))
        case 7:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Ζ"))
        case 8:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Η"))
        case 9:
            χιλιάδες.prepend(contentsOf: μορφοποίηση("Θ"))
        default:
            preconditionFailure(προειδοποίηση)
        }

        if κεραία ∧ ¬χιλιάδες.isEmpty {
            χιλιάδες.prepend("͵")
        }

        αποτέλεσμα.prepend(contentsOf: χιλιάδες)

        return αποτέλεσμα
    }

    internal func ספרות־עבריות(גרשיים: Bool) -> StrictString {
        let אזהרה = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return "Hebrew numerals are only supported in the range א׳–ט׳תתקצ״ט."
            }
        })
        assert(0 < self ∧ (self is Int8 ∨ self is UInt8 ∨ self < 10_000), אזהרה)

        var מספר = self
        var תוצאה: StrictString = ""

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            תוצאה.prepend("א")
        case 2:
            תוצאה.prepend("ב")
        case 3:
            תוצאה.prepend("ג")
        case 4:
            תוצאה.prepend("ד")
        case 5:
            תוצאה.prepend("ה")
        case 6:
            תוצאה.prepend("ו")
        case 7:
            תוצאה.prepend("ז")
        case 8:
            תוצאה.prepend("ח")
        case 9:
            תוצאה.prepend("ט")
        default:
            preconditionFailure(אזהרה)
        }
        מספר.divideAccordingToEuclid(by: 10)

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            תוצאה.prepend("י")
        case 2:
            תוצאה.prepend("כ")
        case 3:
            תוצאה.prepend("ל")
        case 4:
            תוצאה.prepend("מ")
        case 5:
            תוצאה.prepend("נ")
        case 6:
            תוצאה.prepend("ס")
        case 7:
            תוצאה.prepend("ע")
        case 8:
            תוצאה.prepend("פ")
        case 9:
            תוצאה.prepend("צ")
        default:
            preconditionFailure(אזהרה)
        }
        מספר.divideAccordingToEuclid(by: 10)

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            תוצאה.prepend("ק")
        case 2:
            תוצאה.prepend("ר")
        case 3:
            תוצאה.prepend("ש")
        case 4:
            תוצאה.prepend("ת")
        case 5:
            תוצאה.prepend(contentsOf: "תק")
        case 6:
            תוצאה.prepend(contentsOf: "תר")
        case 7:
            תוצאה.prepend(contentsOf: "תש")
        case 8:
            תוצאה.prepend(contentsOf: "תת")
        case 9:
            תוצאה.prepend(contentsOf: "תתק")
        default:
            preconditionFailure(אזהרה)
        }
        מספר.divideAccordingToEuclid(by: 10)

        תוצאה.replaceMatches(for: "יה" as StrictString, with: "טו" as StrictString)
        תוצאה.replaceMatches(for: "יו" as StrictString, with: "טז" as StrictString)

        if גרשיים ∧ ¬תוצאה.isEmpty {
            if תוצאה.count == 1 {
                תוצאה.append("׳")
            } else {
                תוצאה.insert("״", at: תוצאה.index(before: תוצאה.endIndex))
            }
        }

        var אלפים: StrictString = ""

        switch מספר.mod(10) {
        case 0:
            break
        case 1:
            אלפים.prepend("א")
        case 2:
            אלפים.prepend("ב")
        case 3:
            אלפים.prepend("ג")
        case 4:
            אלפים.prepend("ד")
        case 5:
            אלפים.prepend("ה")
        case 6:
            אלפים.prepend("ו")
        case 7:
            אלפים.prepend("ז")
        case 8:
            אלפים.prepend("ח")
        case 9:
            אלפים.prepend("ט")
        default:
            preconditionFailure(אזהרה)
        }

        if גרשיים ∧ ¬אלפים.isEmpty {
            אלפים.append("׳")
        }

        תוצאה.prepend(contentsOf: אלפים)

        return תוצאה
    }
}

extension WholeArithmetic where Self : IntegralArithmetic {
    // MARK: - where Self : IntegralArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
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
    /// - Throws: `WholeArithmeticParseError`
    public init(fromRepresentation representation: StrictString, usingDigits digits:  [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws {

        Self.assertNFKD(digits: digits, radixCharacters: radixCharacters, formattingSeparators: formattingSeparators)

        try self.init(integer: representation, base: Self.getBase(digits), digits: Self.getMapping(digits), formattingSeparators: formattingSeparators)
    }

    fileprivate init(integer representation: StrictString, base: Self, digits digitMapping: [UnicodeScalar: Self], formattingSeparators: Set<UnicodeScalar>) throws {
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

extension WholeArithmetic where Self : RationalArithmetic {
    // MARK: - where Self : RationalArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(fromRepresentation:usingDigits:radixCharacters:)_]
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
    /// - Throws: `WholeArithmeticParseError`
    public init(fromRepresentation representation: StrictString, usingDigits digits: [[UnicodeScalar]], radixCharacters: Set<UnicodeScalar>, formattingSeparators: Set<UnicodeScalar>) throws {
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
