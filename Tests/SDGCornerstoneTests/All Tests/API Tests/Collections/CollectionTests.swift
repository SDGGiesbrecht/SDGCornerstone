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
            XCTAssert(superset ⊈ subset)
            XCTAssert(superset ⊇ subset)
        }

        runTests(superset: Set([1, 2, 3]), subset: Set([1, 2]))
        runTests(superset: CharacterSet.alphanumerics, subset: CharacterSet.capitalizedLetters)
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
        func runTests<S : SetDefinition>(set: S, member: S.Element) {
            XCTAssert(member ∈ set)
        }

        runTests(set: Set([1, 2, 3]), member: 2)
        runTests(set: IntensionalSet<Int>(where: { $0.isOdd }), member: 7)
        runTests(set: CharacterSet.alphanumerics, member: "A")
        runTests(set: 0 ..< 5, member: 1)
        runTests(set: (0 ... 5) as ClosedRange, member: 1)
        runTests(set: (0 ..< 5) as CountableRange, member: 1)
        runTests(set: (0 ... 5) as CountableClosedRange, member: 1)
        runTests(set: MutableSetExample([1, 2, 3]), member: 2)
    }

    static var allTests: [(String, (CollectionTests) -> () throws -> Void)] {
        return [
            ("testArray", testArray),
            ("testComparableSet", testComparableSet),
            ("testDictionary", testDictionary),
            ("testRangeReplaceableCollection", testRangeReplaceableCollection),
            ("testSetDefinition", testSetDefinition)
        ]
    }
}
