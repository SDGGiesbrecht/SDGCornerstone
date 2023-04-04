/*
 DUCET.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGLocalization
import SDGCollation
import SDGPersistence

extension CollationOrder {

  // Constants
  static let beforeIndex: CollationIndex = 0
  static let endOfStringIndex: CollationIndex = beforeIndex.successor()
  static let offsetFromDUCET: CollationIndex = endOfStringIndex − beforeIndex

  static let placeholderIndex: CollationIndex = endOfStringIndex.successor()

  #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
    static func ducet() throws -> CollationOrder {

      // Constants to fetch.
      var ducetDefaultAccent: CollationIndex?
      var ducetDefaultCase: CollationIndex?
      var ducetMaxIndex: CollationIndex = 0

      print("Loading DUCET...")

      let ducetURL = URL(string: "http://www.unicode.org/Public/UCA/latest/allkeys.txt")!
      let ducetText = try String(from: ducetURL)

      print("Parsing DUCET...")

      var rules = [StrictString: [CollationElement]]()
      let lines: [String] = ducetText.lines.map { String($0.line) }
      for index in lines.indices {
        let line = lines[index]
        if index.isDivisible(by: 100) {
          print("\(line)...")
        }

        let withoutComments = String(
          line.scalars.truncated(
            before: ConditionalPattern({ $0 ∈ Set<UnicodeScalar>(["#", "%"]) })
          )
        )
        if ¬withoutComments.isEmpty ∧ ¬withoutComments.hasPrefix("@") /* version line */ {

          let halves = withoutComments.components(separatedBy: ";")
          let charactersText = StrictString(halves[0].contents.unicodeScalars)
          let collationText = StrictString(halves[1].contents.unicodeScalars)

          let scalarValues =
            charactersText
            .components(separatedBy: " ".scalars.literal()).map { $0.contents }
          var scalarIntegers = [Int]()
          var characters = String.UnicodeScalarView()
          for scalarValue in scalarValues {
            if ¬scalarValue.isEmpty {
              let valueAsString = StrictString(scalarValue)
              let number = UInt32(hexadecimal: valueAsString)
              let character = Unicode.Scalar(number)!
              scalarIntegers.append(Int(character.value))
              characters.append(character)
            }
          }
          assert(¬characters.isEmpty, "Empty element in DUCET.")

          if characters.elementsEqual(StrictString(characters).scalars) {
            let strictCharacters = StrictString(characters)

            let collationElementStrings = collationText.components(
              separatedBy: ConditionalPattern({ $0 ∈ Set<Unicode.Scalar>(["[", "]"]) })
            )
            .map { $0.contents.filter({ $0 ≠ " " }) }
            var elements = [CollationElement]()
            for collationElementSubstring in collationElementStrings {
              if ¬collationElementSubstring.isEmpty {
                let collationElementText = StrictString(collationElementSubstring)

                let isVariable = collationElementText.first == "*"

                let ducetIndices = collationElementText.components(
                  separatedBy: ConditionalPattern({ $0 ∈ Set<UnicodeScalar>([".", "*"]) })
                )
                .filter({ ¬$0.range.isEmpty })
                .map { (match) -> CollationIndex in

                  let string = String(StrictString(match.contents))
                  if let integer = CollationIndex(string, radix: 16) {
                    ducetMaxIndex.increase(to: integer)
                    return integer
                  } else {
                    preconditionFailure("Could not parse hexadecimal: \(string)")
                  }
                }
                assert(
                  ducetIndices.count == 3,
                  "Unexpected number of indices: \(ducetIndices) for line: \(StrictString(line))"
                )
                if strictCharacters == "א" {
                  ducetDefaultAccent = ducetIndices[1]
                  ducetDefaultCase = ducetIndices[2]
                }

                var indices = [[CollationIndex]]()

                func appendDUCET(index: Int, to indices: inout [[CollationIndex]]) {
                  if ducetIndices[index] == 0 {
                    indices.append([])
                  } else {
                    indices.append([ducetIndices[index] + CollationOrder.offsetFromDUCET])
                  }
                }
                func appendPlaceholderIndices(_ indices: inout [[CollationIndex]]) {
                  if indices.last!.isEmpty {
                    indices.append([])
                  } else {
                    indices.append([CollationOrder.placeholderIndex])
                  }
                }

                if isVariable {
                  indices.append([])  // Ignored primary.
                  indices.append([])  // Ignored reverse accents.
                  indices.append([])  // Ignored forward accents.
                  indices.append([])  // Ignored case.
                  appendDUCET(index: 0, to: &indices)  // DUCET punctuation.
                } else {
                  appendDUCET(index: 0, to: &indices)  // DUCET primary.
                  appendPlaceholderIndices(&indices)  // Placeholder reverse accents.
                  appendDUCET(index: 1, to: &indices)  // DUCET forward accents.
                  appendDUCET(index: 2, to: &indices)  // DUCET case.

                  // Reuse DUCET primary to intersort with DUCET punctuation.
                  appendDUCET(index: 0, to: &indices)
                }
                appendPlaceholderIndices(&indices)  // Placeholder script.

                assert(
                  indices.count == CollationLevel.allCases.count,
                  "Incorrect number of indices."
                )

                elements.append(CollationElement(rawIndices: indices))
              }
            }

            rules[strictCharacters] = elements
          }
        }
      }

      // Derived constants.
      let defaultAccent: CollationIndex = ducetDefaultAccent! + offsetFromDUCET
      let defaultCase: CollationIndex = ducetDefaultCase! + offsetFromDUCET

      let unifiedIdeographs: CollationIndex = ducetMaxIndex.successor() + offsetFromDUCET
      let otherUnifiedIdeographs: CollationIndex = unifiedIdeographs.successor()
      let unassignedCodePoints: CollationIndex = otherUnifiedIdeographs.successor()
      let finalIndex: CollationIndex = unassignedCodePoints.successor()
      let afterIndex: CollationIndex = finalIndex.successor()

      rules["<_end_>"] = [
        CollationElement(rawIndices: [
          [CollationOrder.endOfStringIndex],
          [CollationOrder.endOfStringIndex],
          [CollationOrder.endOfStringIndex],
          [CollationOrder.endOfStringIndex],
          [CollationOrder.endOfStringIndex],
          [CollationOrder.endOfStringIndex],
        ])
      ]
      rules["<_final_>"] = [
        CollationElement(rawIndices: [
          [finalIndex],
          [CollationOrder.placeholderIndex],
          [defaultAccent],
          [defaultCase],
          [finalIndex],
          [CollationOrder.placeholderIndex],
        ])
      ]

      let afterPlaceholder = CollationOrder.placeholderIndex.successor()
      rules["<_ReverseAccent_>"] = [
        CollationElement(rawIndices: [
          [],
          [afterPlaceholder],
          [defaultAccent],
          [defaultCase],
          [],
          [CollationOrder.placeholderIndex],
        ])
      ]
      rules["<_Script_>"] = [
        CollationElement(rawIndices: [[], [], [], [], [], [afterPlaceholder]])
      ]

      print("Finished parsing DUCET.")

      return CollationOrder(
        _rules: rules,
        beforeIndex: CollationOrder.beforeIndex,
        endOfStringIndex: CollationOrder.endOfStringIndex,
        placeholderIndex: CollationOrder.placeholderIndex,
        defaultAccent: defaultAccent,
        defaultCase: defaultCase,
        unifiedIdeographs: unifiedIdeographs,
        otherUnifiedIdeographs: otherUnifiedIdeographs,
        unassignedCodePoints: unassignedCodePoints,
        afterIndex: afterIndex
      )
    }
  #endif
}
