/*
 SDGCollectionsAPITests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollectionsTestUtilities
import SDGXCTestUtilities

import SDGMathematics

class SDGCollectionsAPITests : TestCase {

    func testAlternativePatterns() {
        testPattern(AlternativePatterns([
            LiteralPattern([1, 2, 3]),
            LiteralPattern([3, 2, 1])
            ]), match: [1, 2, 3])
    }

    func testArray() {
        testBidirectionalCollectionConformance(of: [1, 2, 3])
        testRangeReplaceableCollectionConformance(of: [Int].self, element: 0)

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

        XCTAssertEqual([5, 4, 3, 2, 1].lastMatch(for: ConditionalPattern({ $0.isEven }))?.range, 3 ..< 4)

        XCTAssertEqual([5, 4, 3, 2, 1].lastMatch(for: NotPattern([3, 2, 1]))?.range, 3 ..< 4)

        let advancingCollection = [1, 2, 1, 2, 3]
        var index = advancingCollection.startIndex
        XCTAssert(advancingCollection.advance(&index, over: [1, 2]))
        XCTAssertEqual(index, 2)
        XCTAssertFalse(advancingCollection.advance(&index, over: [LiteralPattern([2]), LiteralPattern([3])]))
        XCTAssertEqual(index, 2)
    }

    func testBijectiveMapping() {
        testCollectionConformance(of: BijectiveMapping([1: "1", 2: "2"]))

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
        XCTAssertNil([1, 2, 3, 4].prefix(upTo: ConditionalPattern({ $0 > 100 })))

        XCTAssertEqual([1, 2, 3, 4].prefix(through: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 0 ..< 3)
        XCTAssertEqual([1, 2, 3, 4].prefix(through: [2, 3])?.range, 0 ..< 3)
        XCTAssertEqual([1, 2, 3, 4].prefix(through: [LiteralPattern([2]), LiteralPattern([3])])?.range, 0 ..< 3)
        XCTAssertNil([1, 2, 3, 4].prefix(through: [8, 9]))
        XCTAssertNil([1, 2, 3, 4].prefix(through: ConditionalPattern({ $0 > 100 })))

        XCTAssertEqual([1, 2, 3, 4].suffix(from: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 1 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(from: [2, 3])?.range, 1 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(from: [LiteralPattern([2]), LiteralPattern([3])])?.range, 1 ..< 4)
        XCTAssertNil([1, 2, 3, 4].suffix(from: [8, 9]))
        XCTAssertNil([1, 2, 3, 4].suffix(from: ConditionalPattern({ $0 > 100 })))

        XCTAssertEqual([1, 2, 3, 4].suffix(after: AlternativePatterns([LiteralPattern([2, 3]), LiteralPattern([3, 4])]))?.range, 3 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(after: [2, 3])?.range, 3 ..< 4)
        XCTAssertEqual([1, 2, 3, 4].suffix(after: [LiteralPattern([2]), LiteralPattern([3])])?.range, 3 ..< 4)
        XCTAssertNil([1, 2, 3, 4].suffix(after: [8, 9]))
        XCTAssertNil([1, 2, 3, 4].suffix(after: ConditionalPattern({ $0 > 100 })))

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

        XCTAssert(AnyCollection([1, 2, 3, 4]).hasSuffix([3, 4]))
        XCTAssert(AnyCollection([1, 2, 3, 4]).hasSuffix(AlternativePatterns([LiteralPattern([3, 4]), LiteralPattern([5, 6])])))
        XCTAssert(AnyCollection([1, 2, 3, 4]).hasSuffix([LiteralPattern([3]), LiteralPattern([4])]))
        XCTAssert(AnyCollection([1, 2, 3, 4]).hasSuffix(AnyCollection([1, 2, 3, 4])))

        XCTAssertEqual([5, 4, 3, 2, 1].commonPrefix(with: [5, 2, 1]).contents, [5])

        XCTAssertEqual([5, 4, 3, 2, 1].firstMatch(for: ConditionalPattern({ $0.isEven }))?.range, 1 ..< 2)

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
        XCTAssertEqual([1, 1, 1].firstMatch(for: RepetitionPattern(ConditionalPattern({ $0 == 1 }), count: countableRange))?.range, [1, 1, 1].bounds)

        XCTAssertNil([1].firstMatch(for: RepetitionPattern([1], count: 2 ... 4, consumption: .lazy)))

        XCTAssertEqual([1, 1, 1, 2, 3].firstMatch(for: RepetitionPattern(LiteralPattern([1]), count: 0 ..< 15))?.range, [1, 1, 1].bounds)
        XCTAssertNil([1, 1, 1, 2, 3].firstMatch(for: RepetitionPattern(LiteralPattern([1]), count: 5 ..< 15, consumption: .lazy)))

        XCTAssertEqual("ABCDE".scalars.matches(for: ["A", "B", "C"]).count, 1)
        XCTAssertEqual("ABCDE".scalars.prefix(upTo: ["B", "C"])?.contents.count, 1)
        XCTAssertEqual("ABCDE".scalars.prefix(through: ["B", "C"])?.contents.count, 3)
        XCTAssertEqual("ABCDE".scalars.suffix(from: ["B", "C"])?.contents.count, 4)
        XCTAssertEqual("ABCDE".scalars.suffix(after: ["B", "C"])?.contents.count, 2)
        XCTAssertEqual("ABCDE".scalars.firstNestingLevel(startingWith: ["B", "C"], endingWith: ["E"])?.contents.contents.count, 1)
        let scalars = "ABCDE".scalars
        var mobileIndex = scalars.startIndex
        XCTAssert(scalars.advance(&mobileIndex, over: ["A", "B"]))
        XCTAssertFalse(scalars.advance(&mobileIndex, over: ["A", "B"]))
        XCTAssert(scalars.advance(&mobileIndex, over: ConditionalPattern({ $0 == "C" })))
        XCTAssertFalse(scalars.advance(&mobileIndex, over: ConditionalPattern({ $0 == "C" })))

        let start = [".", ".", "G", "A", "C", "!", "!", ".", "."]
        let end = [".", ".", "A", "G", "C", "A", "T", "?", "?", ".", "."]
        let diff = end.difference(from: start)
        var changed: [String] = []
        for change in diff {
            switch change {
            case .keep(let range):
                changed.append(contentsOf: start[range])
            case .remove:
                break
            case .insert(let range):
                changed.append(contentsOf: end[range])
            }
        }
        XCTAssertEqual(changed, end)

        let startString = "..GAC‐‐!!.."
        let endString = "..AGCAT‐‐??.."
        let diffString = endString.difference(from: startString)
        var changedString = ""
        for change in diffString {
            switch change {
            case .keep(let range):
                changedString.append(contentsOf: startString[range])
            case .remove:
                break
            case .insert(let range):
                changedString.append(contentsOf: endString[range])
            }
        }
        XCTAssertEqual(changedString, endString)

        let set = Set(endString)
        _ = set.difference(from: startString)
    }

    struct ComparableSetExample : ComparableSet {
        typealias Element = Int
        var set: Set<Int>
        init(_ set: Set<Int>) {
            self.set = set
        }
        static func ∋ (precedingValue: ComparableSetExample, followingValue: Int) -> Bool {
            return precedingValue.set ∋ followingValue
        }
        static func ⊆ (precedingValue: ComparableSetExample, followingValue: ComparableSetExample) -> Bool {
            return precedingValue.set ⊆ followingValue.set
        }
        func overlaps(_ other: ComparableSetExample) -> Bool {
            return set.overlaps(other.set)
        }
    }
    func testComparableSet() {
        testComparableSetConformance(of: ComparableSetExample([1, 2, 3]), member: 1, nonmember: 10, superset: ComparableSetExample([0, 1, 2, 3]), overlapping: ComparableSetExample([2, 4]), disjoint: ComparableSetExample([−1, −2, −3]))
    }

    func testCompositePattern() {
        testPattern(CompositePattern([
            LiteralPattern([1, 2]),
            LiteralPattern([3])
            ]), match: [1, 2, 3])
    }

    func testConditionalPattern() {
        testPattern(ConditionalPattern({ $0 < 10 }), match: [0])
        XCTAssert(ConditionalPattern({ $0 < 10 }).matches(in: [11], at: 0).isEmpty)
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

    struct FiniteSetExample : FiniteSet {
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
        testFiniteSetConformance(of: FiniteSetExample([1, 2, 3]), member: 1, nonmember: 10, superset: FiniteSetExample([0, 1, 2, 3]), overlapping: FiniteSetExample([2, 4]), disjoint: FiniteSetExample([−1, −2, −3]))
    }

    func testIntensionalSet() {
        testSetDefinitionConformance(of: IntensionalSet<Int>(where: { $0 < 100 }), member: 1, nonmember: 101)
    }

    func testLiteralPattern() {
        testPattern(LiteralPattern([1, 2, 3]), match: [1, 2, 3])
    }

    struct MutableSetExample : MutableSet {
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
    struct MutableFiniteSetExample : FiniteSet, MutableSet {
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
        static func ⊆ (precedingValue: MutableFiniteSetExample, followingValue: MutableFiniteSetExample) -> Bool {
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
        XCTAssertEqual(MutableFiniteSetExample([1, 2, 3]) ∆ FiniteSetExample([3, 4, 5]), MutableFiniteSetExample([1, 2, 4, 5]))
    }

    func testNotPattern() {
        testPattern(NotPattern(LiteralPattern([1])), match: [2])
        XCTAssert(NotPattern(LiteralPattern([1])).matches(in: [1], at: 0).isEmpty)
    }

    class CustomPattern : SDGCollections.Pattern<Int> {
        let pattern = LiteralPattern([1])
        override func matches<C>(in collection: C, at location: C.Index) -> [Range<C.Index>] where Int == C.Element, C : Collection {
            return pattern.matches(in: collection, at: location)
        }
        override func reversed() -> CustomPattern {
            return self
        }
    }
    func testPatternClassCluster() {
        testPattern(CustomPattern(), match: [1])
    }

    func testRange() {
        testComparableSetConformance(of: 1 ..< 10 as Range, member: 1, nonmember: 10, superset: 1 ..< 20, overlapping: 5 ..< 15, disjoint: 11 ..< 20)
        testComparableSetConformance(of: 1 ... 10 as ClosedRange, member: 1, nonmember: 11, superset: 1 ... 20, overlapping: 5 ... 15, disjoint: 11 ... 20)
        testComparableSetConformance(of: 1 ..< 10 as CountableRange, member: 1, nonmember: 10, superset: 1 ..< 20, overlapping: 5 ..< 15, disjoint: 11 ..< 20)
        testComparableSetConformance(of: 1 ... 10 as CountableClosedRange, member: 1, nonmember: 11, superset: 1 ... 20, overlapping: 5 ... 15, disjoint: 11 ... 20)
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
            ].map { $0.scalars }
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
        XCTAssertEqual([1, 2].truncated(before: ConditionalPattern({ $0 == 1 })), [])
        XCTAssertEqual(collection.truncated(after: [3, 4]), [1, 2, 3, 4])
        XCTAssertEqual(collection.truncated(after: [LiteralPattern([3]), LiteralPattern([4])]), [1, 2, 3, 4])
        XCTAssertEqual([1, 2].truncated(after: ConditionalPattern({ $0 == 1 })), [1])
        XCTAssertEqual(collection.dropping(upTo: [3, 4]), [3, 4, 5])
        XCTAssertEqual(collection.dropping(upTo: [LiteralPattern([3]), LiteralPattern([4])]), [3, 4, 5])
        XCTAssertEqual([1, 2].dropping(upTo: ConditionalPattern({ $0 == 3 })), [])
        XCTAssertEqual(collection.dropping(through: [3, 4]), [5])
        XCTAssertEqual(collection.dropping(through: [LiteralPattern([3]), LiteralPattern([4])]), [5])
        XCTAssertEqual([1, 2].dropping(through: ConditionalPattern({ $0 == 3 })), [])

        XCTAssertEqual(collection.replacingMatches(for: [3, 4], with: [0]), [1, 2, 0, 5])
        XCTAssertEqual(collection.replacingMatches(for: [LiteralPattern([3]), LiteralPattern([4])], with: [0]), [1, 2, 0, 5])
        XCTAssertEqual([1, 2, 3, 4].replacingMatches(for: ConditionalPattern({ $0 < 4 }), with: [0]), [0, 0, 0, 4])

        mutable = collection
        mutable.replaceMatches(for: [LiteralPattern([3]), LiteralPattern([4])], with: [0])
        XCTAssertEqual(mutable, [1, 2, 0, 5])

        XCTAssertEqual(collection.mutatingMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) }), [1, 2, 4, 5, 5])
        XCTAssertEqual(collection.mutatingMatches(for: [LiteralPattern([3]), LiteralPattern([4])], mutation: { $0.contents.map({ $0 + 1 }) }), [1, 2, 4, 5, 5])
        XCTAssertEqual([1, 2, 3, 4].mutatingMatches(for: ConditionalPattern({ $0 < 4 }), mutation: { _ in return [0] }), [0, 0, 0, 4])

        mutable = collection
        mutable.mutateMatches(for: [3, 4], mutation: { $0.contents.map({ $0 + 1 }) })
        XCTAssertEqual(mutable, [1, 2, 4, 5, 5])

        mutable = collection
        mutable.mutateMatches(for: [LiteralPattern([3]), LiteralPattern([4])], mutation: { $0.contents.map({ $0 + 1 }) })
        XCTAssertEqual(mutable, [1, 2, 4, 5, 5])

        let scalars = "ABCDE".scalars
        var mutableScalars = scalars
        mutableScalars.truncate(before: ["E"])
        XCTAssert(scalars.truncated(before: ["E"]).elementsEqual("ABCD".scalars))
        mutableScalars.truncate(after: ["C"])
        XCTAssert(scalars.truncated(after: ["C"]).elementsEqual("ABC".scalars))
        mutableScalars.drop(upTo: ["B"])
        XCTAssert(scalars.dropping(upTo: ["B"]).elementsEqual("BCDE".scalars))
        mutableScalars.drop(through: ["B"])
        XCTAssert(scalars.dropping(through: ["B"]).elementsEqual("CDE".scalars))
        XCTAssert(scalars.replacingMatches(for: ["B", "C"], with: "x".scalars).elementsEqual("AxDE".scalars))
        mutableScalars.mutateMatches(for: ["C"]) { _ in "".scalars }
        XCTAssert(mutableScalars.elementsEqual([]))
        XCTAssert(scalars.mutatingMatches(for: ["B", "C"], mutation: { _ in return "x".scalars }).elementsEqual("AxDE".scalars))

        XCTAssertEqual("ABC", String(arrayLiteral: "A", "B", "C"))
    }

    func testRepetitionPattern() {
        testPattern(RepetitionPattern(LiteralPattern([1, 2, 3])), match: [1, 2, 3, 1, 2, 3])
    }

    func testSet() {
        testFiniteSetConformance(of: Set([1, 2, 3]), member: 1, nonmember: 0, superset: [1, 2, 3, 4, 5], overlapping: [1, 3, 5], disjoint: [7, 8, 9])
        testMutableSetConformance(of: Set<Int>.self, a: 1, b: 2, c: 3)
    }

    struct SetInRepresentableUniverseExample : SetInRepresentableUniverse {
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
        static func ⊆ (precedingValue: SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) -> Bool {
            return precedingValue.set ⊆ followingValue.set
        }
        func overlaps(_ other: SetInRepresentableUniverseExample) -> Bool {
            return set.overlaps(other.set)
        }
        static func ∩= (precedingValue: inout SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) {
            precedingValue.set ∩= followingValue.set
        }
        static func ∪= (precedingValue: inout SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) {
            precedingValue.set ∪= followingValue.set
        }
        static func ∖= (precedingValue: inout SetInRepresentableUniverseExample, followingValue: SetInRepresentableUniverseExample) {
            precedingValue.set ∖= followingValue.set
        }
        static let universe = SetInRepresentableUniverseExample([1, 2, 3, 4, 5])
    }
    func testSetInRepresentableUniverse() {
        testSetInRepresentableUniverseConformance(of: SetInRepresentableUniverseExample.self, a: 1, b: 2, c: 3)
    }

    func testSymmetricDifference() {
        testSetDefinitionConformance(of: IntensionalSet(where: { $0.isEven }) ∆ (1 ... 100), member: 1, nonmember: 2)
    }

    static var allTests: [(String, (SDGCollectionsAPITests) -> () throws -> Void)] {
        return [
            ("testAlternativePatterns", testAlternativePatterns),
            ("testArray", testArray),
            ("testBidirectionalCollection", testBidirectionalCollection),
            ("testBijectiveMapping", testBijectiveMapping),
            ("testCollection", testCollection),
            ("testComparableSet", testComparableSet),
            ("testCompositePattern", testCompositePattern),
            ("testConditionalPattern", testConditionalPattern),
            ("testDictionary", testDictionary),
            ("testFiniteSet", testFiniteSet),
            ("testIntensionalSet", testIntensionalSet),
            ("testLiteralPattern", testLiteralPattern),
            ("testMutableSet", testMutableSet),
            ("testNotPattern", testNotPattern),
            ("testPatternClassCluster", testPatternClassCluster),
            ("testRange", testRange),
            ("testRangeReplaceableCollection", testRangeReplaceableCollection),
            ("testRepetitionPattern", testRepetitionPattern),
            ("testSet", testSet),
            ("testSymmetricDifference", testSymmetricDifference)
        ]
    }
}
