/*
 TextTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    func testStrictString() {

        var string = StrictString("\u{BC}")
        let appendix: UnicodeScalar = "\u{BD}"
        string.append(appendix)
        XCTAssert(String(string) == "1⁄41⁄2", "Normalization problem.")

        let decomposed = StrictString("éé")
        let decomposed2 = StrictString("́ée")
        XCTAssert(decomposed.firstMatch(for: "e".scalars)?.range == decomposed.startIndex ..< decomposed.index(after: decomposed.startIndex), "Problem with decomposition.")
        XCTAssert(decomposed2.firstMatch(for: "́".scalars)?.range == decomposed2.startIndex..<decomposed2.index(after: decomposed2.startIndex), "Problem with decomposition.")

        let components = decomposed.components(separatedBy: "́".scalars).map({StrictString($0.contents)})
        XCTAssert(components == [StrictString("e"), StrictString("e"), StrictString()], "Problem with decomposition.")
        let separatedComponents = decomposed.components(separatedBy: "e".scalars).map({StrictString($0.contents)})
        XCTAssert(separatedComponents == [StrictString(), StrictString("́"), StrictString("́")], "Problem with decomposition: \(separatedComponents) ≠ “”, “́”, & “́”")

        XCTAssert(decomposed.hasPrefix("e".scalars), "Problem with decomposition.")
        XCTAssert(decomposed.hasSuffix("́".scalars), "Problem with decomposition.")

        XCTAssert(decomposed2.hasPrefix("́".scalars), "Problem with decomposition.")
        XCTAssert(decomposed2.hasSuffix("e".scalars), "Problem with decomposition.")

        let commonPrefix = StrictString(decomposed.commonPrefix(with: "ee".scalars).contents)
        XCTAssert(commonPrefix == StrictString("e"), "Problem with decomposition: Common prefix between “éé” and “ee” is “\(commonPrefix)”.")
        XCTAssert(StrictString(decomposed2.commonPrefix(with: "́́".scalars).contents) == StrictString("́"), "Problem with decomposition.")

        XCTAssert(StrictString(decomposed.commonSuffix(with: "́́".scalars).contents) == StrictString("́"), "Problem with decomposition.")
        XCTAssert(StrictString(decomposed2.commonSuffix(with: "ee".scalars).contents) == StrictString("e"), "Problem with decomposition.")

        var decomposedCopy = decomposed
        decomposedCopy.replaceMatches(for: "e".scalars, with: "a".scalars)
        XCTAssert(decomposedCopy == "áá", "Problem with decomposition: \(decomposed).replaceMatches(for: e, with: a) → \(decomposedCopy) ≠ áá")

        decomposedCopy = decomposed
        decomposedCopy.replaceMatches(for: "́".scalars, with: "̀".scalars)
        XCTAssert(decomposedCopy == "èè", "Problem with decomposition: \(decomposed).replaceMatches(for: ́, with: ̀) → \(decomposedCopy) ≠ èè")

        decomposedCopy = decomposed2
        decomposedCopy.replaceMatches(for: "e".scalars, with: "a".scalars)
        XCTAssert(decomposedCopy == "́áa", "Problem with decomposition: \(decomposed2).replaceMatches(for: e, with: a) → \(decomposedCopy) ≠ ́áa")

        decomposedCopy = decomposed2
        decomposedCopy.replaceMatches(for: "́".scalars, with: "̀".scalars)
        XCTAssert(decomposedCopy == "̀èe", "Problem with decomposition: \(decomposed2).replaceMatches(for: ́, with: ̀) → \(decomposedCopy) ≠ ̀èe")

        let clusters = StrictString("0").clusters
        XCTAssert(clusters.index(before: clusters.endIndex) == clusters.startIndex)

        XCTAssert(StrictString.ClusterView("0".characters).elementsEqual(clusters))
        let slice = clusters[clusters.startIndex ..< clusters.endIndex]
        XCTAssert(StrictString.ClusterView(slice).elementsEqual(clusters))

        XCTAssert(StrictString("A" as ExtendedGraphemeCluster) == "A")
        XCTAssert("...\(StrictString("A"))..." == "...A...")

        var mutable: StrictString = "0"
        mutable.clusters.truncate(at: mutable.clusters.startIndex)
        XCTAssert(mutable == "")

        mutable = "ABC"
        mutable.write("DEF")
        XCTAssert(mutable == "ABCDEF")

        mutable.write(to: &mutable)
        XCTAssert(mutable == "ABCDEFABCDEF")

        XCTAssert(StrictString("A").description == "A")
    }

    func testString() {
        func runTests<S : StringFamily>(helloWorld: S) {

            XCTAssert(S(helloWorld.scalars) == helloWorld)
            XCTAssert(S(helloWorld.clusters) == helloWorld)

            XCTAssert(helloWorld.scalars.first ≠ nil)

            let set: Set<S> = [helloWorld]
            XCTAssert(helloWorld ∈ set)

            XCTAssert(S(S.ClusterView()).scalars.isEmpty)
            XCTAssert(S(S.ScalarView()).clusters.isEmpty)
        }

        runTests(helloWorld: "Hello, world!")
        runTests(helloWorld: StrictString("Hello, world!"))

        XCTAssert(StrictString("Hello, world!") == "Hello, world!")
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

    func testUnicodeScalarView() {
        func runTests<S : StringFamily>(helloWorld: S) where S.ScalarView.Iterator.Element == UnicodeScalar {

            XCTAssert(helloWorld.scalars.contains("world".scalars))
            XCTAssert(¬helloWorld.scalars.contains("xyz".scalars))

            XCTAssert(helloWorld.scalars[helloWorld.scalars.startIndex] == "H")

            for _ in helloWorld.scalars {}

            var variable = helloWorld
            variable.scalars.replaceSubrange(variable.scalars.index(after: variable.scalars.startIndex) ..< variable.scalars.index(before: variable.scalars.endIndex), with: "...".scalars)
            XCTAssert(variable.scalars.elementsEqual("H...!".scalars))
        }

        runTests(helloWorld: "Hello, world!")
        runTests(helloWorld: StrictString("Hello, world!"))
    }

    static var allTests: [(String, (TextTests) -> () throws -> Void)] {
        return [
            ("testCharacterSet", testCharacterSet),
            ("testString", testString),
            ("testUnicodeScalar", testUnicodeScalar),
            ("testUnicodeScalarView", testUnicodeScalarView)
        ]
    }
}
