/*
 CollectionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class CollectionTests : TestCase {

    func testArray() {
        XCTAssert([] ≠ [1])

        var array = [1, 2, 3]
        array += [4, 5, 6]

        XCTAssertEqual(array, [1, 2, 3, 4, 5, 6])
    }

    func testBidirectionalCollection() {
        let collection = [1, 2, 3, 4, 5, 4, 5, 6]
        let match = collection.lastMatch(for: [4, 5])
        XCTAssertEqual(match?.range, 5 ..< 7)
        XCTAssertEqual(match?.contents.elementsEqual([4, 5]), true)
        XCTAssertNil(collection.lastMatch(for: [−1, −2]))

        let alternativeMatch = collection.lastMatch(for: AlternativePatterns([
            LiteralPattern([1, 3]),
            LiteralPattern([2])
            ]))
        XCTAssertEqual(alternativeMatch?.range, 1 ..< 2)

        let repetitionMatch = collection.lastMatch(for: RepetitionPattern([4, 5], count: 1 ..< Int.max))
        XCTAssertEqual(repetitionMatch?.range, 3 ..< 7)
        let lazyRepetitionMatch = collection.lastMatch(for: RepetitionPattern([4, 5], count: 1 ..< Int.max, consumption: .lazy))
        XCTAssertEqual(lazyRepetitionMatch?.range, 5 ..< 7)

        let compositeMatch = collection.lastMatch(for: [LiteralPattern([1, 2]), AlternativePatterns([3, −3]), RepetitionPattern([4, 5], count: 1 ..< Int.max)])
        XCTAssertEqual(compositeMatch?.range, 0 ..< 7)

        let dangerous = collection.lastMatch(for: [RepetitionPattern([4, 5], count: 1 ..< Int.max), LiteralPattern([4, 5])])
        XCTAssertEqual(dangerous?.range, 3 ..< 7)

        let alsoDangerous = collection.lastMatch(for: [RepetitionPattern([4, 5], consumption: .lazy), LiteralPattern([6])])
        XCTAssertEqual(alsoDangerous?.range, 7 ..< 8)

        let anotherTrap = collection.lastMatch(for: [LiteralPattern([1, 2]), RepetitionPattern([−1, −2]), LiteralPattern([3, 4])])
        XCTAssertEqual(anotherTrap?.range, 0 ..< 4)

        let backwardsCollection1 = [0, 0, 0, 0, 0]
        let backwardsPattern1 = [0, 0]
        let backwardsResult1 = backwardsCollection1.lastMatch(for: backwardsPattern1)
        XCTAssertEqual(backwardsResult1?.range, 3 ..< 5)
        let forwardsResult1 = backwardsCollection1.matches(for: backwardsPattern1).last
        XCTAssertEqual(forwardsResult1?.range, 2 ..< 4)

        let backwardsCollection2 = [0, 0, 1]
        let backwardsPattern2 = CompositePattern([RepetitionPattern([0], count: 1 ..< Int.max, consumption: .lazy), LiteralPattern([1])])
        let backwardsResult2 = backwardsCollection2.lastMatch(for: backwardsPattern2)
        XCTAssertEqual(backwardsResult2?.range, 1 ..< 3)
        let forwardsResult2 = backwardsCollection2.matches(for: backwardsPattern2).last
        XCTAssertEqual(forwardsResult2?.range, 0 ..< 3)

        XCTAssertEqual([5, 4, 3, 2, 1].commonSuffix(with: [3, 2, 1]).contents, [3, 2, 1])

        XCTAssertEqual([5, 4, 3, 2, 1].lastMatch(for: ConditionalPattern(condition: { $0.isEven }))?.range, 3 ..< 4)

        XCTAssertEqual([5, 4, 3, 2, 1].lastMatch(for: NotPattern([3, 2, 1]))?.range, 3 ..< 4)

        let advancingCollection = [1, 2, 1, 2, 3]
        var index = advancingCollection.startIndex
        XCTAssert(advancingCollection.advance(&index, over: [1, 2]))
        XCTAssertEqual(index, 2)
        XCTAssertFalse(advancingCollection.advance(&index, over: [LiteralPattern([2]), LiteralPattern([3])]))
        XCTAssertEqual(index, 2)
    }

    func testBijectiveMapping() {
        let mapping: BijectiveMapping = [1: "1", 2: "2", 3: "3"]

        XCTAssertEqual(mapping[mapping.bounds].count, 3)

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
    }

    func testCollection() {
        let collection = [1, 2, 3, 4, 5, 4, 5, 6]
        let match = collection.firstMatch(for: [2, 3])
        XCTAssertEqual(match?.range, 1 ..< 3)
        XCTAssertEqual(match?.contents.elementsEqual([2, 3]), true)
        XCTAssertNil(collection.firstMatch(for: [−1, −2]))

        let alternativeMatch = collection.firstMatch(for: AlternativePatterns([
            LiteralPattern([1, 3]),
            LiteralPattern([2])
            ]))
        XCTAssertEqual(alternativeMatch?.range, 1 ..< 2)

        let repetitionMatch = collection.firstMatch(for: RepetitionPattern([4, 5], count: 1 ..< Int.max))
        XCTAssertEqual(repetitionMatch?.range, 3 ..< 7)
        let lazyRepetitionMatch = collection.firstMatch(for: RepetitionPattern([4, 5], count: 1 ..< Int.max, consumption: .lazy))
        XCTAssertEqual(lazyRepetitionMatch?.range, 3 ..< 5)

        let compositeMatch = collection.firstMatch(for: [LiteralPattern([1, 2]), AlternativePatterns([3, −3]), RepetitionPattern([4, 5], count: 1 ..< Int.max)])
        XCTAssertEqual(compositeMatch?.range, 0 ..< 7)

        let dangerous = collection.firstMatch(for: [RepetitionPattern([4, 5], count: 1 ..< Int.max), LiteralPattern([4, 5])])
        XCTAssertEqual(dangerous?.range, 3 ..< 7)

        let alsoDangerous = collection.firstMatch(for: [RepetitionPattern([4, 5], consumption: .lazy), LiteralPattern([6])])
        XCTAssertEqual(alsoDangerous?.range, 3 ..< 8)

        let anotherTrap = collection.firstMatch(for: [LiteralPattern([1, 2]), RepetitionPattern([−1, −2]), LiteralPattern([3, 4])])
        XCTAssertEqual(anotherTrap?.range, 0 ..< 4)

        let equation = "2(3x − (y + 4)) = z"
        let nestingLevel = equation.scalars.firstNestingLevel(startingWith: "(".scalars, endingWith: ")".scalars)!
        XCTAssertEqual(String(nestingLevel.container.contents), "(3x − (y + 4))")
        XCTAssertEqual(String(nestingLevel.contents.contents), "3x − (y + 4)")
        XCTAssertNil(equation.scalars.firstNestingLevel(startingWith: "[".scalars, endingWith: "]".scalars))
        XCTAssertNil(equation.scalars.firstNestingLevel(startingWith: "2".scalars, endingWith: "9".scalars))

        XCTAssertEqual([1, 2, 3, 4].prefix(upTo: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 0 ..< 1)
        XCTAssertEqual([1, 2, 3, 4].prefix(upTo: [2, 3])?.range, 0 ..< 1)
        XCTAssertEqual([1, 2, 3, 4].prefix(upTo: [LiteralPattern([2]), LiteralPattern([3])])?.range, 0 ..< 1)
        XCTAssertNil([1, 2, 3, 4].prefix(upTo: [8, 9])?.range)

        XCTAssertEqual([1, 2, 3, 4].prefix(through: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 0 ..< 3)
        XCTAssertEqual([1, 2, 3, 4].prefix(through: [2, 3])?.range, 0 ..< 3)
        XCTAssertEqual([1, 2, 3, 4].prefix(through: [LiteralPattern([2]), LiteralPattern([3])])?.range, 0 ..< 3)
        XCTAssertNil([1, 2, 3, 4].prefix(through: [8, 9]))

        XCTAssertEqual([1, 2, 3, 4].suffix(from: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 1 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(from: [2, 3])?.range, 1 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(from: [LiteralPattern([2]), LiteralPattern([3])])?.range, 1 ..< 4)
        XCTAssertNil([1, 2, 3, 4].suffix(from: [8, 9]))

        XCTAssertEqual([1, 2, 3, 4].suffix(after: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 3 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(after: [2, 3])?.range, 3 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(after: [LiteralPattern([2]), LiteralPattern([3])])?.range, 3 ..< 4)
        XCTAssertNil([1, 2, 3, 4].suffix(after: [8, 9]))

        XCTAssert([1, 2, 3, 4].components(separatedBy: [2, 3]).map({ Array($0.contents) }).joined().elementsEqual([1, 4]))
        XCTAssert([1, 2, 3, 4].components(separatedBy: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])])).map({ Array($0.contents) }).joined().elementsEqual([1, 4]))
        XCTAssert([1, 2, 3, 4].components(separatedBy: [LiteralPattern([2]), LiteralPattern([3])]).map({ Array($0.contents) }).joined().elementsEqual([1, 4]))

        XCTAssert([1, 2, 3, 4].contains([2, 3]))
        XCTAssert([1, 2, 3, 4].contains(AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])])))
        XCTAssert([1, 2, 3, 4].contains([LiteralPattern([2]), LiteralPattern([3])]))

        XCTAssert([1, 2, 3, 4].hasPrefix([1, 2]))
        XCTAssert([1, 2, 3, 4].hasPrefix(AlternativePatterns([LiteralPattern([1, 2]), LiteralPattern([3, 4])])))
        XCTAssert([1, 2, 3, 4].hasPrefix([LiteralPattern([1]), LiteralPattern([2])]))

        XCTAssert([1, 2, 3, 4].hasSuffix([3, 4]))
        XCTAssert([1, 2, 3, 4].hasSuffix(AlternativePatterns([LiteralPattern([3, 4]), LiteralPattern([5, 6])])))
        XCTAssert([1, 2, 3, 4].hasSuffix([LiteralPattern([3]), LiteralPattern([4])]))

        XCTAssertEqual([5, 4, 3, 2, 1].commonPrefix(with: [5, 2, 1]).contents, [5])

        XCTAssertEqual([5, 4, 3, 2, 1].firstMatch(for: ConditionalPattern(condition: { $0.isEven }))?.range, 1 ..< 2)

        XCTAssertEqual([5, 4, 3, 2, 1].firstMatch(for: NotPattern([5, 4, 3]))?.range, 1 ..< 2)
        XCTAssertEqual([5, 4, 3, 2, 1].firstMatch(for: NotPattern(CompositePattern([LiteralPattern([5]), LiteralPattern([4]), LiteralPattern([3])])))?.range, 1 ..< 2)

        let compositeRepetition = [5, 4, 5, 4].firstMatch(for: RepetitionPattern(CompositePattern([LiteralPattern([5]), LiteralPattern([4])]), count: 0 ..< 2, consumption: .greedy))
        XCTAssertEqual(compositeRepetition?.range, 0 ..< 2)
        let compositeRepetition2 = [5, 4, 5, 4, 5].firstMatch(for: RepetitionPattern(CompositePattern([LiteralPattern([5]), LiteralPattern([4])]), count: 0 ..< 5, consumption: .greedy))
        XCTAssertEqual(compositeRepetition2?.range, 0 ..< 4)
        let compositeRepetition3 = [5, 4, 5, 4, 5].firstMatch(for: RepetitionPattern(CompositePattern([LiteralPattern([5]), LiteralPattern([4])]), count: 3 ..< 5, consumption: .greedy))
        XCTAssertNil(compositeRepetition3)

        XCTAssertNil([1, 1].firstMatch(for: RepetitionPattern([1], count: 3 ... 3)))

        var aCollection = [1, 2, 3]
        aCollection.insert(contentsOf: [4, 5], at: aCollection.startIndex)
        XCTAssert(aCollection == [4, 5, 1, 2, 3])

        let countableRange: CountableClosedRange<Int>? = nil
        XCTAssertEqual([1, 1, 1].firstMatch(for: RepetitionPattern([1], count: countableRange))?.range, [1, 1, 1].bounds)
        XCTAssertEqual([1, 1, 1].firstMatch(for: RepetitionPattern(LiteralPattern([1]), count: countableRange))?.range, [1, 1, 1].bounds)
        XCTAssertEqual([1, 1, 1].firstMatch(for: RepetitionPattern(CompositePattern([LiteralPattern([1])]), count: countableRange))?.range, [1, 1, 1].bounds)
        XCTAssertEqual([1, 1, 1].firstMatch(for: RepetitionPattern(ConditionalPattern(condition: { $0 == 1 }), count: countableRange))?.range, [1, 1, 1].bounds)

        XCTAssertNil([1].firstMatch(for: RepetitionPattern([1], count: 2 ... 4, consumption: .lazy)))

        XCTAssertEqual([1, 1, 1, 2, 3].firstMatch(for: RepetitionPattern(LiteralPattern([1]), count: 0 ..< 15))?.range, [1, 1, 1].bounds)
        XCTAssertNil([1, 1, 1, 2, 3].firstMatch(for: RepetitionPattern(LiteralPattern([1]), count: 5 ..< 15, consumption: .lazy)))
    }

    func testComparableSet() {
        func runTests<S : ComparableSet>(superset: S, subset: S) {
            XCTAssert(superset ⊈ subset, "\(superset) ⊆ \(subset)")
            XCTAssert(superset ⊇ subset, "\(superset) ⊉ \(subset)")
            XCTAssert(subset ⊉ superset, "\(subset) ⊇ \(superset)")
            XCTAssert(superset ⊋ subset, "\(superset) ⊋̸ \(subset)")
            XCTAssert(subset ⊊ superset, "\(subset) ⊊̸ \(superset)")
            XCTAssert(¬superset.isDisjoint(with: subset), "\(superset).isDisjoint(with: \(subset))")
            XCTAssertNotEqual(superset, subset)
        }

        runTests(superset: Set([1, 2, 3]), subset: Set([1, 2]))
        runTests(superset: CharacterSet.alphanumerics, subset: CharacterSet.uppercaseLetters)
        runTests(superset: 0 ..< 10, subset: 3 ..< 8)
        runTests(superset: (0 ... 10) as ClosedRange, subset: 3 ... 8)
        runTests(superset: (0 ..< 10) as CountableRange, subset: 3 ..< 8)
        runTests(superset: (0 ... 10) as CountableClosedRange, subset: 3 ... 8)
        runTests(superset: MutableSetExample([1, 2, 3]), subset: MutableSetExample([1, 2]))
    }

    func testDictionary() {
        let numbers = [
            1: "1",
            2: "2",
            3: "3"
        ]
        let moreNumbers = numbers.mergedByOverwriting(from: [
            3: "three",
            4: "four",
            5: "five"
            ])
        XCTAssertEqual(moreNumbers, [
            1: "1",
            2: "2",
            3: "three",
            4: "four",
            5: "five"
            ])
        XCTAssert(numbers ≠ moreNumbers)

        let letters = [
            "a": 4,
            "b": 6,
            "c": 3
        ]
        let moreLetters = [
            "b": 4,
            "c": 5,
            "d": 8
        ]
        XCTAssertEqual(letters.merging(moreLetters, uniquingKeysWith: { $0 + $1 }), [
            "a": 4,
            "b": 10,
            "c": 8,
            "d": 8
            ])

        let numbersToLetters = [
            1: "a",
            2: "b",
            3: "c"
        ]
        let lettersToNumbers = [
            "a": 1,
            "b": 2,
            "c": 3
        ]
        XCTAssertEqual(numbersToLetters.mapKeyValuePairs({($1, $0)}), lettersToNumbers)
        XCTAssertEqual(numbersToLetters.mapKeys({$0 + 1}), [2: "a", 3: "b", 4: "c"])
        XCTAssertEqual(lettersToNumbers.mapValues({$0 + 1}), ["a": 2, "b": 3, "c": 4])

        var variable: [Int: String] = numbersToLetters
        variable.mutateValue(for: 1) { ($0 ?? "") + "..." }
        XCTAssertEqual(variable[1], "a...")
        variable.mutateValue(for: 4) { ($0 ?? "") + "..." }
        XCTAssertEqual(variable[4], "...")
    }

    func testFiniteSet() {
        func runTests<M : MutableSet, F : FiniteSet>(setA: M, setB: F, inAOnly: M.Element, inBOnly: M.Element, inBoth: M.Element, inNeither: M.Element) where M.Element == F.Element {

            XCTAssert(¬(setB.isDisjoint(with: setA)))

            XCTAssert(inAOnly ∉ setA ∩ setB)
            XCTAssert(inBOnly ∉ setA ∩ setB)
            XCTAssert(inBoth ∈ setA ∩ setB)
            XCTAssert(inNeither ∉ setA ∩ setB)

            XCTAssert(inAOnly ∈ setA ∪ setB)
            XCTAssert(inBOnly ∈ setA ∪ setB)
            XCTAssert(inBoth ∈ setA ∪ setB)
            XCTAssert(inNeither ∉ setA ∪ setB)

            XCTAssert(inAOnly ∈ setA ∖ setB)
            XCTAssert(inBOnly ∉ setA ∖ setB)
            XCTAssert(inBoth ∉ setA ∖ setB)
            XCTAssert(inNeither ∉ setA ∖ setB)

            XCTAssert(inAOnly ∈ setA ∆ setB)
            XCTAssert(inBOnly ∈ setA ∆ setB)
            XCTAssert(inBoth ∉ setA ∆ setB)
            XCTAssert(inNeither ∉ setA ∆ setB)
        }

        runTests(setA: CharacterSet.alphanumerics, setB: Set<UnicodeScalar>(["A", "B", "C", "."]), inAOnly: "D", inBOnly: ".", inBoth: "A", inNeither: " ")
        runTests(setA: MutableSetExample([1, 2, 3]), setB: Set<Int>([3, 4, 5]), inAOnly: 1, inBOnly: 4, inBoth: 3, inNeither: 0)

        XCTAssert(MutableSetExample() == Set<Int>())
        XCTAssert(MutableSetExample([1, 2]) ⊊ Set([1, 2, 3]))
        XCTAssert(Set([1, 2, 3]) ⊋ MutableSetExample([1, 2]))
    }

    func testMutableSet() {
        func runTests<S : MutableSet>(setA: S, setB: S, inAOnly: S.Element, inBOnly: S.Element, inBoth: S.Element, inNeither: S.Element) {

            XCTAssert(inAOnly ∉ setA ∩ setB, "\(inAOnly) ∈ \(setA) ∩ \(setB)")
            XCTAssert(inBOnly ∉ setA ∩ setB, "\(inBOnly) ∈ \(setA) ∩ \(setB)")
            XCTAssert(inBoth ∈ setA ∩ setB, "\(inBoth) ∉ \(setA) ∩ \(setB)")
            XCTAssert(inNeither ∉ setA ∩ setB, "\(inNeither) ∈ \(setA) ∩ \(setB)")

            var intersection = setA
            intersection ∩= setB
            XCTAssert(inAOnly ∉ intersection, "\(inAOnly) ∈ \(intersection)")
            XCTAssert(inBOnly ∉ intersection, "\(inBOnly) ∈ \(intersection)")
            XCTAssert(inBoth ∈ intersection, "\(inBoth) ∉ \(intersection)")
            XCTAssert(inNeither ∉ intersection, "\(inNeither) ∈ \(intersection)")

            XCTAssert(inAOnly ∈ setA ∪ setB, "\(inAOnly) ∉ \(setA) ∪ \(setB)")
            XCTAssert(inBOnly ∈ setA ∪ setB, "\(inBOnly) ∉ \(setA) ∪ \(setB)")
            XCTAssert(inBoth ∈ setA ∪ setB, "\(inBoth) ∉ \(setA) ∪ \(setB)")
            XCTAssert(inNeither ∉ setA ∪ setB, "\(inNeither) ∈ \(setA) ∪ \(setB)")

            var union = setA
            union ∪= setB
            XCTAssert(inAOnly ∈ union, "\(inAOnly) ∉ \(union)")
            XCTAssert(inBOnly ∈ union, "\(inBOnly) ∉ \(union)")
            XCTAssert(inBoth ∈ union, "\(inBoth) ∉ \(union)")
            XCTAssert(inNeither ∉ union, "\(inNeither) ∈ \(union)")

            XCTAssert(inAOnly ∈ setA ∖ setB, "\(inAOnly) ∉ \(setA) ∖ \(setB)")
            XCTAssert(inBOnly ∉ setA ∖ setB, "\(inBOnly) ∈ \(setA) ∖ \(setB)")
            XCTAssert(inBoth ∉ setA ∖ setB, "\(inBoth) ∈ \(setA) ∖ \(setB)")
            XCTAssert(inNeither ∉ setA ∖ setB, "\(inNeither) ∈ \(setA) ∖ \(setB)")

            var relativeComplement = setA
            relativeComplement ∖= setB
            XCTAssert(inAOnly ∈ relativeComplement, "\(inAOnly) ∉ \(relativeComplement)")
            XCTAssert(inBOnly ∉ relativeComplement, "\(inBOnly) ∈ \(relativeComplement)")
            XCTAssert(inBoth ∉ relativeComplement, "\(inBoth) ∈ \(relativeComplement)")
            XCTAssert(inNeither ∉ relativeComplement, "\(inNeither) ∈ \(relativeComplement)")

            XCTAssert(inAOnly ∈ setA ∆ setB, "\(inAOnly) ∉ \(setA) ∆ \(setB)")
            XCTAssert(inBOnly ∈ setA ∆ setB, "\(inBOnly) ∉ \(setA) ∆ \(setB)")
            XCTAssert(inBoth ∉ setA ∆ setB, "\(inBoth) ∈ \(setA) ∆ \(setB)")
            XCTAssert(inNeither ∉ setA ∆ setB, "\(inNeither) ∈ \(setA) ∆ \(setB)")

            var symmetricDifference = setA
            symmetricDifference ∆= setB
            XCTAssert(inAOnly ∈ symmetricDifference, "\(inAOnly) ∉ \(symmetricDifference)")
            XCTAssert(inBOnly ∈ symmetricDifference, "\(inBOnly) ∉ \(symmetricDifference)")
            XCTAssert(inBoth ∉ symmetricDifference, "\(inBoth) ∈ \(symmetricDifference)")
            XCTAssert(inNeither ∉ symmetricDifference, "\(inNeither) ∈ \(symmetricDifference)")

                // SetAlgebra

                XCTAssert(inAOnly ∉ setA.intersection(setB), "\(inAOnly) ∈ \(setA).intersection(\(setB))")
                XCTAssert(inBOnly ∉ setA.intersection(setB), "\(inBOnly) ∈ \(setA).intersection(\(setB))")
                XCTAssert(inBoth ∈ setA.intersection(setB), "\(inBoth) ∉ \(setA).intersection(\(setB))")
                XCTAssert(inNeither ∉ setA.intersection(setB), "\(inNeither) ∈ \(setA).intersection(\(setB))")

                intersection = setA
                intersection.formIntersection(setB)
                XCTAssert(inAOnly ∉ intersection, "\(inAOnly) ∈ \(intersection)")
                XCTAssert(inBOnly ∉ intersection, "\(inBOnly) ∈ \(intersection)")
                XCTAssert(inBoth ∈ intersection, "\(inBoth) ∉ \(intersection)")
                XCTAssert(inNeither ∉ intersection, "\(inNeither) ∈ \(intersection)")

                XCTAssert(inAOnly ∈ setA.union(setB), "\(inAOnly) ∉ \(setA).union(\(setB))")
                XCTAssert(inBOnly ∈ setA.union(setB), "\(inBOnly) ∉ \(setA).union(\(setB))")
                XCTAssert(inBoth ∈ setA.union(setB), "\(inBoth) ∉ \(setA).union(\(setB))")
                XCTAssert(inNeither ∉ setA.union(setB), "\(inNeither) ∈ \(setA).union(\(setB))")

                union = setA
                union.formUnion(setB)
                XCTAssert(inAOnly ∈ union, "\(inAOnly) ∉ \(union)")
                XCTAssert(inBOnly ∈ union, "\(inBOnly) ∉ \(union)")
                XCTAssert(inBoth ∈ union, "\(inBoth) ∉ \(union)")
                XCTAssert(inNeither ∉ union, "\(inNeither) ∈ \(union)")

                XCTAssert(inAOnly ∈ setA.symmetricDifference(setB), "\(inAOnly) ∉ \(setA).symmetricDifference(\(setB))")
                XCTAssert(inBOnly ∈ setA.symmetricDifference(setB), "\(inBOnly) ∉ \(setA).symmetricDifference(\(setB))")
                XCTAssert(inBoth ∉ setA.symmetricDifference(setB), "\(inBoth) ∈ \(setA).symmetricDifference(\(setB))")
                XCTAssert(inNeither ∉ setA.symmetricDifference(setB), "\(inNeither) ∈ \(setA).symmetricDifference(\(setB))")

                symmetricDifference = setA
                symmetricDifference.formSymmetricDifference(setB)
                XCTAssert(inAOnly ∈ symmetricDifference, "\(inAOnly) ∉ \(symmetricDifference)")
                XCTAssert(inBOnly ∈ symmetricDifference, "\(inBOnly) ∉ \(symmetricDifference)")
                XCTAssert(inBoth ∉ symmetricDifference, "\(inBoth) ∈ \(symmetricDifference)")
                XCTAssert(inNeither ∉ symmetricDifference, "\(inNeither) ∈ \(symmetricDifference)")
        }

        runTests(setA: Set([1, 2, 3]), setB: [3, 4, 5], inAOnly: 1, inBOnly: 4, inBoth: 3, inNeither: 0)
        runTests(setA: CharacterSet.alphanumerics, setB: CharacterSet(charactersIn: "ABC."), inAOnly: "D", inBOnly: ".", inBoth: "A", inNeither: " ")
        runTests(setA: MutableSetExample([1, 2, 3]), setB: MutableSetExample([3, 4, 5]), inAOnly: 1, inBOnly: 4, inBoth: 3, inNeither: 0)

        func runFiniteTests<M : MutableSet, F : FiniteSet>(setA: M, setB: F, inAOnly: M.Element, inBOnly: M.Element, inBoth: M.Element, inNeither: M.Element) where M : FiniteSet, M.Element == F.Element {

            XCTAssert(setA ≠ setB)

            XCTAssert(inAOnly ∈ setA ∆ setB)
            XCTAssert(inBOnly ∈ setA ∆ setB)
            XCTAssert(inBoth ∉ setA ∆ setB)
            XCTAssert(inNeither ∉ setA ∆ setB)
        }
        runFiniteTests(setA: MutableSetExample([1, 2, 3]), setB: Set<Int>([3, 4, 5]), inAOnly: 1, inBOnly: 4, inBoth: 3, inNeither: 0)
    }

    func testRange() {
        XCTAssertEqual(((0 ..< 1) as Range).inInequalityNotation({ $0.inDigits() }), "0 ≤ x < 1")
        XCTAssertEqual(((0 ..< 1) as CountableRange).inInequalityNotation({ $0.inDigits() }), "0 ≤ x < 1")

        XCTAssertEqual(((0 ... 1) as ClosedRange).inInequalityNotation({ $0.inDigits() }), "0 ≤ x ≤ 1")
        XCTAssertEqual(((0 ... 1) as CountableClosedRange).inInequalityNotation({ $0.inDigits() }), "0 ≤ x ≤ 1")
    }

    func testRangeReplaceableCollection() {
        func runTests<C : RangeReplaceableCollection>(start: C, appendix: C, result: C, element: C.Element, withElementAppended: C, withElementPrepended: C, withAppendixPrepended: C, truncatingIndex: C.Index, truncated: C)
            where C.Element : Equatable, C.IndexDistance : WholeArithmetic {

                var collection = start
                collection += appendix
                XCTAssert(collection.elementsEqual(result))

                XCTAssert(start.appending(contentsOf: appendix).elementsEqual(result))
                XCTAssert(start.appending(element).elementsEqual(withElementAppended))

                XCTAssert(start.prepending(contentsOf: appendix).elementsEqual(withAppendixPrepended))
                XCTAssert(start.prepending(element).elementsEqual(withElementPrepended))

                XCTAssert(start.truncated(at: truncatingIndex).elementsEqual(truncated))

                let forDrawing = start.appending(element)
                var sameOccurred = false
                var differentOccurred = false
                for _ in 1 ... 100 {
                    let random = forDrawing.randomElement()
                    if random == element {
                        sameOccurred = true
                    } else {
                        differentOccurred = true
                    }
                }
                XCTAssert(sameOccurred)
                XCTAssert(differentOccurred)

                var last = start
                var same = true
                for _ in 1 ... 100 where same {
                    let next = last.shuffled()
                    if ¬next.elementsEqual(last) {
                        same = false
                    }
                    last = next
                }
                XCTAssert(¬same)
        }

        runTests(start: [1, 2, 3],
                 appendix: [4, 5],
                 result: [1, 2, 3, 4, 5],
                 element: 0,
                 withElementAppended: [1, 2, 3, 0],
                 withElementPrepended: [0, 1, 2, 3],
                 withAppendixPrepended: [4, 5, 1, 2, 3],
                 truncatingIndex: 1,
                 truncated: [1])
        runTests(start: "123".scalars,
                 appendix: "45".scalars,
                 result: "12345".scalars,
                 element: "0",
                 withElementAppended: "1230".scalars,
                 withElementPrepended: "0123".scalars,
                 withAppendixPrepended: "45123".scalars,
                 truncatingIndex: "123".scalars.index(after: "123".scalars.startIndex),
                 truncated: "1".scalars)
        runTests(start: "123".clusters,
                 appendix: "45".clusters,
                 result: "12345".clusters,
                 element: "0",
                 withElementAppended: "1230".clusters,
                 withElementPrepended: "0123".clusters,
                 withAppendixPrepended: "45123".clusters,
                 truncatingIndex: "123".clusters.index(after: "123".clusters.startIndex),
                 truncated: "1".clusters)
        runTests(start: StrictString("123").scalars,
                 appendix: StrictString("45").scalars,
                 result: StrictString("12345").scalars,
                 element: "0",
                 withElementAppended: StrictString("1230").scalars,
                 withElementPrepended: StrictString("0123").scalars,
                 withAppendixPrepended: StrictString("45123").scalars,
                 truncatingIndex: StrictString("123").scalars.index(after: StrictString("123").scalars.startIndex),
                 truncated: StrictString("1").scalars)
        runTests(start: StrictString("123").clusters,
                 appendix: StrictString("45").clusters,
                 result: StrictString("12345").clusters,
                 element: "0",
                 withElementAppended: StrictString("1230").clusters,
                 withElementPrepended: StrictString("0123").clusters,
                 withAppendixPrepended: StrictString("45123").clusters,
                 truncatingIndex: StrictString("123").clusters.index(after: StrictString("123").clusters.startIndex),
                 truncated: StrictString("1").clusters)
        runTests(start: SemanticMarkup("123"),
                 appendix: SemanticMarkup("45"),
                 result: SemanticMarkup("12345"),
                 element: "0",
                 withElementAppended: SemanticMarkup("1230"),
                 withElementPrepended: SemanticMarkup("0123"),
                 withAppendixPrepended: SemanticMarkup("45123"),
                 truncatingIndex: SemanticMarkup("123").index(after: SemanticMarkup("123").startIndex),
                 truncated: SemanticMarkup("1"))
        runTests(start: RangeReplaceableCollectionExample([1, 2, 3]),
                 appendix: RangeReplaceableCollectionExample([4, 5]),
                 result: [1, 2, 3, 4, 5],
                 element: 0,
                 withElementAppended: [1, 2, 3, 0],
                 withElementPrepended: [0, 1, 2, 3],
                 withAppendixPrepended: [4, 5, 1, 2, 3],
                 truncatingIndex: 1,
                 truncated: [1])

        let collection = [1, 2, 3, 4, 5]

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
        mutable.truncate(before: CompositePattern([LiteralPattern([2]), LiteralPattern([3])]))
        XCTAssertEqual(mutable, [1])

        mutable = collection
        mutable.truncate(after: [2, 3])
        XCTAssertEqual(mutable, [1, 2, 3])

        mutable = collection
        mutable.truncate(after: CompositePattern([LiteralPattern([2]), LiteralPattern([3])]))
        XCTAssertEqual(mutable, [1, 2, 3])

        mutable = collection
        mutable.drop(upTo: [2, 3])
        XCTAssertEqual(mutable, [2, 3, 4, 5])

        mutable = collection
        mutable.drop(upTo: CompositePattern([LiteralPattern([2]), LiteralPattern([3])]))
        XCTAssertEqual(mutable, [2, 3, 4, 5])

        mutable = collection
        mutable.drop(through: [2, 3])
        XCTAssertEqual(mutable, [4, 5])

        mutable = collection
        mutable.drop(through: CompositePattern([LiteralPattern([2]), LiteralPattern([3])]))
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
            "876"
            ].map() { $0.scalars }
        let equalized = [
            "005",
            "075",
            "876"
        ]
        XCTAssertEqual(text.countsEqualized(byFillingWith: "0", from: .start).map({ String($0) }), equalized)
        text.equalizeCounts(byFillingWith: "0", from: .start)
        XCTAssertEqual(text.map({ String($0) }), equalized)

        XCTAssertEqual(collection.truncated(before: [3, 4]), [1, 2])
        XCTAssertEqual(collection.truncated(before: [LiteralPattern([3]), LiteralPattern([4])]), [1, 2])
        XCTAssertEqual(collection.truncated(after: [3, 4]), [1, 2, 3, 4])
        XCTAssertEqual(collection.truncated(after: [LiteralPattern([3]), LiteralPattern([4])]), [1, 2, 3, 4])
        XCTAssertEqual(collection.dropping(upTo: [3, 4]), [3, 4, 5])
        XCTAssertEqual(collection.dropping(upTo: [LiteralPattern([3]), LiteralPattern([4])]), [3, 4, 5])
        XCTAssertEqual(collection.dropping(through: [3, 4]), [5])
        XCTAssertEqual(collection.dropping(through: [LiteralPattern([3]), LiteralPattern([4])]), [5])

        XCTAssertEqual(collection.replacingMatches(for: [3, 4], with: [0]), [1, 2, 0, 5])
        XCTAssertEqual(collection.replacingMatches(for: [LiteralPattern([3]), LiteralPattern([4])], with: [0]), [1, 2, 0, 5])

        mutable = collection
        mutable.replaceMatches(for: [LiteralPattern([3]), LiteralPattern([4])], with: [0])
        XCTAssertEqual(mutable, [1, 2, 0, 5])

        XCTAssertEqual(collection.mutatingMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) }), [1, 2, 4, 5, 5])
        XCTAssertEqual(collection.mutatingMatches(for: [LiteralPattern([3]), LiteralPattern([4])], mutation: { $0.contents.map({ $0 + 1 }) }), [1, 2, 4, 5, 5])

        mutable = collection
        mutable.mutateMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) })
        XCTAssertEqual(mutable, [1, 2, 4, 5, 5])

        mutable = collection
        mutable.mutateMatches(for: [LiteralPattern([3]), LiteralPattern([4])], mutation: { $0.contents.map({ $0 + 1 }) })
        XCTAssertEqual(mutable, [1, 2, 4, 5, 5])
    }

    func testSetDefinition() {
        func runTests<S : SetDefinition>(setA: S, setB: S, inAOnly: S.Element, inBOnly: S.Element, inBoth: S.Element, inNeither: S.Element) {
            XCTAssert(inAOnly ∈ setA)
            XCTAssert(inBOnly ∉ setA)
            XCTAssert(inBoth ∈ setA)
            XCTAssert(inNeither ∉ setA)

            XCTAssert(inAOnly ∉ setA ∩ setB)
            XCTAssert(inBOnly ∉ setA ∩ setB)
            XCTAssert(inBoth ∈ setA ∩ setB)
            XCTAssert(inNeither ∉ setA ∩ setB)

            XCTAssert(inAOnly ∈ setA ∪ setB)
            XCTAssert(inBOnly ∈ setA ∪ setB)
            XCTAssert(inBoth ∈ setA ∪ setB)
            XCTAssert(inNeither ∉ setA ∪ setB)

            XCTAssert(inAOnly ∈ setA ∖ setB)
            XCTAssert(inBOnly ∉ setA ∖ setB)
            XCTAssert(inBoth ∉ setA ∖ setB)
            XCTAssert(inNeither ∉ setA ∖ setB)

            XCTAssert(inAOnly ∈ setA ∆ setB)
            XCTAssert(inBOnly ∈ setA ∆ setB)
            XCTAssert(inBoth ∉ setA ∆ setB)
            XCTAssert(inNeither ∉ setA ∆ setB)
        }

        runTests(setA: Set([1, 2, 3]), setB: [3, 4, 5], inAOnly: 1, inBOnly: 4, inBoth: 3, inNeither: 0)
        runTests(setA: IntensionalSet<Int>(where: { $0.isOdd }), setB: IntensionalSet<Int>(where: { $0.isDivisible(by: 3) }), inAOnly: 1, inBOnly: 6, inBoth: 3, inNeither: 2)
        runTests(setA: CharacterSet.alphanumerics, setB: CharacterSet(charactersIn: "ABC."), inAOnly: "D", inBOnly: ".", inBoth: "A", inNeither: " ")
        runTests(setA: (0 ..< 5) as Range, setB: 3 ..< 8, inAOnly: 1, inBOnly: 7, inBoth: 3, inNeither: 10)
        runTests(setA: (0 ... 5) as ClosedRange, setB: 3 ... 8, inAOnly: 1, inBOnly: 7, inBoth: 3, inNeither: 10)
        runTests(setA: (0 ..< 5) as CountableRange, setB: 3 ..< 8, inAOnly: 1, inBOnly: 7, inBoth: 3, inNeither: 10)
        runTests(setA: (0 ... 5) as CountableClosedRange, setB: 3 ... 8, inAOnly: 1, inBOnly: 7, inBoth: 3, inNeither: 10)
        runTests(setA: MutableSetExample([1, 2, 3]), setB: MutableSetExample([3, 4, 5]), inAOnly: 1, inBOnly: 4, inBoth: 3, inNeither: 0)

    }

    func testSetInRepresentableUniverse() {
        func runTests<S : SetInRepresentableUniverse>(set: S, member: S.Element) {

            let inverse = set′
            XCTAssert(member ∉ inverse)

            var original = inverse
            original′=
            XCTAssert(member ∈ original)
        }
        runTests(set: CharacterSet.alphanumerics, member: "A")
        runTests(set: SetInRepresentableUniverseExample([1, 2, 3]), member: 2)
    }

    static var allTests: [(String, (CollectionTests) -> () throws -> Void)] {
        return [
            ("testArray", testArray),
            ("testBidirectionalCollection", testBidirectionalCollection),
            ("testBijectiveMapping", testBijectiveMapping),
            ("testCollection", testCollection),
            ("testComparableSet", testComparableSet),
            ("testDictionary", testDictionary),
            ("testFiniteSet", testFiniteSet),
            ("testMutableSet", testMutableSet),
            ("testRange", testRange),
            ("testRangeReplaceableCollection", testRangeReplaceableCollection),
            ("testSetDefinition", testSetDefinition),
            ("testSetInRepresentableUniverse", testSetInRepresentableUniverse)
        ]
    }
}
