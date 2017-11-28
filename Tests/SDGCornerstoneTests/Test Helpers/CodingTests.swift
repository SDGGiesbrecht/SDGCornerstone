/*
 CodingTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGCornerstone

internal func XCTAssertRecodes<T>(_ instance: T, equivalentFormats: [String] = [], file: StaticString = #file, line: UInt = #line) where T : Codable, T : Equatable {
    let coder = JSONEncoder()
    let decoder = JSONDecoder()

    do {
        let encoded = try coder.encode([instance])
        print("\(instance) → \(try String(file: encoded, origin: nil))")
        let decoded = try decoder.decode([T].self, from: encoded)
        XCTAssertEqual(decoded[0], instance, "Recoding produced a different value.", file: file, line: line)

        for format in equivalentFormats {
            let data = format.file
            let decoded = try decoder.decode([T].self, from: data)
            XCTAssertEqual(decoded[0], instance, "Format not equivalent: \(format)", file: file, line: line)
        }
    } catch let error {
        XCTFail("\(error)", file: file, line: line)
    }
}

internal func XCTAssertThrows<T>(whileDecoding encoded: String, as type: T.Type, file: StaticString = #file, line: UInt = #line) where T : Decodable {
    let decoder = JSONDecoder()
    do {
        let decoded = try decoder.decode([T].self, from: encoded.file)
        XCTFail("No error thrown. Decoded value: \(decoded)", file: file, line: line)
    } catch {
        // Expected.
    }
}
