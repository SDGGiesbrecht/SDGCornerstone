/*
 ResourceGeneration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import XCTest

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGLocalization
@testable import SDGCollation
import SDGPersistence

final class SDGInterfaceResourceGeneration : XCTestCase {

    // Complete the word “test” to activate and run the generators.

    func tesRefreshUnicodeData() throws {
        print("Loading DUCET...")

        let ducetURL = URL(string: "http://www.unicode.org/Public/UCA/latest/allkeys.txt")!
        let ducetText = try String(from: ducetURL)

        print("Parsing DUCET...")

        var maxIndex: CollationIndex = 0
        var rules = [StrictString: [CollationElement]]()
        let lines: [String] = ducetText.lines.map { String($0.line) }
        for index in lines.indices {
            let line = lines[index]
            if index.isDivisible(by: 100) {
                print("\(line)...")
            }

            let withoutComments = String(line.scalars.truncated(
                before: ConditionalPattern({ $0 ∈ Set<UnicodeScalar>(["#", "%"]) })))
            if ¬withoutComments.isEmpty ∧ ¬withoutComments.hasPrefix("@") /* version line */ {

                let halves = withoutComments.components(separatedBy: ";")
                let charactersText = StrictString(halves[0].contents.unicodeScalars)
                let collationText = StrictString(halves[1].contents.unicodeScalars)

                let scalarValues = charactersText.components(separatedBy: " ".scalars).map { $0.contents }
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
                        separatedBy: ConditionalPattern({ $0 ∈ Set<Unicode.Scalar>(["[", "]"]) }))
                        .map { $0.contents.filter({ $0 ≠ " " }) }
                    var elements = [CollationElement]()
                    for collationElementSubstring in collationElementStrings {
                        if ¬collationElementSubstring.isEmpty {
                            let collationElementText = StrictString(collationElementSubstring)

                            let isVariable = collationElementText.hasPrefix("*".unicodeScalars)

                            let ducetIndices = collationElementText.components(
                                separatedBy: ConditionalPattern({ $0 ∈ Set<UnicodeScalar>([".", "*"]) }))
                                .filter({ ¬$0.range.isEmpty }).map {
                                    (substring: PatternMatch<StrictString>) -> CollationIndex in

                                    let string = String(StrictString(substring.contents))
                                    if let integer = CollationIndex(string, radix: 16) {
                                        maxIndex.increase(to: integer)
                                        return integer
                                    } else {
                                        preconditionFailure("Could not parse hexadecimal: \(string)")
                                    }
                            }
                            assert(ducetIndices.count == 3, "Unexpected number of indices: \(ducetIndices) for line: \(StrictString(line))")
                            if strictCharacters == "א" {
                                assert(ducetIndices[1] == CollationOrder.ducetDefaultAccent, "Missmatched DUCET default case. Expected: \(ducetIndices[1]))")
                                assert(ducetIndices[2] == CollationOrder.ducetDefaultCase, "Missmatched DUCET default case. Expected: \(ducetIndices[2]))")
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
                                indices.append([]) // Ignored primary.
                                indices.append([]) // Ignored reverse accents.
                                indices.append([]) // Ignored forward accents.
                                indices.append([]) // Ignored case.
                                appendDUCET(index: 0, to: &indices) // DUCET punctuation.
                            } else {
                                appendDUCET(index: 0, to: &indices) // DUCET primary.
                                appendPlaceholderIndices(&indices) // Placeholder reverse accents.
                                appendDUCET(index: 1, to: &indices) // DUCET forward accents.
                                appendDUCET(index: 2, to: &indices) // DUCET case.
                                appendDUCET(index: 0, to: &indices) // Reuse DUCET primary to intersort with DUCET punctuation.
                            }
                            appendPlaceholderIndices(&indices) // Placeholder script.

                            assert(indices.count == CollationLevel.allCases.count, "Incorrect number of indices.")

                            elements.append(CollationElement(rawIndices: indices))
                        }
                    }

                    if strictCharacters == CollationResource.ByteOrderMark {
                        assert(CollationResource.ByteOrderMarkIndices == elements, "Missmatched byte order mark indices.")
                    } else {
                        rules[strictCharacters] = elements
                    }

                }
            }
        }

        rules["<_end_>"] = [CollationElement(rawIndices: [[CollationOrder.EndOfStringIndex], [CollationOrder.EndOfStringIndex], [CollationOrder.EndOfStringIndex], [CollationOrder.EndOfStringIndex], [CollationOrder.EndOfStringIndex], [CollationOrder.EndOfStringIndex]])]
        rules["<_final_>"] = [CollationElement(rawIndices: [[CollationOrder.FinalIndex], [CollationOrder.PlaceholderIndex], [CollationOrder.DefaultAccent], [CollationOrder.DefaultCase], [CollationOrder.FinalIndex], [CollationOrder.PlaceholderIndex]])]

        let afterPlaceholder = CollationOrder.PlaceholderIndex.successor()
        rules["<_ReverseAccent_>"] = [CollationElement(rawIndices: [[], [afterPlaceholder], [CollationOrder.DefaultAccent], [CollationOrder.DefaultCase], [], [CollationOrder.PlaceholderIndex]])]
        rules["<_Script_>"] = [CollationElement(rawIndices: [[], [], [], [], [], [afterPlaceholder]])]

        assert(maxIndex == CollationOrder.DUCETMaxIndex, "Missmatched maximum index. Expected \(maxIndex)")

        reportProgress("Finished parsing DUCET.")

        return CollationOrder(rules: rules)
    }
}
#endif
