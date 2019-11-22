/*
 FileConvertible.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCollections
import SDGText
import SDGPersistence
import SDGCalendar

import SDGTesting

/// Tests a type’s conformance to FileConvertible.
///
/// This function will write the file to the test specification directory in the project repository and will attempt to load that data in future calls. It is recommeded to check those specifications into source control, as this will make it easier to track backwards compatibility. These files can be deleted manually in the event that a particular format should no longer be supported.
///
/// - Parameters:
///     - instance: An instance to save and load.
///     - uniqueTestName: A unique name for the test. This is used in the path to the persistent test specifications.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testFileConvertibleConformance<T>(
  of instance: T,
  uniqueTestName: StrictString,
  file: StaticString = #file,
  line: UInt = #line
) where T: Equatable, T: FileConvertible {

  let specificationsDirectory = testSpecificationDirectory(file).appendingPathComponent(
    "FileConvertible"
  ).appendingPathComponent("\(T.self)").appendingPathComponent(String(uniqueTestName))
  try? FileManager.default.createDirectory(
    at: specificationsDirectory,
    withIntermediateDirectories: true,
    attributes: nil
  )

  var specifications: Set<Data> = []
  do {
    for specificationURL in try FileManager.default.contentsOfDirectory(
      at: specificationsDirectory,
      includingPropertiesForKeys: nil,
      options: []
    ) {
      try autoreleasepool {

        let specification = try Data(from: specificationURL)
        specifications.insert(specification)
        let decoded = try T(file: specification, origin: specificationURL)
        test(
          decoded == instance,
          {  // @exempt(from: tests)
            return  // @exempt(from: tests)
              "\(instance) ≠ \(decoded) (\(specificationURL)"
          }(),
          file: file,
          line: line
        )
      }
    }

    let encoded = instance.file

    let decoded = try T(file: encoded, origin: nil)
    test(decoded == instance, "\(decoded) ≠ \(instance)", file: file, line: line)

    let newSpecification = encoded
    if newSpecification ∉ specifications {
      // @exempt(from: tests)
      let now = CalendarDate.gregorianNow()
      try newSpecification.save(
        to: specificationsDirectory.appendingPathComponent("\(now.dateInISOFormat()).testspec")
      )
    }
  } catch {
    fail("\(error)", file: file, line: line)
  }
}
