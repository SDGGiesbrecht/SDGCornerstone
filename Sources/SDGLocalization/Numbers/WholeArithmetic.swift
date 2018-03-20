/*
 WholeArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

extension WholeArithmetic {

    @_inlineable @_versioned internal var egyptianDigits: [UnicodeScalar] {
        return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    }

    @_inlineable @_versioned internal func radix(for digits: [UnicodeScalar]) -> Self {
        return Self(UInt(digits.count))
    }

    @_inlineable @_versioned internal func mapping(for digits: [UnicodeScalar]) -> [Self: UnicodeScalar] {
        var result: [Self: UnicodeScalar] = [:]
        for value in digits.indices {
            result[Self(UInt(value))] = digits[value]
        }
        return result
    }

    @_inlineable @_versioned internal func wholeDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
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

    @_inlineable @_versioned internal func generateAbbreviatedEnglishOrdinal() -> SemanticMarkup {
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

    @_inlineable @_versioned internal func romanNumerals(lowercase: Bool) -> StrictString {

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
            return wholeDigits()
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
            return wholeDigits()
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
            return wholeDigits()
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
            return wholeDigits()
        }

        return result
    }
}
