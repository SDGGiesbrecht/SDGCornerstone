/*
 DeprecationTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import XCTest

import SDGMathematicsTestUtilities
import SDGCollectionsTestUtilities
import SDGXCTestUtilities

final class DeprecationTests: TestCase {

  @available(*, deprecated)
  func testOrderedSet() {
    var set = SDGCollections.OrderedSet(["a", "b", "c"])
    testComparableSetConformance(
      of: set,
      member: "a",
      nonmember: "d",
      superset: ["a", "b", "c", "d"],
      overlapping: ["a", "d"],
      disjoint: ["d", "e"]
    )
    XCTAssert(set.contents.elementsEqual(["a", "b", "c"]))
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
    testComparableConformance(less: set, greater: ["m", "n", "o"])
    _ = set.wrappedInstance
  }
}
