/*
 CollectionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
import Foundation

import SDGCornerstone

class CollectionTests : XCTestCase {

    func testArray() {
        XCTAssert([] ≠ [1])

        var array = [1, 2, 3]
        array += [4, 5, 6]

        XCTAssert(array == [1, 2, 3, 4, 5, 6])
    }

    func testComparableSet() {
        func runTests<S : ComparableSet>(superset: S, subset: S) {
            XCTAssert(superset ⊈ subset, "\(superset) ⊆ \(subset)")
            XCTAssert(superset ⊇ subset, "\(superset) ⊉ \(subset)")
            XCTAssert(subset ⊉ superset, "\(subset) ⊇ \(superset)")
            XCTAssert(superset ⊋ subset, "\(superset) ⊋̸ \(subset)")
            XCTAssert(subset ⊊ superset, "\(subset) ⊊̸ \(superset)")
            #if !os(Linux)
                // [_Warning: These need to be solved on Linux._]
            XCTAssert(¬superset.isDisjoint(with: subset), "\(superset).isDisjoint(with: \(subset))")
            XCTAssert(superset ≠ subset, "\(superset) = \(subset)")
            #endif
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
        XCTAssert(moreNumbers == [
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
        XCTAssert(letters.merged(with: moreLetters, combine: { ($0 ?? 0) + ($1 ?? 0) }) == [
            "a": 4,
            "b": 10,
            "c": 8,
            "d": 8
        ])
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
        #if !os(Linux)
            // [_Warning: This needs to be dealt with._]
        runTests(setA: CharacterSet.alphanumerics, setB: CharacterSet(charactersIn: "ABC."), inAOnly: "D", inBOnly: ".", inBoth: "A", inNeither: " ")
        #endif
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

    func testRangeReplaceableCollection() {
        func runTests<C : RangeReplaceableCollection>(start: C, appendix: C, result: C) where C.Iterator.Element : Equatable {
            var collection = start
            collection += appendix
            XCTAssert(collection.elementsEqual(result))
        }

        runTests(start: [1, 2, 3], appendix: [4, 5], result: [1, 2, 3, 4, 5])
        runTests(start: "123".unicodeScalars, appendix: "45".unicodeScalars, result: "12345".unicodeScalars)
        runTests(start: "123".characters, appendix: "45".characters, result: "12345".characters)
        runTests(start: RangeReplaceableCollectionExample([1, 2, 3]), appendix: RangeReplaceableCollectionExample([4, 5]), result: RangeReplaceableCollectionExample([1, 2, 3, 4, 5]))
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
            ("testComparableSet", testComparableSet),
            ("testDictionary", testDictionary),
            ("testMutableSet", testMutableSet),
            ("testRangeReplaceableCollection", testRangeReplaceableCollection),
            ("testSetDefinition", testSetDefinition),
            ("testSetInRepresentableUniverse", testSetInRepresentableUniverse)
        ]
    }
}
