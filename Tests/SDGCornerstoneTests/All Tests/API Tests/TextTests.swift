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

        XCTAssert(CharacterSet.whitespaces.linuxSafeIsEqual(to: CharacterSet.whitespaces))
    }

    func testUnicodeScalar() {
        XCTAssert(("A" as UnicodeScalar).hexadecimalCode == "0041", "A.hexadecimalCode → \(("A" as UnicodeScalar).hexadecimalCode) ≠ 0041")
        XCTAssert(("‐" as UnicodeScalar).hexadecimalCode == "2010", "‐.hexadecimalCode → \(("−" as UnicodeScalar).hexadecimalCode) ≠ 2010")

        func verifyVisible(_ codePoint: Int) {
            if let scalar = UnicodeScalar(codePoint) {
                #if !os(Linux)
                    // [_Workaround: A number of obscure compatibility characters end up empty on Linux. (Swift 3.1.0)_]
                    XCTAssert(scalar.visibleRepresentation ≠ "", "\(scalar.hexadecimalCode).visibleRepresentation → [Empty String]")
                #endif
            }
        }
        for codePoint in 0 ..< 0xFF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x300 ..< 0x3FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x600 ..< 0x6FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x700 ..< 0x7FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x800 ..< 0x8FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x1600 ..< 0x16FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x1800 ..< 0x18FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x2000 ..< 0x20FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x3000 ..< 0x30FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0xFE00 ..< 0xFFFF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x11000 ..< 0x110FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x1BC00 ..< 0x1BCFF {
            verifyVisible(codePoint)
        }
        for codePoint in 0x1D100 ..< 0x1D1FF {
            verifyVisible(codePoint)
        }
        for codePoint in 0xE0000 ..< 0xE00FF {
            verifyVisible(codePoint)
        }
    }

    static var allTests: [(String, (TextTests) -> () throws -> Void)] {
        return [
            ("testCharacterSet", testCharacterSet),
            ("testUnicodeScalar", testUnicodeScalar)
        ]
    }
}
