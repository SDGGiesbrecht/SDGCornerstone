/*
 Codable.swift

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
import SDGLocalization
import SDGCalendar
import SDGCornerstoneLocalizations

/// Tests a type’s conformance to Codable.
///
/// This function will write the encoded data to the test specification directory in the project repository and will attempt to load that data in future calls. It is recommeded to check those specifications into source control, as this will make it easier to track backwards compatibility. These files can be deleted manually in the event that a particular encoding form should no longer be supported.
///
/// - Parameters:
///     - instance: An instance to encode and decode.
///     - uniqueTestName: A unique name for the test. This is used in the path to the persistent test specifications.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func testCodableConformance<T>(of instance: T, uniqueTestName: StrictString, file: StaticString = #file, line: UInt = #line) where T : Codable, T : Equatable {

    let specificationsDirectory = testSpecificationDirectory(file).appendingPathComponent("Codable").appendingPathComponent("\(T.self)").appendingPathComponent(String(uniqueTestName))
    try? FileManager.default.createDirectory(at: specificationsDirectory, withIntermediateDirectories: true, attributes: nil)

    var specifications: Set<String> = []
    do {
        for specificationURL in try FileManager.default.contentsOfDirectory(at: specificationsDirectory, includingPropertiesForKeys: nil, options: []) where specificationURL.pathExtension == "txt" {
            try autoreleasepool {

                let specification = try String(from: specificationURL)
                specifications.insert(specification)
                let data = specification.file
                let array = try JSONDecoder().decode([T].self, from: data)
                guard let decoded = array.first else {
                    fail(String(UserFacing<StrictString, APILocalization>({ localization in
                        switch localization {
                        case .englishCanada: // @exempt(from: tests)
                            return "Empty array decoded from “\(specificationURL.absoluteString)”."
                        }
                    }).resolved()), file: file, line: line)
                    return // from autorelease pool and move to next specification.
                }
                test(decoded == instance, "\(instance) ≠ \(decoded) (\(specificationURL)", file: file, line: line)
            }
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        encoder.outputFormatting.insert(.sortedKeys)
        let encoded = try encoder.encode([instance])

        let decoded = try JSONDecoder().decode([T].self, from: encoded).first!
        test(decoded == instance, "\(decoded) ≠ \(instance)", file: file, line: line)

        let newSpecification = try String(file: encoded, origin: nil)
        if newSpecification ∉ specifications {
            // @exempt(from: tests)
            let now = CalendarDate.gregorianNow()
            try newSpecification.save(to: specificationsDirectory.appendingPathComponent("\(now.dateInISOFormat()).txt"))
        }
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests that decoding fails with a value encoded from an invalid mock type.
///
/// For example, if a type encodes a property as an integer, but only supports a certain range of numbers, this function can be used to test that decoding an invalid number fails. The mock instance should be a dictionary, array or something else that can mimic the same encoding structure as the actual type, but is free from the restraints the type imposes.
///
/// - Parameters:
///     - type: The type to try to decode.
///     - invalidMock: A mock instance. See above.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func testDecoding<T, O>(_ type: T.Type, failsFor invalidMock: O, file: StaticString = #file, line: UInt = #line) where T : Codable, O : Encodable {

    do {
        let encoded = try JSONEncoder().encode([invalidMock])
        let decoded = try JSONDecoder().decode([T].self, from: encoded).first!
        fail(String(UserFacing<StrictString, APILocalization>({ localization in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "No error thrown. Decoded: \(arbitraryDescriptionOf: decoded)"
            }
        }).resolved()), file: file, line: line)
    } catch {
        // Expected.
    }
}
