/*
 CodingTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

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
        XCTAssertEqual(decoded[0], instance, "Recoding produced a different value.")

        for format in equivalentFormats {
            let file = format.file
            let decoded = try decoder.decode([T].self, from: file)
            XCTAssertEqual(decoded[0], instance, "Format not equivalent: \(format)")
        }
    } catch let error {
        XCTFail("\(error)", file: file, line: line)
    }
}
