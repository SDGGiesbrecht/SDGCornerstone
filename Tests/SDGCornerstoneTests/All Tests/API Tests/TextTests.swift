/*
 TextTests.swift

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

class TextTests : XCTestCase {

    func testCharacterSet() {
        let A = CharacterSet(charactersIn: "A")
        XCTAssert("A" ∈ A, "A ∉ \(A)")
        XCTAssert("B" ∉ A, "B ∈ \(A)")
        let a = CharacterSet(charactersIn: "Aa")
        XCTAssert(A ⊆ a, "\(A) ⊈ \(a)")
        XCTAssert(a ⊈ A, "\(a) ⊆ \(A)")

        XCTAssert(a ⊆ CharacterSet.alphanumerics, "\(a) ⊈ \(CharacterSet.alphanumerics)")
        XCTAssert(CharacterSet.alphanumerics ⊈ a, "\(CharacterSet.alphanumerics) ⊆ \(a)")

        XCTAssert(A ⊆ CharacterSet.uppercaseLetters, "\(A) ⊈ \(CharacterSet.uppercaseLetters)")
        XCTAssert(CharacterSet.uppercaseLetters ⊈ A, "\(CharacterSet.uppercaseLetters) ⊆ \(A)")

        XCTAssert(CharacterSet.uppercaseLetters ⊆ CharacterSet.alphanumerics, "\(CharacterSet.uppercaseLetters) ⊈ \(CharacterSet.alphanumerics)")
        XCTAssert(CharacterSet.alphanumerics ⊈ CharacterSet.uppercaseLetters, "\(CharacterSet.alphanumerics) ⊆ \(CharacterSet.uppercaseLetters)")
    }

    static var allTests: [(String, (TextTests) -> () throws -> Void)] {
        return [
            ("testCharacterSet", testCharacterSet)
        ]
    }
}
