/*
 WholeNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Example 1: WholeNumber Literals_]
/// An arbitrary‐precision whole number.
///
/// ```swift
/// let million: WholeNumber = 1_000_000
/// let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
/// let yobiMultiplier: WholeNumber = "0b 1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000"
/// ```
///
/// `WholeNumber` has a current theoretical limit of about 10 ↑ 178 000 000 000 000 000 000, but since that would occupy over 73 exabytes, in practice `WholeNumber` is limited by the amount of memory available.
public struct WholeNumber : Addable, Comparable, Equatable, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByIntegerLiteral, ExpressibleByStringLiteral, ExpressibleByUnicodeScalarLiteral, PointType, Strideable, Subtractable, WholeArithmetic, WholeNumberType {

    // MARK: - Properties

    internal typealias Digit = UIntMax
    internal typealias DigitIndex = Int
    private var unsafeDigits: [Digit] = []
    private var digits: [Digit] {
        get {
            return unsafeDigits
        }
        set {
            unsafeDigits = newValue

            // Normalize

            while unsafeDigits.last == 0 {
                unsafeDigits.removeLast()
            }
        }
    }

    internal var digitIndices: CountableRange<DigitIndex> {
        return digits.indices
    }

    internal subscript(digitIndex: DigitIndex) -> Digit {
        get {
            guard digitIndex < digits.endIndex else {
                return 0
            }

            return digits[digitIndex]
        }
        set {
            var temporaryLeadingZeroes = digits

            let missingDigits = digitIndex + 1 − digits.endIndex
            if missingDigits > 0 {
                temporaryLeadingZeroes.append(contentsOf: [Digit](repeating: 0, count: missingDigits))
            }
            temporaryLeadingZeroes[digitIndex] = newValue

            digits = temporaryLeadingZeroes
        }
    }

    // [_Workaround: Subtypes in extensions have visibility problems. (Swift 3.1.0)_]
    internal typealias BinaryView = WholeNumberBinaryView

    private var binary: BinaryView {
        get {
            return BinaryView(self)
        }
        set {
            self = newValue.wholeNumber
        }
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the right value to the left, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout WholeNumber, rhs: WholeNumber) {

        var carrying: Digit = 0
        for digitIndex in rhs.digits.indices {

            var augend = lhs[digitIndex]
            let addend = rhs[digitIndex]

            let carried = carrying
            carrying = 0

            augend.add(addend, carringIn: &carrying)
            augend.add(carried, carringIn: &carrying)

            lhs[digitIndex] = augend
        }

        lhs[rhs.digits.endIndex] += carrying
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: WholeNumber, rhs: WholeNumber) -> Bool {

        if lhs.digits.count ≠ rhs.digits.count {
            return lhs.digits.count < rhs.digits.count
        }

        for digitIndex in lhs.digits.indices.lazy.reversed() {
            let left = lhs.digits[digitIndex]
            let right = rhs.digits[digitIndex]

            if left ≠ right {
                return left < right
            }
        }

        return false // Equal
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: WholeNumber, rhs: WholeNumber) -> Bool {
        return lhs.digits.elementsEqual(rhs.digits)
    }

    // MARK: - ExpressibleByExtendedGraphemeClusterLiteral

    // [_Define Documentation: SDGCornerstone.WholeNumber.init(extendedGraphemeClusterLiteral:)_]
    /// Creates an instance from an extended grapheme cluster literal.
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) { // [_Exempt from Code Coverage_] Apparently unreachable.
        self.init(textLiteral: value)
    }

    // MARK: - ExpressibleByIntegerLiteral

    // [_Define Documentation: SDGCornerstone.WholeNumber.IntegerLiteralType_]
    /// The integer literal type.
    public typealias IntegerLiteralType = UIntMax

    // [_Define Documentation: SDGCornerstone.WholeNumber.init(integerLiteral:)_]
    /// Creates an instance from an integer literal.
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }

    // MARK: - ExpressibleByStringLiteral

    private static let digits: [Set<UnicodeScalar>] = [
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
    private static let thousandsSeparators: Set<UnicodeScalar> = [" ", "٬"]

    internal static let digitMapping: [UnicodeScalar: WholeNumber] = {
        var mapping: [UnicodeScalar: WholeNumber] = [:]
        for value in digits.indices {
            let characters = digits[value]
            for character in characters {
                mapping[character] = WholeNumber(UIntMax(value))
            }
        }
        return mapping
    }()

    private init(_ representation: String, base: WholeNumber) {

        self = 0
        var position: WholeNumber = 0
        for character in representation.decomposedStringWithCompatibilityMapping.unicodeScalars.reversed() {
            if let digit = WholeNumber.digitMapping[character], digit < base {
                self += (base ↑ position) × digit
                position += 1 as WholeNumber
            } else {
                assert(WholeNumber.thousandsSeparators.contains(character), "\(character) is not a valid digit.")
            }

        }
    }

    internal static let prefixToBaseMapping: [String: WholeNumber] = [
        "0b": 2,
        "0o": 8,
        "0x": 16
    ]

    internal init(textLiteral value: String) {

        var numeric: WholeNumber?
        for (prefix, base) in WholeNumber.prefixToBaseMapping {
            if value.hasPrefix(prefix) {
                let scalars = value.unicodeScalars
                numeric = WholeNumber(String(scalars[scalars.index(scalars.startIndex, offsetBy: prefix.unicodeScalars.count) ..< scalars.endIndex]), base: base)
                break
            }
        }

        if let result = numeric {
            self = result
        } else {
            self = WholeNumber(value, base: 10)
        }
    }

    // [_Define Documentation: SDGCornerstone.WholeNumber.init(stringLiteral:)_]
    /// Creates an instance from a string literal.
    public init(stringLiteral value: StringLiteralType) {
        self.init(textLiteral: value)
    }

    // MARK: - ExpressibleByUnicodeScalarLiteral

    // [_Define Documentation: SDGCornerstone.WholeNumber.init(unicodeScalarLiteral:)_]
    /// Creates an instance from a unicode scalar literal.
    public init(unicodeScalarLiteral value: StringLiteralType) { // [_Exempt from Code Coverage_] Apparently unreachable.
        self.init(textLiteral: value)
    }

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Integer

    // [_Inherit Documentation: SDGCornerstone.PointType.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout WholeNumber, rhs: Vector) {
        if rhs.isNegative {
            lhs −= rhs.magnitude
        } else {
            lhs += rhs.magnitude
        }
    }

    // [_Inherit Documentation: SDGCornerstone.PointType.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: WholeNumber, rhs: WholeNumber) -> Vector {
        return Integer(lhs) − Integer(rhs)
    }

    // MARK: - Strideable

    /// The stride type.
    public typealias Stride = Vector

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout WholeNumber, rhs: WholeNumber) {
        assert(lhs ≥ rhs, "\(lhs) − \(rhs) is impossible for \(WholeNumber.self).")

        var borrowing: Digit = 0
        for digitIndex in rhs.digits.indices {

            var minuend = lhs[digitIndex]
            let subtrahend = rhs[digitIndex]

            let borrowed = borrowing
            borrowing = 0

            minuend.subtract(subtrahend, borrowingIn: &borrowing)
            minuend.subtract(borrowed, borrowingIn: &borrowing)

            lhs[digitIndex] = minuend
        }

        lhs[rhs.digits.endIndex] −= borrowing
    }

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    public init(_ uInt: UIntMax) {
        digits = [uInt]
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    public static func × (lhs: WholeNumber, rhs: WholeNumber) -> WholeNumber {

        var product: WholeNumber = 0

        for rhsIndex in rhs.digits.indices {
            for lhsIndex in lhs.digits.indices {

                let lhsDigit = lhs.digits[lhsIndex]
                let rhsDigit = rhs.digits[rhsIndex]

                let digitResult = Digit.multiply(lhsDigit, with: rhsDigit)

                let productIndex = lhsIndex + rhsIndex
                var addend: WholeNumber = 0
                addend[productIndex] = digitResult.product
                addend[productIndex + 1] = digitResult.carried

                product += addend
            }
        }

        return product
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    ///
    /// - RecommendedOver: *=
    public static func ×= (lhs: inout WholeNumber, rhs: WholeNumber) {
        lhs = lhs × rhs
    }

    internal func quotientAndRemainder(for divisor: WholeNumber) -> (quotient: WholeNumber, remainder: WholeNumber) {

        var quotient: WholeNumber = 0
        var remainingDividend = self

        while remainingDividend ≥ divisor {
            var divides = true // If the following iteration finishes, it is exactly equal and divides precicely once.
            for (dividendBit, divisorBit) in zip(remainingDividend.binary.lastBitsBackwards(maximum: divisor.binary.count), divisor.binary.bitsBackwards()) where dividendBit ≠ divisorBit {
                if dividendBit < divisorBit {
                    divides = false
                    break
                }
                if dividendBit > divisorBit {
                    divides = true
                    break
                }
            }

            var bitPosition = remainingDividend.binary.endIndex − divisor.binary.count
            if ¬divides {
                bitPosition −= 1
            }

            quotient.binary[bitPosition] = true

            var shiftedDivisor = divisor
            shiftedDivisor.binary.shiftLeft(bitPosition − binary.startIndex)
            remainingDividend −= shiftedDivisor
        }

        return (quotient, remainingDividend)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - NonmutatingVariant: dividedAccordingToEuclid
    public mutating func divideAccordingToEuclid(by divisor: WholeNumber) {
        self = quotientAndRemainder(for: divisor).quotient
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    public mutating func formRemainder(mod divisor: WholeNumber) {
        self = quotientAndRemainder(for: divisor).remainder
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<WholeNumber>, fromRandomizer randomizer: Randomizer) {
        let rangeSize: WholeNumber = range.upperBound − range.lowerBound

        var atLimit = true
        var offset: WholeNumber = 0
        for digitIndex in rangeSize.digitIndices.reversed() {
            if atLimit {
                let maximum = rangeSize[digitIndex]
                let digit = Digit(randomInRange: 0 ... maximum, fromRandomizer: randomizer)
                if digit ≠ maximum {
                    atLimit = false
                }
                offset[digitIndex] = digit
            } else {
                offset[digitIndex] = Digit(randomInRange: 0 ... Digit.max, fromRandomizer: randomizer)
            }
        }

        self = range.lowerBound + offset
    }
}
