/*
 APITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import OrderedCollections

import SDGLogic
import SDGMathematics
import SDGCollections

import SDGCornerstoneLocalizations

import XCTest

import SDGMathematicsTestUtilities
import SDGCollectionsTestUtilities
import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

class APITests: TestCase {

  func testAbsoluteComplement() {
    testCustomStringConvertibleConformance(
      of: (1...10)′,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "(0–10)′",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  struct AddablePattern<C>: Addable, SDGCollections.Pattern
  where C: SearchableCollection, C.SubSequence: SearchableCollection {
    // #warning("“C.SubSequence: SearchableCollection” could mean trouble.")
    static func += (precedingValue: inout AddablePattern, followingValue: AddablePattern) {}
    func matches(in collection: C, at location: C.Index) -> [AtomicPatternMatch<C>] {
      return []
    }
    func forSubSequence() -> AddablePattern<C.SubSequence> {
      return AddablePattern<C.SubSequence>()
    }
    func convertMatch(
      from subSequenceMatch: AtomicPatternMatch<C.SubSequence>,
      in collection: Searchable
    ) -> AtomicPatternMatch<C> {
      return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
    }
  }
  func testAddable() {
    _ = AddablePattern<String>() + AddablePattern<String>()
  }

  func testAlternativePatterns() {
    let pattern = [1, 2, 3] ∨ [3, 2, 1]
    SDGCollectionsTestUtilities.testBidirectionalPattern(pattern, match: [1, 2, 3])
    testCustomStringConvertibleConformance(
      of: pattern,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "123 ∨ 321",
      overwriteSpecificationInsteadOfFailing: false
    )

    let naryPattern = NaryAlternativePatterns([[1, 2, 3], [3, 2, 1], [9, 8, 7]])
    SDGCollectionsTestUtilities.testBidirectionalPattern(naryPattern, match: [1, 2, 3])
    testCustomStringConvertibleConformance(
      of: naryPattern,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "123 ∨ 321 ∨ 987",
      overwriteSpecificationInsteadOfFailing: false
    )
    XCTAssertNil([1, 2].firstMatch(for: naryPattern))

    let string = "Hello!"
    let pattern2: AlternativePatterns<String, String> = "Hello" ∨ "!"
    XCTAssertEqual(string.firstMatch(for: pattern2)?.contents, string.dropLast())
    XCTAssertEqual(string.lastMatch(for: pattern2)?.contents, string.dropFirst(5))
    XCTAssertEqual(
      string.dropLast().lastMatch(for: pattern2.forSubSequence())?.contents,
      string.dropLast()
    )
    XCTAssertEqual(string.matches(for: pattern2).count, 2)
    XCTAssertEqual(pattern2.matches(in: string, at: string.startIndex).count, 1)
    XCTAssertEqual(pattern2.matches(in: string, at: string.indices.last!).count, 1)
    XCTAssertEqual("Hello".matches(for: pattern2).count, 1)
    _ = pattern2.description
  }

  func testAnyPattern() {
    let pattern = AnyBidirectionalPattern([1, 2, 3])
    SDGCollectionsTestUtilities.testBidirectionalPattern(pattern, match: [1, 2, 3])
  }

  func testArray() {
    testBidirectionalCollectionConformance(of: [1, 2, 3])
    testRangeReplaceableCollectionConformance(of: [Int].self, element: 0)

    XCTAssert([] ≠ [1])

    var array = [1, 2, 3]
    array += [4, 5, 6]

    XCTAssertEqual(array, [1, 2, 3, 4, 5, 6])
  }

  func testAtomicPatternMatch() {
    let string = "Hello!"
    let match = AtomicPatternMatch(range: string.bounds, in: string)
    XCTAssertEqual(match.contents, string[...])
    XCTAssertEqual(match.range, string.bounds)
    XCTAssertEqual(match.contents, match.in(string[...]).contents)
  }

  func testBidirectionalCollection() {
    let collection = [1, 2, 3, 4, 5, 4, 5, 6]
    let match = collection.lastMatch(for: [4, 5])
    XCTAssertEqual(match?.range, 5..<7)
    XCTAssertEqual(match?.contents.elementsEqual([4, 5]), true)
    XCTAssertNil(collection.lastMatch(for: [−1, −2]))

    let alternativeMatch = collection.lastMatch(for: [1, 3] ∨ [2])
    XCTAssertEqual(alternativeMatch?.range, 1..<2)

    let repetitionMatch = collection.lastMatch(
      for: RepetitionPattern([4, 5], count: 1..<Int.max)
    )
    XCTAssertEqual(repetitionMatch?.range, 3..<7)
    let lazyRepetitionMatch = collection.lastMatch(
      for: RepetitionPattern([4, 5], count: 1..<Int.max, consumption: .lazy)
    )
    XCTAssertEqual(lazyRepetitionMatch?.range, 5..<7)

    let compositeMatchPatternOne = [1, 2]
    let compositeMatchPatternTwo = compositeMatchPatternOne + ([3] ∨ [−3])
    let compositeMatchPattern =
      compositeMatchPatternTwo
      + RepetitionPattern([4, 5], count: 1..<Int.max)
    let compositeMatch = collection.lastMatch(for: compositeMatchPattern)
    XCTAssertEqual(compositeMatch?.range, 0..<7)

    let dangerous = collection.lastMatch(
      for: RepetitionPattern([4, 5], count: 1..<Int.max) + [4, 5]
    )
    XCTAssertEqual(dangerous?.range, 3..<7)

    let alsoDangerous = collection.lastMatch(
      for: RepetitionPattern([4, 5], consumption: .lazy) + [6]
    )
    XCTAssertEqual(alsoDangerous?.range, 7..<8)

    let anotherTrapPatternOne = [1, 2]
    let anotherTrapPatternTwo = anotherTrapPatternOne + RepetitionPattern([−1, −2])
    let anotherTrapPattern = anotherTrapPatternTwo + [3, 4]
    let anotherTrap = collection.lastMatch(for: anotherTrapPattern)
    XCTAssertEqual(anotherTrap?.range, 0..<4)

    let backwardsCollection1 = [0, 0, 0, 0, 0]
    let backwardsPattern1 = [0, 0]
    let backwardsResult1 = backwardsCollection1.lastMatch(for: backwardsPattern1)
    XCTAssertEqual(backwardsResult1?.range, 3..<5)
    let forwardsResult1 = backwardsCollection1.matches(for: backwardsPattern1).last
    XCTAssertEqual(forwardsResult1?.range, 2..<4)

    let backwardsCollection2 = [0, 0, 1]
    let backwardsPattern2 =
      RepetitionPattern([0], count: 1..<Int.max, consumption: .lazy)
      + [1]
    let backwardsResult2 = backwardsCollection2.lastMatch(for: backwardsPattern2)
    XCTAssertEqual(backwardsResult2?.range, 1..<3)
    let forwardsResult2 = backwardsCollection2.matches(for: backwardsPattern2).last
    XCTAssertEqual(forwardsResult2?.range, 0..<3)

    XCTAssertEqual([5, 4, 3, 2, 1].commonSuffix(with: [3, 2, 1]).contents, [3, 2, 1])

    XCTAssertEqual(
      [5, 4, 3, 2, 1].lastMatch(for: ConditionalPattern({ $0.isEven }))?.range,
      3..<4
    )

    XCTAssertEqual([5, 4, 3, 2, 1].lastMatch(for: ¬[3, 2, 1])?.range, 3..<4)

    let advancingCollection = [1, 2, 1, 2, 3]
    var index = advancingCollection.startIndex
    XCTAssert(advancingCollection.advance(&index, over: [1, 2]))
    XCTAssertEqual(index, 2)
    XCTAssertFalse(advancingCollection.advance(&index, over: [2, 3]))
    XCTAssertEqual(index, 2)

    let bounds = collection.bounds
    XCTAssertEqual(collection.forward(collection.backward(bounds)), bounds)
  }

  func testBidirectionalPattern() {
    let string = "Hello!"
    let reversedPattern: String.Reversed = string.reversed()
    let reversedSearchSpace: ReversedCollection<String> = string.reversed()
    guard let reversedMatch = reversedSearchSpace.firstMatch(for: reversedPattern) else {
      XCTFail("Failed to match.")
      return
    }
    let forwardRange = string.forward(reversedMatch.range)
    XCTAssertEqual(forwardRange, string.bounds)
    let forwardMatch = string.forward(match: reversedMatch, in: string)
    XCTAssertEqual(forwardMatch.contents, string[...])
  }

  func testBijectiveMapping() {
    testCollectionConformance(of: BijectiveMapping([1: "1", 2: "2"]))

    let mapping: BijectiveMapping = [1: "1", 2: "2", 3: "3"]

    XCTAssertEqual(mapping[...].count, 3)

    for (x, y) in mapping {
      XCTAssertEqual(mapping[x], y)
      XCTAssertEqual(mapping[y], x)

      XCTAssertEqual(mapping.y(for: x), y)
      XCTAssertEqual(mapping.x(for: y), x)
    }

    for index in mapping.indices {
      let (x, y) = mapping[index]

      XCTAssertEqual(mapping[x], y)
      XCTAssertEqual(mapping[y], x)
    }

    XCTAssertEqual([1, 2, 3].bijectiveIndexMapping.count, 3)
    XCTAssertEqual([1, 2, 3].bijectiveIndexMapping.count, 3)

    _ = mapping.wrappedInstance
  }

  func testClosedRange() {
    let range = 1...10
    XCTAssertEqual(range.map({ Double($0) }), 1...10)
    XCTAssertEqual(range.map({ Double($0) as Double? }), 1...10)

    let closure: (Int) -> Double? = { −Double($0) }
    XCTAssertNil(range.map(closure))
  }

  func testCollection() {
    forAllLegacyModes {
      let collection = [1, 2, 3, 4, 5, 4, 5, 6]
      let match = collection.firstMatch(for: [2, 3])
      XCTAssertEqual(match?.range, 1..<3)
      XCTAssertEqual(match?.contents.elementsEqual([2, 3]), true)
      XCTAssertNil(collection.firstMatch(for: [−1, −2]))

      let alternativeMatch = collection.firstMatch(for: [1, 3] ∨ [2])
      XCTAssertEqual(alternativeMatch?.range, 1..<2)

      let repetitionMatch = collection.firstMatch(
        for: RepetitionPattern([4, 5], count: 1..<Int.max)
      )
      XCTAssertEqual(repetitionMatch?.range, 3..<7)
      let lazyRepetitionMatch = collection.firstMatch(
        for: RepetitionPattern([4, 5], count: 1..<Int.max, consumption: .lazy)
      )
      XCTAssertEqual(lazyRepetitionMatch?.range, 3..<5)

      let compositeMatchPatternOne = [1, 2]
      let compositeMatchPatternTwo = compositeMatchPatternOne + ([3] ∨ [−3])
      let compositeMatchPattern =
        compositeMatchPatternTwo
        + RepetitionPattern([4, 5], count: 1..<Int.max)
      let compositeMatch = collection.firstMatch(for: compositeMatchPattern)
      XCTAssertEqual(compositeMatch?.range, 0..<7)

      let dangerous = collection.firstMatch(
        for: RepetitionPattern([4, 5], count: 1..<Int.max) + [4, 5]
      )
      XCTAssertEqual(dangerous?.range, 3..<7)

      let alsoDangerous = collection.firstMatch(
        for: RepetitionPattern([4, 5], consumption: .lazy) + [6]
      )
      XCTAssertEqual(alsoDangerous?.range, 3..<8)

      let anotherTrapPatternOne = [1, 2]
      let anotherTrapPatternTwo = anotherTrapPatternOne + RepetitionPattern([−1, −2])
      let anotherTrapPattern = anotherTrapPatternTwo + [3, 4]
      let anotherTrap = collection.firstMatch(for: anotherTrapPattern)
      XCTAssertEqual(anotherTrap?.range, 0..<4)

      let equation = "2(3x − (y + 4)) = z"
      let nestingLevel = equation.scalars.firstMatch(
        for: NestingPattern(opening: "(".scalars, closing: ")".scalars)
      )!
      XCTAssertEqual(String(nestingLevel.contents), "(3x − (y + 4))")
      XCTAssertEqual(String(nestingLevel.levelContents.contents), "3x − (y + 4)")
      XCTAssertNil(
        equation.scalars.firstMatch(for: NestingPattern(opening: "[".scalars, closing: "]".scalars))
      )
      XCTAssertNil(
        equation.scalars.firstMatch(for: NestingPattern(opening: "2".scalars, closing: "9".scalars))
      )

      XCTAssertEqual([1, 2, 3, 4].prefix(upTo: [2, 3] ∨ [3, 4])?.range, 0..<1)
      XCTAssertEqual([1, 2, 3, 4].prefix(upTo: [2, 3])?.range, 0..<1)
      XCTAssertEqual([1, 2, 3, 4].prefix(upTo: [2, 3])?.range, 0..<1)
      XCTAssertNil([1, 2, 3, 4].prefix(upTo: [8, 9])?.range)
      XCTAssertNil([1, 2, 3, 4].prefix(upTo: ConditionalPattern({ $0 > 100 })))

      XCTAssertEqual([1, 2, 3, 4].prefix(through: [2, 3] ∨ [3, 4])?.range, 0..<3)
      XCTAssertEqual([1, 2, 3, 4].prefix(through: [2, 3])?.range, 0..<3)
      XCTAssertEqual(
        [1, 2, 3, 4].prefix(
          through: [2, 3])?.range,
        0..<3
      )
      XCTAssertNil([1, 2, 3, 4].prefix(through: [8, 9]))
      XCTAssertNil([1, 2, 3, 4].prefix(through: ConditionalPattern({ $0 > 100 })))

      XCTAssertEqual([1, 2, 3, 4].suffix(from: [2, 3] ∨ [3, 4])?.range, 1..<4)
      XCTAssertEqual([1, 2, 3, 4].suffix(from: [2, 3])?.range, 1..<4)
      XCTAssertEqual([1, 2, 3, 4].suffix(from: [2, 3])?.range, 1..<4)
      XCTAssertNil([1, 2, 3, 4].suffix(from: [8, 9]))
      XCTAssertNil([1, 2, 3, 4].suffix(from: ConditionalPattern({ $0 > 100 })))

      XCTAssertEqual([1, 2, 3, 4].suffix(after: [2, 3] ∨ [3, 4])?.range, 3..<4)
      XCTAssertEqual([1, 2, 3, 4].suffix(after: [2, 3])?.range, 3..<4)
      XCTAssertEqual([1, 2, 3, 4].suffix(after: [2, 3])?.range, 3..<4)
      XCTAssertNil([1, 2, 3, 4].suffix(after: [8, 9]))
      XCTAssertNil([1, 2, 3, 4].suffix(after: ConditionalPattern({ $0 > 100 })))

      XCTAssert(
        [1, 2, 3, 4].components(separatedBy: [2, 3]).map({ Array($0.contents) }).joined()
          .elementsEqual([1, 4])
      )
      XCTAssert(
        [1, 2, 3, 4].components(separatedBy: [2, 3] ∨ [3, 4]).map({ Array($0.contents) }).joined()
          .elementsEqual([1, 4])
      )
      XCTAssert(
        [1, 2, 3, 4].components(separatedBy: [2, 3]).map({ Array($0.contents) }).joined()
          .elementsEqual([1, 4])
      )

      XCTAssert([1, 2, 3, 4].contains([2, 3]))
      XCTAssert([1, 2, 3, 4].contains([2, 3] ∨ [3, 4]))
      XCTAssert([1, 2, 3, 4].contains([2, 3]))

      XCTAssert([1, 2, 3, 4].hasPrefix([1, 2]))
      XCTAssert([1, 2, 3, 4].hasPrefix([1, 2] ∨ [3, 4]))
      XCTAssert([1, 2, 3, 4].hasPrefix([1, 2]))

      XCTAssert([1, 2, 3, 4].isMatch(for: [1, 2, 3, 4]))
      XCTAssert([1, 2, 3, 4].isMatch(for: [1, 2, 3, 4] ∨ [4, 3, 2, 1]))
      XCTAssert([1, 2, 3, 4].isMatch(for: [1, 2, 3, 4]))
      XCTAssert("abcd".isMatch(for: ["a", "b", "c", "d"].literal()))
      XCTAssertFalse("abcd".isMatch(for: ["a", "b", "c"].literal()))
      XCTAssertFalse("abcd".isMatch(for: ["b", "c", "d"].literal()))

      XCTAssert([1, 2, 3, 4].hasSuffix([3, 4]))
      XCTAssert([1, 2, 3, 4].hasSuffix([3, 4] ∨ [5, 6]))
      XCTAssert([1, 2, 3, 4].hasSuffix([3, 4]))

      XCTAssert(AnyBidirectionalCollection([1, 2, 3, 4]).hasSuffix([3, 4].literal()))
      XCTAssert(
        AnyBidirectionalCollection([1, 2, 3, 4]).hasSuffix([3, 4].literal() ∨ [5, 6].literal())
      )
      XCTAssert(
        AnyBidirectionalCollection([1, 2, 3, 4])
          .hasSuffix([3, 4].literal())
      )
      XCTAssert(
        AnyBidirectionalCollection([1, 2, 3, 4]).hasSuffix(
          AnyBidirectionalCollection([1, 2, 3, 4]).literal()
        )
      )

      XCTAssertEqual([5, 4, 3, 2, 1].commonPrefix(with: [5, 2, 1]).contents, [5])

      XCTAssertEqual(
        [5, 4, 3, 2, 1].firstMatch(for: ConditionalPattern({ $0.isEven }))?.range,
        1..<2
      )

      XCTAssertEqual([5, 4, 3, 2, 1].firstMatch(for: ¬[5, 4, 3])?.range, 1..<2)
      XCTAssertEqual(
        [5, 4, 3, 2, 1].firstMatch(for: ¬[5, 4, 3])?.range,
        1..<2
      )

      let compositeRepetition = [5, 4, 5, 4].firstMatch(
        for: RepetitionPattern([5, 4], count: 0..<2, consumption: .greedy)
      )
      XCTAssertEqual(compositeRepetition?.range, 0..<2)
      let compositeRepetition2 = [5, 4, 5, 4, 5].firstMatch(
        for: RepetitionPattern([5, 4], count: 0..<5, consumption: .greedy)
      )
      XCTAssertEqual(compositeRepetition2?.range, 0..<4)
      let compositeRepetition3 = [5, 4, 5, 4, 5].firstMatch(
        for: RepetitionPattern([5, 4], count: 3..<5, consumption: .greedy)
      )
      XCTAssertNil(compositeRepetition3)

      XCTAssertNil([1, 1].firstMatch(for: RepetitionPattern([1], count: 3...3)))

      var aCollection = [1, 2, 3]
      aCollection.insert(contentsOf: [4, 5], at: aCollection.startIndex)
      XCTAssert(aCollection == [4, 5, 1, 2, 3])

      let countableRange: CountableClosedRange<Int>? = nil
      XCTAssertEqual(
        [1, 1, 1].firstMatch(for: RepetitionPattern([1], count: countableRange))?.range,
        [1, 1, 1].bounds
      )
      XCTAssertEqual(
        [1, 1, 1].firstMatch(for: RepetitionPattern([1], count: countableRange))?.range,
        [1, 1, 1].bounds
      )
      XCTAssertEqual(
        [1, 1, 1].firstMatch(
          for: RepetitionPattern([1], count: countableRange)
        )?.range,
        [1, 1, 1].bounds
      )
      XCTAssertEqual(
        [1, 1, 1].firstMatch(
          for: RepetitionPattern(ConditionalPattern({ $0 == 1 }), count: countableRange)
        )?.range,
        [1, 1, 1].bounds
      )

      XCTAssertNil([1].firstMatch(for: RepetitionPattern([1], count: 2...4, consumption: .lazy)))

      XCTAssertEqual(
        [1, 1, 1, 2, 3].firstMatch(for: RepetitionPattern([1], count: 0..<15))?.range,
        [1, 1, 1].bounds
      )
      XCTAssertNil(
        [1, 1, 1, 2, 3].firstMatch(
          for: RepetitionPattern([1], count: 5..<15, consumption: .lazy)
        )
      )

      XCTAssertEqual("ABCDE".scalars.matches(for: ["A", "B", "C"].literal()).count, 1)
      XCTAssertEqual("ABCDE".scalars.prefix(upTo: ["B", "C"].literal())?.contents.count, 1)
      XCTAssertEqual("ABCDE".scalars.prefix(through: ["B", "C"].literal())?.contents.count, 3)
      XCTAssertEqual("ABCDE".scalars.suffix(from: ["B", "C"].literal())?.contents.count, 4)
      XCTAssertEqual("ABCDE".scalars.suffix(after: ["B", "C"].literal())?.contents.count, 2)
      XCTAssertEqual(
        "ABCDE".scalars.firstMatch(
          for: NestingPattern(opening: ["B", "C"].literal(), closing: ["E"].literal())
        )?.levelContents.contents.count,
        1
      )
      let scalars = "ABCDE".scalars
      var mobileIndex = scalars.startIndex
      XCTAssert(scalars.advance(&mobileIndex, over: ["A", "B"].literal()))
      XCTAssertFalse(scalars.advance(&mobileIndex, over: ["A", "B"].literal()))
      XCTAssert(scalars.advance(&mobileIndex, over: ConditionalPattern({ $0 == "C" })))
      XCTAssertFalse(scalars.advance(&mobileIndex, over: ConditionalPattern({ $0 == "C" })))

      let start: [Unicode.Scalar] = [".", ".", "G", "A", "C", "!", "!", ".", "."]
      let end: [Unicode.Scalar] = [".", ".", "A", "G", "C", "A", "T", "?", "?", ".", "."]
      let diff = end.changes(from: start)
      let changed = start.applying(changes: diff)
      XCTAssertEqual(changed, end)

      let startString = "..GAC‐‐!!.."
      let endString = "..AGCAT‐‐??.."
      let diffString = endString.changes(from: startString)
      let changedString = startString.applying(changes: diffString)
      XCTAssertEqual(changedString, endString)

      // Not bidirectional.
      let forwardStart = AnyForwardCollection(startString)
      let forwardEnd = AnyForwardCollection(endString)
      let forwardDiff = forwardEnd.changes(from: forwardStart)
      XCTAssertEqual(forwardDiff, diffString)
      let forwardChanged = forwardStart.applying(changes: forwardDiff)
      XCTAssertEqual(forwardChanged, forwardEnd)

      let set = AnyCollection(Set(endString))
      _ = set.changes(from: startString)
      _ = endString.scalars.changes(from: start)
      _ = AnyCollection(Set(startString)).changes(from: AnyCollection(Set(startString)))

      XCTAssertNil("...".scalars.firstMatch(for: ¬ConditionalPattern({ $0 == "." })))
      XCTAssertNil("...".scalars[...].lastMatch(for: ConditionalPattern({ $0 ≠ "." })))
      XCTAssertNil("...".scalars[...].firstMatch(for: ConditionalPattern({ $0 ≠ "." })))
      XCTAssert("...".scalars[...].matches(for: ConditionalPattern({ $0 ≠ "." })).isEmpty)
    }

    let string = "Hello!"
    XCTAssertEqual(string.ranges(separatedBy: [string.bounds]).count, 2)
  }

  func testCollectionDifference() throws {
    try forAllLegacyModes {
      let start: [String] = [".", ".", "G", "A", "C", "!", "!", ".", "."]
      let end: [String] = [".", ".", "A", "G", "C", "A", "T", "?", "?", ".", "."]
      let shimmedDifference = end.changes(from: start)
      let shimmedMoves = shimmedDifference.inferringMoves()
      let shimmedInverse = shimmedMoves.inverse()
      testCodableConformance(of: shimmedDifference, uniqueTestName: "Difference")
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        let standardDifference = Swift.CollectionDifference(shimmedDifference)
        let standardMoves = standardDifference.inferringMoves()
        let standardInverse = standardMoves.inverse()
        var encoded = try JSONEncoder().encode(shimmedDifference)
        let decodedStandard = try JSONDecoder().decode(
          Swift.CollectionDifference<String>.self,
          from: encoded
        )
        XCTAssertEqual(decodedStandard, standardDifference)

        encoded = try JSONEncoder().encode(standardDifference)
        let decodedShimmed = try JSONDecoder().decode(
          SDGCollections.CollectionDifference<String>.self,
          from: encoded
        )
        XCTAssertEqual(decodedShimmed, shimmedDifference)

        XCTAssertEqual(shimmedMoves, SDGCollections.CollectionDifference(standardMoves))
        XCTAssertEqual(shimmedInverse, SDGCollections.CollectionDifference(standardInverse))
      }
      XCTAssertEqual(SDGCollections.CollectionDifference(shimmedMoves), shimmedMoves)

      var entries: [SDGCollections.CollectionDifference<String>.Change] = [
        .remove(offset: 1, element: "1", associatedWith: nil)
      ]
      XCTAssertNotNil(SDGCollections.CollectionDifference<String>(entries))
      entries = []
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .remove(offset: −1, element: "1", associatedWith: nil)
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .remove(offset: 1, element: "1", associatedWith: −1)
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .remove(offset: 1, element: "1", associatedWith: nil),
        .remove(offset: 1, element: "1", associatedWith: nil),
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .insert(offset: 1, element: "1", associatedWith: nil),
        .insert(offset: 1, element: "1", associatedWith: nil),
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .remove(offset: 1, element: "1", associatedWith: 1)
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .insert(offset: 1, element: "1", associatedWith: 1)
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .insert(offset: 1, element: "1", associatedWith: 1),
        .insert(offset: 2, element: "2", associatedWith: 1),
        .remove(offset: 1, element: "1", associatedWith: 1),
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .remove(offset: 1, element: "1", associatedWith: 1),
        .remove(offset: 2, element: "2", associatedWith: 1),
        .insert(offset: 1, element: "1", associatedWith: 1),
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      entries = [
        .remove(offset: 1, element: "1", associatedWith: 1),
        .remove(offset: 2, element: "2", associatedWith: 1),
        .insert(offset: 2, element: "2", associatedWith: 2),
      ]
      XCTAssertNil(SDGCollections.CollectionDifference<String>(entries))
      testCollectionConformance(of: shimmedDifference)
      testBidirectionalCollectionConformance(of: shimmedDifference)
      testRandomAccessCollectionConformance(of: shimmedDifference)
    }

    withLegacyMode {
      let empty: [String] = []
      XCTAssertNil(
        empty.applying(
          changes: SDGCollections.CollectionDifference([
            .remove(offset: 0, element: " ", associatedWith: nil)
          ])!
        )
      )
      XCTAssertNil(
        empty.applying(
          changes: SDGCollections.CollectionDifference([
            .insert(offset: 1, element: " ", associatedWith: nil)
          ])!
        )
      )
      XCTAssertNotNil(
        empty.applying(
          changes: SDGCollections.CollectionDifference([
            .insert(offset: 0, element: " ", associatedWith: nil)
          ])!
        )
      )
    }
  }

  func testCollectionDifferenceChange() throws {
    try forAllLegacyModes {
      let shimmedEntries: [SDGCollections.CollectionDifference<String>.Change] = [
        .remove(offset: 10, element: "removed element", associatedWith: 20),
        .insert(offset: 30, element: "inserted element", associatedWith: 40),
      ]
      testCodableConformance(of: shimmedEntries, uniqueTestName: "Changes")
      if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
        let standardEntries = shimmedEntries.map { shimmed in
          return Swift.CollectionDifference.Change(shimmed)
        }
        var encoded = try JSONEncoder().encode(shimmedEntries)
        let decodedStandard = try JSONDecoder().decode(
          [Swift.CollectionDifference<String>.Change].self,
          from: encoded
        )
        XCTAssertEqual(decodedStandard, standardEntries)

        encoded = try JSONEncoder().encode(standardEntries)
        let decodedShimmed = try JSONDecoder().decode(
          [SDGCollections.CollectionDifference<String>.Change].self,
          from: encoded
        )
        XCTAssertEqual(decodedShimmed, shimmedEntries)
      }
      for entry in shimmedEntries {
        var copy = entry
        copy.offset = 5
        XCTAssertEqual(copy.offset, 5)
        copy.element = "..."
        XCTAssertEqual(copy.element, "...")
        copy.associatedOffset = 100
        XCTAssertEqual(copy.associatedOffset, 100)
      }
    }
  }

  struct ComparableSetExample: ComparableSet {
    typealias Element = Int
    var set: Set<Int>
    init(_ set: Set<Int>) {
      self.set = set
    }
    static func ∋ (precedingValue: ComparableSetExample, followingValue: Int) -> Bool {
      return precedingValue.set ∋ followingValue
    }
    static func ⊆ (precedingValue: ComparableSetExample, followingValue: ComparableSetExample)
      -> Bool
    {
      return precedingValue.set ⊆ followingValue.set
    }
    func overlaps(_ other: ComparableSetExample) -> Bool {
      return set.overlaps(other.set)
    }
  }
  func testComparableSet() {
    testComparableSetConformance(
      of: ComparableSetExample([1, 2, 3]),
      member: 1,
      nonmember: 10,
      superset: ComparableSetExample([0, 1, 2, 3]),
      overlapping: ComparableSetExample([2, 4]),
      disjoint: ComparableSetExample([−1, −2, −3])
    )
  }

  func testConcatenatedPatterns() {
    let pattern: ConcatenatedPatterns<[Int], [Int]> = [1, 2] + [3]
    SDGCollectionsTestUtilities.testBidirectionalPattern(pattern, match: [1, 2, 3])
    testCustomStringConvertibleConformance(
      of: pattern,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "12 + 3",
      overwriteSpecificationInsteadOfFailing: false
    )

    let naryPattern: NaryConcatenatedPatterns<[Int]> = [[1, 2], [3], [4, 5]]
    SDGCollectionsTestUtilities.testBidirectionalPattern(naryPattern, match: [1, 2, 3, 4, 5])
    testCustomStringConvertibleConformance(
      of: naryPattern,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "12 + 3 + 45",
      overwriteSpecificationInsteadOfFailing: false
    )
    XCTAssertNil([1, 2, 4, 5].firstMatch(for: naryPattern))
    XCTAssertNil([1, 2, 4, 5].firstMatch(for: NaryConcatenatedPatterns([naryPattern])))

    let string = "Hello!"
    let pattern2: ConcatenatedPatterns<String, String> = "Hello" + "!"
    XCTAssertEqual(string.firstMatch(for: pattern2)?.contents, string[string.bounds])
    XCTAssertEqual(string.lastMatch(for: pattern2)?.contents, string[string.bounds])
    XCTAssertEqual(string.matches(for: pattern2).count, 1)
    XCTAssertEqual(pattern2.matches(in: string, at: string.startIndex).count, 1)
    XCTAssertEqual("Hello".matches(for: pattern2).count, 0)
    _ = pattern2.description
  }

  func testConditionalPattern() {
    SDGCollectionsTestUtilities.testBidirectionalPattern(
      ConditionalPattern({ $0 < 10 }),
      match: [0]
    )
    XCTAssert(ConditionalPattern({ $0 < 10 }).matches(in: [11], at: 0).isEmpty)
  }

  func testContextualMapping() {
    let mappingEntries = [
      " ": [],
      "1": [1],
      "2": [2],
      "12": [12],
    ]
    let exhaustive = ContextualMapping<String, [Int]>(exhaustiveMapping: mappingEntries)
    let withFallback = ContextualMapping<String, [Int]>(
      mapping: mappingEntries,
      fallbackAlgorithm: { _ in return [] }
    )

    XCTAssertEqual(exhaustive.map("1 2 12"), [1, 2, 12])
    XCTAssertEqual(withFallback.map("1 2 12 3"), [1, 2, 12])

    let unused = ContextualMapping<String, String>(mapping: [:], fallbackAlgorithm: { String($0) })
    let string = "Hello"
    XCTAssertEqual(unused.map(string), string)
  }

  func testDictionary() {
    let numbers = [
      1: "1",
      2: "2",
      3: "3",
    ]
    let moreNumbers = numbers.mergedByOverwriting(from: [
      3: "three",
      4: "four",
      5: "five",
    ])
    XCTAssertEqual(
      moreNumbers,
      [
        1: "1",
        2: "2",
        3: "three",
        4: "four",
        5: "five",
      ]
    )
    XCTAssert(numbers ≠ moreNumbers)

    let letters = [
      "a": 4,
      "b": 6,
      "c": 3,
    ]
    let moreLetters = [
      "b": 4,
      "c": 5,
      "d": 8,
    ]
    XCTAssertEqual(
      letters.merging(moreLetters, uniquingKeysWith: { $0 + $1 }),
      [
        "a": 4,
        "b": 10,
        "c": 8,
        "d": 8,
      ]
    )

    let numbersToLetters = [
      1: "a",
      2: "b",
      3: "c",
    ]
    let lettersToNumbers = [
      "a": 1,
      "b": 2,
      "c": 3,
    ]
    XCTAssertEqual(numbersToLetters.mapKeyValuePairs({ ($1, $0) }), lettersToNumbers)
    XCTAssertEqual(numbersToLetters.mapKeys({ $0 + 1 }), [2: "a", 3: "b", 4: "c"])
    XCTAssertEqual(lettersToNumbers.mapValues({ $0 + 1 }), ["a": 2, "b": 3, "c": 4])

    var variable: [Int: String] = numbersToLetters
    variable.mutateValue(for: 1) { ($0 ?? "") + "..." }
    XCTAssertEqual(variable[1], "a...")
    variable.mutateValue(for: 4) { ($0 ?? "") + "..." }
    XCTAssertEqual(variable[4], "...")
  }

  struct FiniteSetExample: FiniteSet {
    typealias Element = Int
    var set: Set<Int>
    init(_ set: Set<Int>) {
      self.set = set
    }
    static func ∋ (precedingValue: FiniteSetExample, followingValue: Int) -> Bool {
      return precedingValue.set ∋ followingValue
    }
    var startIndex: Set<Int>.Index {
      return set.startIndex
    }
    var endIndex: Set<Int>.Index {
      return set.endIndex
    }
    func index(after i: Set<Int>.Index) -> Set<Int>.Index {
      return set.index(after: i)
    }
    subscript(_ position: Set<Int>.Index) -> Int {
      return set[position]
    }
  }
  func testFiniteSet() {
    testFiniteSetConformance(
      of: FiniteSetExample([1, 2, 3]),
      member: 1,
      nonmember: 10,
      superset: FiniteSetExample([0, 1, 2, 3]),
      overlapping: FiniteSetExample([2, 4]),
      disjoint: FiniteSetExample([−1, −2, −3])
    )
  }

  func testIntensionalSet() {
    testSetDefinitionConformance(
      of: IntensionalSet<Int>(where: { $0 < 100 }),
      member: 1,
      nonmember: 101
    )
  }

  func testIntersection() {
    testCustomStringConvertibleConformance(
      of: (1...10) ∩ (5...15),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "1–10 ∩ 5–15",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testLexicographicalComparison() {
    let array = [1, 2, 3]
    let comparison = LexicographicalComparison(array)
    _ = comparison.wrappedInstance
    XCTAssertEqual(comparison, comparison)
    XCTAssertFalse(comparison < comparison)
  }

  func testLiteralPattern() {
    let pattern = [1, 2, 3]
    SDGCollectionsTestUtilities.testBidirectionalPattern(pattern, match: [1, 2, 3])
    testCustomStringConvertibleConformance(
      of: pattern,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "123",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  struct MutableSetExample: MutableSet {
    typealias Element = Int
    var set: Set<Int>
    init(_ set: Set<Int>) {
      self.set = set
    }
    static func ∋ (precedingValue: MutableSetExample, followingValue: Int) -> Bool {
      return precedingValue.set ∋ followingValue
    }
    init() {
      set = []
    }
    mutating func insert(_ newMember: Int) -> (inserted: Bool, memberAfterInsert: Int) {
      return set.insert(newMember)
    }
    mutating func remove(_ member: Int) -> Int? {
      return set.remove(member)
    }
    mutating func update(with newMember: Int) -> Int? {
      return set.update(with: newMember)
    }
    static func ⊆ (precedingValue: MutableSetExample, followingValue: MutableSetExample) -> Bool {
      return precedingValue.set ⊆ followingValue.set
    }
    func overlaps(_ other: MutableSetExample) -> Bool {
      return set.overlaps(other.set)
    }
    static func ∩= (precedingValue: inout MutableSetExample, followingValue: MutableSetExample) {
      precedingValue.set ∩= followingValue.set
    }
    static func ∪= (precedingValue: inout MutableSetExample, followingValue: MutableSetExample) {
      precedingValue.set ∪= followingValue.set
    }
    static func ∖= (precedingValue: inout MutableSetExample, followingValue: MutableSetExample) {
      precedingValue.set ∖= followingValue.set
    }
  }
  struct MutableFiniteSetExample: FiniteSet, MutableSet {
    typealias Element = Int
    var set: Set<Int>
    init(_ set: Set<Int>) {
      self.set = set
    }
    static func ∋ (precedingValue: MutableFiniteSetExample, followingValue: Int) -> Bool {
      return precedingValue.set ∋ followingValue
    }
    init() {
      set = []
    }
    mutating func insert(_ newMember: Int) -> (inserted: Bool, memberAfterInsert: Int) {
      return set.insert(newMember)
    }
    mutating func remove(_ member: Int) -> Int? {
      return set.remove(member)
    }
    mutating func update(with newMember: Int) -> Int? {
      return set.update(with: newMember)
    }
    static func ⊆ (precedingValue: MutableFiniteSetExample, followingValue: MutableFiniteSetExample)
      -> Bool
    {
      return precedingValue.set ⊆ followingValue.set
    }
    func overlaps(_ other: MutableFiniteSetExample) -> Bool {
      return set.overlaps(other.set)
    }
    var startIndex: Set<Int>.Index {
      return set.startIndex
    }
    var endIndex: Set<Int>.Index {
      return set.endIndex
    }
    func index(after i: Set<Int>.Index) -> Set<Int>.Index {
      return set.index(after: i)
    }
    subscript(_ position: Set<Int>.Index) -> Int {
      return set[position]
    }
    func contains(_ element: Int) -> Bool {
      return set.contains(element)
    }
    var isEmpty: Bool {
      return set.isEmpty
    }
  }
  func testMutableSet() {
    testMutableSetConformance(of: MutableSetExample.self, a: 1, b: 2, c: 3)
    testMutableSetConformance(of: MutableFiniteSetExample.self, a: 1, b: 2, c: 3)
    XCTAssertEqual(
      MutableFiniteSetExample([1, 2, 3]) ∆ FiniteSetExample([3, 4, 5]),
      MutableFiniteSetExample([1, 2, 4, 5])
    )
  }

  func testNegatedPattern() {
    let pattern = ¬[1]
    SDGCollectionsTestUtilities.testBidirectionalPattern(pattern, match: [2])
    XCTAssert((¬[1]).matches(in: [1], at: 0).isEmpty)

    testCustomStringConvertibleConformance(
      of: pattern,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "¬1",
      overwriteSpecificationInsteadOfFailing: false
    )

    let string = "Hello!"
    let pattern2: NegatedPattern<String> = ¬"Hello"
    XCTAssertEqual(string.firstMatch(for: pattern2)?.contents, string.dropFirst().dropLast(4))
    XCTAssertEqual(string.lastMatch(for: pattern2)?.contents, string.dropFirst(5))
    XCTAssertEqual(string.matches(for: pattern2).count, 5)
    XCTAssertEqual(pattern2.matches(in: string, at: string.startIndex).count, 0)
    XCTAssertEqual(pattern2.matches(in: string, at: string.dropFirst().startIndex).count, 1)
    XCTAssertEqual("Hello".matches(for: pattern2).count, 4)
    _ = pattern2.description
  }

  func testNestingPattern() {
    let string = "...(...(...(...)...(...)...)...(...)...)..."
    let pattern = NestingPattern(opening: "(", closing: ")")
    let match = string.firstMatch(for: pattern)
    XCTAssertEqual(match?.contents, string.dropFirst(3).dropLast(3))
    XCTAssertEqual(match?.levelContents.contents, string.dropFirst(4).dropLast(4))
    let reversedMatch = string.lastMatch(for: pattern)
    XCTAssertEqual(reversedMatch?.contents, string.dropFirst(3).dropLast(3))
    XCTAssertEqual(reversedMatch?.levelContents.contents, string.dropFirst(4).dropLast(4))
    XCTAssertNotNil(pattern.primaryMatch(in: string, at: string.dropFirst(3).startIndex))
    XCTAssertEqual(string.matches(for: pattern).count, 1)
    XCTAssertEqual(pattern.matches(in: string, at: string.dropFirst(3).startIndex).count, 1)
  }

  func testOrderedSet() {
    var set = OrderedCollections.OrderedSet(["a", "b", "c"])
    testComparableSetConformance(
      of: set,
      member: "a",
      nonmember: "d",
      superset: ["a", "b", "c", "d"],
      overlapping: ["a", "d"],
      disjoint: ["d", "e"]
    )
    XCTAssert(set.elements.elementsEqual(["a", "b", "c"]))
    set.removeFirst()
    XCTAssertEqual(set, ["b", "c"])
    set.removeLast()
    XCTAssertEqual(set, ["b"])
    set.append("d")
    XCTAssertEqual(set, ["b", "d"])
    set.append("b")
    XCTAssertEqual(set, ["b", "d"])
    set.append(contentsOf: ["e", "b", "f"])
    XCTAssertEqual(set, ["b", "d", "e", "f"])
    set.removeAll()
    XCTAssertEqual(set, [])
    set.append(contentsOf: ["g", "h", "i"])
    XCTAssertEqual(set, ["g", "h", "i"])
    set.remove("h")
    XCTAssertEqual(set, ["g", "i"])
    set.remove("h")
    XCTAssertEqual(set, ["g", "i"])
    testRandomAccessCollectionConformance(of: set)
    testHashableConformance(differingInstances: (set, ["j", "k", "l"]))
    testComparableConformance(
      less: LexicographicalComparison(set),
      greater: LexicographicalComparison(["m", "n", "o"])
    )
  }

  func testPattern() {
    let string = "Hello!"
    let match = string.primaryMatch(in: string, at: string.startIndex)
    XCTAssertEqual(match?.contents, string[...])
    let matchesAtStart = string.matches(in: string, at: string.startIndex)
    XCTAssertEqual(matchesAtStart.count, 1)
    let matchesInMiddle = string.matches(in: string, at: string.index(after: string.startIndex))
    XCTAssertEqual(matchesInMiddle.count, 0)

    let incomplete = "H"
    XCTAssertNil(string.primaryMatch(in: incomplete, at: incomplete.startIndex))

    let mismatched = "Bonjour !"
    XCTAssertNil(string.primaryMatch(in: mismatched, at: mismatched.startIndex))

    XCTAssertNil(Nothing().primaryMatch(in: string, at: string.startIndex))
    switch string {
    case Nothing():
      XCTFail()
    default:
      break
    }
  }

  struct CustomPattern<C>: BidirectionalPattern, SDGCollections.Pattern
  where
    C: SearchableBidirectionalCollection,
    C.SubSequence: SearchableBidirectionalCollection,
    C.Element == Int
  {
    // #warning("“C.SubSequence: SearchableCollection” could mean trouble.")
    let pattern = [1].literal(for: C.self)
    func matches(in collection: C, at location: C.Index) -> [AtomicPatternMatch<C>] {
      return pattern.matches(in: collection, at: location)
    }
    func forSubSequence() -> APITests.CustomPattern<C.SubSequence> {
      return CustomPattern<C.SubSequence>()
    }
    func convertMatch(
      from subSequenceMatch: AtomicPatternMatch<C.SubSequence>,
      in collection: Searchable
    ) -> AtomicPatternMatch<C> {
      return AtomicPatternMatch(range: subSequenceMatch.range, in: collection)
    }
    func reversed() -> APITests.CustomPattern<ReversedCollection<C>> {
      return CustomPattern<ReversedCollection<C>>()
    }
    func forward(
      match reversedMatch: AtomicPatternMatch<ReversedCollection<C>>,
      in forwardCollection: Searchable
    ) -> AtomicPatternMatch<C> {
      return AtomicPatternMatch(
        range: reversedMatch.range.upperBound.base..<reversedMatch.range.lowerBound.base,
        in: forwardCollection
      )
    }
  }
  func testPatternClassCluster() {
    SDGCollectionsTestUtilities.testBidirectionalPattern(CustomPattern(), match: [1])
  }

  func testRange() {
    testHashableConformance(differingInstances: (0..<1, 1..<2))
    testComparableSetConformance(
      of: 1..<10 as Range,
      member: 1,
      nonmember: 10,
      superset: 1..<20,
      overlapping: 5..<15,
      disjoint: 11..<20
    )
    testComparableSetConformance(
      of: 1...10 as ClosedRange,
      member: 1,
      nonmember: 11,
      superset: 1...20,
      overlapping: 5...15,
      disjoint: 11...20
    )
    testComparableSetConformance(
      of: 1..<10 as CountableRange,
      member: 1,
      nonmember: 10,
      superset: 1..<20,
      overlapping: 5..<15,
      disjoint: 11..<20
    )
    testComparableSetConformance(
      of: 1...10 as CountableClosedRange,
      member: 1,
      nonmember: 11,
      superset: 1...20,
      overlapping: 5...15,
      disjoint: 11...20
    )
  }

  func testRangeReplaceableCollection() {
    let start = [1, 2, 3]
    let appendix = [4, 5]
    let result = [1, 2, 3, 4, 5]
    let element = 0
    let withElementAppended = [1, 2, 3, 0]
    let withElementPrepended = [0, 1, 2, 3]
    let withAppendixPrepended = [4, 5, 1, 2, 3]
    let truncatingIndex = 1
    let truncated = [1]

    var collection = start
    collection += appendix
    XCTAssert(collection.elementsEqual(result))

    XCTAssert(start.appending(contentsOf: appendix).elementsEqual(result))
    XCTAssert(start.appending(element).elementsEqual(withElementAppended))

    XCTAssert(start.prepending(contentsOf: appendix).elementsEqual(withAppendixPrepended))
    XCTAssert(start.prepending(element).elementsEqual(withElementPrepended))

    XCTAssert(start.truncated(at: truncatingIndex).elementsEqual(truncated))

    collection = [1, 2, 3, 4, 5]

    var mutable = collection
    mutable.prepend(0)
    XCTAssertEqual(mutable, [0, 1, 2, 3, 4, 5])

    mutable = collection
    mutable.prepend(contentsOf: [0])
    XCTAssertEqual(mutable, [0, 1, 2, 3, 4, 5])

    mutable = collection
    mutable.truncate(at: 2)
    XCTAssertEqual(mutable, [1, 2])

    mutable = collection
    mutable.fill(to: 7, with: 0, from: .start)
    XCTAssertEqual(mutable, [0, 0, 1, 2, 3, 4, 5])

    mutable = collection
    mutable.fill(to: 7, with: 0, from: .end)
    XCTAssertEqual(mutable, [1, 2, 3, 4, 5, 0, 0])

    XCTAssertEqual(collection.filled(to: 7, with: 0, from: .start), [0, 0, 1, 2, 3, 4, 5])

    mutable = collection
    mutable.truncate(before: [2, 3])
    XCTAssertEqual(mutable, [1])

    mutable = collection
    mutable.truncate(before: [2, 3])
    XCTAssertEqual(mutable, [1])

    mutable = collection
    mutable.truncate(after: [2, 3])
    XCTAssertEqual(mutable, [1, 2, 3])

    mutable = collection
    mutable.truncate(after: [2, 3])
    XCTAssertEqual(mutable, [1, 2, 3])

    mutable = collection
    mutable.drop(upTo: [2, 3])
    XCTAssertEqual(mutable, [2, 3, 4, 5])

    mutable = collection
    mutable.drop(upTo: [2, 3])
    XCTAssertEqual(mutable, [2, 3, 4, 5])

    mutable = collection
    mutable.drop(through: [2, 3])
    XCTAssertEqual(mutable, [4, 5])

    mutable = collection
    mutable.drop(through: [2, 3])
    XCTAssertEqual(mutable, [4, 5])

    mutable = collection
    mutable.drop(upTo: [5, 6])
    XCTAssertEqual(mutable, [])

    mutable = collection
    mutable.drop(through: [5, 6])
    XCTAssertEqual(mutable, [])

    var text = [
      "5",
      "75",
      "876",
    ].map { $0.scalars }
    let equalized = [
      "005",
      "075",
      "876",
    ]
    XCTAssertEqual(
      text.countsEqualized(byFillingWith: "0", from: .start).map({ String($0) }),
      equalized
    )
    text.equalizeCounts(byFillingWith: "0", from: .start)
    XCTAssertEqual(text.map({ String($0) }), equalized)

    XCTAssertEqual(collection.truncated(before: [3, 4]), [1, 2])
    XCTAssertEqual(collection.truncated(before: [3, 4]), [1, 2])
    XCTAssertEqual([1, 2].truncated(before: ConditionalPattern({ $0 == 1 })), [])
    XCTAssertEqual(collection.truncated(after: [3, 4]), [1, 2, 3, 4])
    XCTAssertEqual(collection.truncated(after: [3, 4]), [1, 2, 3, 4])
    XCTAssertEqual([1, 2].truncated(after: ConditionalPattern({ $0 == 1 })), [1])
    XCTAssertEqual(collection.dropping(upTo: [3, 4]), [3, 4, 5])
    XCTAssertEqual(collection.dropping(upTo: [3, 4]), [3, 4, 5])
    XCTAssertEqual([1, 2].dropping(upTo: ConditionalPattern({ $0 == 3 })), [])
    XCTAssertEqual(collection.dropping(through: [3, 4]), [5])
    XCTAssertEqual(collection.dropping(through: [3, 4]), [5])
    XCTAssertEqual([1, 2].dropping(through: ConditionalPattern({ $0 == 3 })), [])

    XCTAssertEqual(collection.replacingMatches(for: [3, 4], with: [0]), [1, 2, 0, 5])
    XCTAssertEqual(collection.replacingMatches(for: [3, 4], with: [0]), [1, 2, 0, 5])
    XCTAssertEqual(
      [1, 2, 3, 4].replacingMatches(for: ConditionalPattern({ $0 < 4 }), with: [0]),
      [0, 0, 0, 4]
    )

    mutable = collection
    mutable.replaceMatches(for: [3, 4], with: [0])
    XCTAssertEqual(mutable, [1, 2, 0, 5])

    XCTAssertEqual(
      collection.mutatingMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) }),
      [1, 2, 4, 5, 5]
    )
    XCTAssertEqual(
      collection.mutatingMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) }),
      [1, 2, 4, 5, 5]
    )
    XCTAssertEqual(
      [1, 2, 3, 4].mutatingMatches(
        for: ConditionalPattern({ $0 < 4 }),
        mutation: { _ in return [0] }
      ),
      [0, 0, 0, 4]
    )

    mutable = collection
    mutable.mutateMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) })
    XCTAssertEqual(mutable, [1, 2, 4, 5, 5])

    mutable = collection
    mutable.mutateMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) })
    XCTAssertEqual(mutable, [1, 2, 4, 5, 5])

    let scalars = "ABCDE".scalars
    var mutableScalars = scalars
    mutableScalars.truncate(before: ["E"].literal())
    XCTAssert(scalars.truncated(before: ["E"].literal()).elementsEqual("ABCD".scalars))
    mutableScalars.truncate(after: ["C"].literal())
    XCTAssert(scalars.truncated(after: ["C"].literal()).elementsEqual("ABC".scalars))
    mutableScalars.drop(upTo: ["B"].literal())
    XCTAssert(scalars.dropping(upTo: ["B"].literal()).elementsEqual("BCDE".scalars))
    mutableScalars.drop(through: ["B"].literal())
    XCTAssert(scalars.dropping(through: ["B"].literal()).elementsEqual("CDE".scalars))
    XCTAssert(
      scalars.replacingMatches(for: ["B", "C"].literal(), with: "x".scalars)
        .elementsEqual("AxDE".scalars)
    )
    mutableScalars.mutateMatches(for: ["C"].literal()) { _ in "".scalars }
    XCTAssert(mutableScalars.elementsEqual([]))
    XCTAssert(
      scalars.mutatingMatches(for: ["B", "C"].literal(), mutation: { _ in return "x".scalars })
        .elementsEqual("AxDE".scalars)
    )

    XCTAssertEqual("ABC", String(arrayLiteral: "A", "B", "C"))

    mutable = collection
    mutable.replaceSubrange(mutable.startIndex..., with: [0])
    XCTAssertEqual(mutable, [0])
  }

  func testRepetitionPattern() {
    SDGCollectionsTestUtilities.testBidirectionalPattern(
      RepetitionPattern([1, 2, 3]),
      match: [1, 2, 3, 1, 2, 3]
    )
  }

  func testReversedCollection() {
    let string = "Hello!"
    let reversed: ReversedCollection<String> = string.reversed()
    XCTAssertEqual(
      (reversed.firstMatch(for: reversed)?.contents).map({ Array($0) }),
      Array(reversed)
    )
    XCTAssertEqual(reversed.matches(for: reversed).count, 1)
    XCTAssertEqual(reversed[...].matches(for: reversed[...]).count, 1)
    XCTAssertNotNil(reversed.lastMatch(for: reversed))
  }

  func testSearchableBidirectionalCollection() {
    let string = "Hello!"
    let reverseMatch = string.lastMatch(for: string)
    XCTAssertEqual(reverseMatch?.contents, string[...])

    let mismatched = "Bonjour !"
    XCTAssertNil(string.lastMatch(for: mismatched))
    XCTAssertNil(string.lastMatch(for: Nothing()))

    let literalExpressible: Substring = "Hello?"
    XCTAssertNil(literalExpressible.lastMatch(for: "Hello!"))

    XCTAssert(string.hasSuffix(string))
    XCTAssertFalse(string.hasSuffix(Nothing()))
    XCTAssert(string[...].hasSuffix(string[...]))

    XCTAssertEqual(string.commonSuffix(with: "Hallo!").contents, "llo!"[...])
    XCTAssertEqual(string.commonSuffix(with: "Hallo!"[...]).contents, "llo!"[...])
  }

  func testSearchableCollection() {
    let string = "Hello!"
    let subMatch = string.forSubSequence().primaryMatch(in: string[...], at: string.startIndex)
    let match = subMatch.map { string.convertMatch(from: $0, in: string) }
    XCTAssertEqual(match?.contents, string[...])

    XCTAssertEqual(string.firstMatch(for: "e")?.contents, "e"[...])
    XCTAssertNil(string.firstMatch(for: Nothing()))

    XCTAssertEqual(string.matches(for: "l").count, 2)
    XCTAssertEqual(string.matches(for: Nothing()).count, 0)

    XCTAssertEqual(string.prefix(upTo: "l")?.contents, string.dropLast(4))
    XCTAssertNil(string.prefix(upTo: Nothing()))
    XCTAssertEqual(string.prefix(through: "l")?.contents, string.dropLast(3))
    XCTAssertNil(string.prefix(through: Nothing()))
    XCTAssertEqual(string.suffix(from: "l")?.contents, string.dropFirst(2))
    XCTAssertNil(string.suffix(from: Nothing()))
    XCTAssertEqual(string.suffix(after: "l")?.contents, string.dropFirst(3))
    XCTAssertNil(string.suffix(after: Nothing()))
    XCTAssertEqual(string.components(separatedBy: "l").count, 3)
    XCTAssertEqual(
      string.components(separatedBy: "l").filter({ $0.contents.contains("l") }).count,
      0
    )
    XCTAssertEqual(string.components(separatedBy: Nothing()).count, 1)

    XCTAssert(string.contains(string))
    XCTAssert(string.hasPrefix(string))
    XCTAssert(string.isMatch(for: string))
    XCTAssertFalse(string.contains(Nothing()))
    XCTAssertFalse(string.hasPrefix(Nothing()))
    XCTAssertFalse(string.isMatch(for: Nothing()))
    XCTAssert(string.unicodeScalars.hasPrefix(string.unicodeScalars))
    XCTAssert(string.isMatch(for: "∅" ∨ string))

    XCTAssertEqual(string.commonPrefix(with: "Hallo!").contents, "H"[...])
    XCTAssertEqual(string.commonPrefix(with: "Hallo!"[...]).contents, "H"[...])

    var index = string.startIndex
    XCTAssertTrue(string.advance(&index, over: "Hello"))
    XCTAssertEqual(string[index...], string.dropFirst(5))
    XCTAssertFalse(string.advance(&index, over: Nothing()))
  }

  func testSet() {
    testFiniteSetConformance(
      of: Set([1, 2, 3]),
      member: 1,
      nonmember: 0,
      superset: [1, 2, 3, 4, 5],
      overlapping: [1, 3, 5],
      disjoint: [7, 8, 9]
    )
    testMutableSetConformance(of: Set<Int>.self, a: 1, b: 2, c: 3)
  }

  struct SetInRepresentableUniverseExample: SetInRepresentableUniverse {
    typealias Element = Int
    var set: Set<Int>
    init(_ set: Set<Int>) {
      self.set = set
    }
    static func ∋ (precedingValue: SetInRepresentableUniverseExample, followingValue: Int) -> Bool {
      return precedingValue.set ∋ followingValue
    }
    init() {
      set = []
    }
    mutating func insert(_ newMember: Int) -> (inserted: Bool, memberAfterInsert: Int) {
      return set.insert(newMember)
    }
    mutating func remove(_ member: Int) -> Int? {
      return set.remove(member)
    }
    mutating func update(with newMember: Int) -> Int? {
      return set.update(with: newMember)
    }
    static func ⊆ (
      precedingValue: SetInRepresentableUniverseExample,
      followingValue: SetInRepresentableUniverseExample
    ) -> Bool {
      return precedingValue.set ⊆ followingValue.set
    }
    func overlaps(_ other: SetInRepresentableUniverseExample) -> Bool {
      return set.overlaps(other.set)
    }
    static func ∩= (
      precedingValue: inout SetInRepresentableUniverseExample,
      followingValue: SetInRepresentableUniverseExample
    ) {
      precedingValue.set ∩= followingValue.set
    }
    static func ∪= (
      precedingValue: inout SetInRepresentableUniverseExample,
      followingValue: SetInRepresentableUniverseExample
    ) {
      precedingValue.set ∪= followingValue.set
    }
    static func ∖= (
      precedingValue: inout SetInRepresentableUniverseExample,
      followingValue: SetInRepresentableUniverseExample
    ) {
      precedingValue.set ∖= followingValue.set
    }
    static let universe = SetInRepresentableUniverseExample([1, 2, 3, 4, 5])
  }
  func testSetInRepresentableUniverse() {
    testSetInRepresentableUniverseConformance(
      of: SetInRepresentableUniverseExample.self,
      a: 1,
      b: 2,
      c: 3
    )
  }

  func testSlice() {
    let string = "Hello!"
    let slice = Slice(base: "Hello!", bounds: string.dropLast().bounds)
    XCTAssertEqual((slice.firstMatch(for: slice)?.contents).map({ Array($0) }), Array(slice))
    XCTAssertEqual(slice[...].matches(for: slice[...]).count, 1)
    XCTAssertNotNil(slice.lastMatch(for: slice))
  }

  func testString() {
    let string = "Hello!"

    XCTAssertEqual(string[...].matches(for: "l"[...]).count, 2)
    XCTAssertEqual(string.unicodeScalars.matches(for: "l".unicodeScalars).count, 2)
    XCTAssertEqual(string.unicodeScalars[...].matches(for: "l".unicodeScalars[...]).count, 2)
    XCTAssertEqual(string.utf8.matches(for: "l".utf8).count, 2)
    XCTAssertEqual(string.utf8[...].matches(for: "l".utf8[...]).count, 2)
    XCTAssertEqual(string.utf16.matches(for: "l".utf16).count, 2)
    XCTAssertEqual(string.utf16[...].matches(for: "l".utf16[...]).count, 2)

    XCTAssertNotNil(string.lastMatch(for: "l"))
    XCTAssertNotNil(string[...].lastMatch(for: "l"[...]))
    XCTAssertNotNil(string.unicodeScalars.lastMatch(for: "l".unicodeScalars))
    XCTAssertNotNil(string.unicodeScalars[...].lastMatch(for: "l".unicodeScalars[...]))
    XCTAssertNotNil(string.utf8.lastMatch(for: "l".utf8))
    XCTAssertNotNil(string.utf8[...].lastMatch(for: "l".utf8[...]))
    XCTAssertNotNil(string.utf16.lastMatch(for: "l".utf16))
    XCTAssertNotNil(string.utf16[...].lastMatch(for: "l".utf16[...]))
  }

  func testSymmetricDifference() {
    testSetDefinitionConformance(
      of: IntensionalSet(where: { $0.isEven }) ∆ (1...100),
      member: 1,
      nonmember: 2
    )
  }

  func testUnion() {
    testCustomStringConvertibleConformance(
      of: 1...3 ∪ 7...9,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "1–3 ∪ 7–9",
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
