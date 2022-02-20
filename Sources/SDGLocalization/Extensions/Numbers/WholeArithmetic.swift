/*
 WholeArithmetic.swift

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

extension WholeArithmetic {

  internal var egyptianDigits: [UnicodeScalar] {
    return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  }

  internal func radix(for digits: [UnicodeScalar]) -> Self {
    return Self(UInt(digits.count))
  }

  internal func mapping(for digits: [UnicodeScalar]) -> [_HashableWrapper<Self>: UnicodeScalar] {
    var result: [_HashableWrapper<Self>: UnicodeScalar] = [:]
    for value in digits.indices {
      result[_HashableWrapper(Self(UInt(value)))] = digits[value]
    }
    return result
  }

  internal func wholeDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
    let digitSet = egyptianDigits

    let radix = self.radix(for: digitSet)
    let digitMapping = mapping(for: digitSet)

#warning("Debugging...")
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

  internal func generateAbbreviatedEnglishOrdinal() -> SemanticMarkup {
    let digits = SemanticMarkup(wholeDigits())
    guard let last = digits.last else {
      unreachable()
    }

    if digits.count ≥ 2 ∧ digits[digits.index(before: digits.index(before: digits.endIndex))] == "1"
    {
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

  internal func abgekürzteDeutscheOrdnungszahlErzeugen() -> StrictString {
    return wholeDigits() + "."
  }

  internal func générerOrdinalFrançaisAbrégé(
    genre: GenreGrammatical,
    nombre: GrammaticalNumber
  ) -> SemanticMarkup {
    var singulier: StrictString

    if self == 1 {
      switch genre {
      case .זכר:  // masculin
        singulier = "er"
      case .נקבה:  // féminin
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

  internal func romanNumerals(lowercase: Bool) -> StrictString {

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
      unreachable()
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
      unreachable()
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
      unreachable()
    }
    number.divideAccordingToEuclid(by: 10)

    switch number {
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

  internal func ελληνικοίΑριθμοί(μικράΓράμματα: Bool, κεραία: Bool) -> StrictString {

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
      unreachable()
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
      unreachable()
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
      unreachable()
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
      unreachable()
    }
    if αριθμός.dividedAccordingToEuclid(by: 10) ≠ 0 {
      return wholeDigits()
    }

    if κεραία ∧ ¬χιλιάδες.isEmpty {
      χιλιάδες.prepend("͵")
    }

    αποτέλεσμα.prepend(contentsOf: χιλιάδες)

    return αποτέλεσμα
  }

  internal func ספרות־עבריות(גרשיים: Bool) -> StrictString {

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
      unreachable()
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
      unreachable()
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
      unreachable()
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
      unreachable()
    }
    if מספר.dividedAccordingToEuclid(by: 10) ≠ 0 {
      return wholeDigits()
    }

    if גרשיים ∧ ¬אלפים.isEmpty {
      אלפים.append("׳")
    }

    תוצאה.prepend(contentsOf: אלפים)

    return תוצאה
  }
}
