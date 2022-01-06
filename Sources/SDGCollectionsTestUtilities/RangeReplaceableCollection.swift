/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGTesting

/// Tests a type’s conformance to RangeReplaceableCollection.
///
/// - Parameters:
///     - type: The type.
///     - element: An element instance.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testRangeReplaceableCollectionConformance<T>(
  of type: T.Type,
  element: T.Element,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: RangeReplaceableCollection, T.Element: Equatable {

  var collection = T()
  collection.append(element)

  testCollectionConformance(of: collection, file: file, line: line)

  test(
    collection.elementsEqual(T([element])),
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(T.self)(\(element) → \(T([element])) ≠ \(collection)"
    }(),
    file: file,
    line: line
  )

  collection.insert(contentsOf: [element], at: collection.startIndex)
  test(
    collection.elementsEqual(T([element, element])),
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(T([element])).insert(contentsOf: \([element]), at: \(collection.startIndex) → \(collection) ≠ \(T([element, element]))"
    }(),
    file: file,
    line: line
  )

  var appended = collection.appending(contentsOf: [element])
  let appendedExpectation = T([element, element, element])
  test(
    appended.elementsEqual(appendedExpectation),
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(collection).appending(contentsOf: \([element])) → \(appended) ≠ \(appendedExpectation)"
    }(),
    file: file,
    line: line
  )

  appended = collection.appending(contentsOf: T([element]))
  test(
    appended.elementsEqual(appendedExpectation),
    {  // @exempt(from: tests)
      return  // @exempt(from: tests)
        "\(collection).appending(contentsOf: \(T([element]))) → \(appended) ≠ \(appendedExpectation)"
    }(),
    file: file,
    line: line
  )
}
