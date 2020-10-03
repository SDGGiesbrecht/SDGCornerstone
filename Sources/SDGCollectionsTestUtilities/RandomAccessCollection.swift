/*
 RandomAccessCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

/// Tests a type’s conformance to BidirectionalCollection.
///
/// - Parameters:
///     - collection: A collection.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testRandomAccessCollectionConformance<T>(
  of collection: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: RandomAccessCollection {

  testBidirectionalCollectionConformance(of: collection, file: file, line: line)

  let second = collection.index(after: collection.startIndex)
  test(
    method: (T.index(_:offsetBy:), "index(_:offsetBy:)"),
    of: collection,
    with: (collection.startIndex, 1),
    returns: second,
    file: file,
    line: line
  )

  test(
    method: (T.distance(from:to:), "distance(from:to:)"),
    of: collection,
    with: (collection.startIndex, second),
    returns: 1,
    file: file,
    line: line
  )
}
