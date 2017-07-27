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

class TextTests : TestCase {

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

    func testLineView() {
        let fileLines = [
            "Line 1",
            "Line 2",
            "Line 3"
        ]
        var file = fileLines.joined(separator: "\n")
        XCTAssertEqual(file.lines.map({ String($0.line) }), fileLines)

        file = fileLines.joined(separator: "\u{D}\u{A}")
        XCTAssertEqual(file.lines.map({ String($0.line) }), fileLines)

        file.lines.removeFirst()
        XCTAssertEqual(file.lines.map({ String($0.line) }), Array(fileLines.dropFirst()))

        var index = file.lines.startIndex
        index = file.lines.index(after: index)
        XCTAssertEqual(file.lines.distance(from: file.lines.startIndex, to: index), 1)
        XCTAssertEqual(file.lines.index(before: index), file.lines.startIndex)

        file = fileLines.joined(separator: "\n")
        index = file.lines.index(after: file.lines.startIndex)
        file.lines[index] = Line(line: "Replaced", newline: "\u{2029}")
        XCTAssertEqual(file, "Line 1\nReplaced\u{2029}Line 3")

        XCTAssertEqual(String(LineView<String>()), "")
        XCTAssertEqual(String(LineView<String>([Line(line: "", newline: "\n")])), "\n")
        var lines = LineView<String>()
        lines.append(contentsOf: [Line(line: "", newline: "\n")])
        XCTAssertEqual(String(lines), "\n")
        lines.insert(contentsOf: [Line(line: "", newline: "\n")], at: lines.startIndex)
        XCTAssertEqual(String(lines), "\n\n")
    }

    func testLineViewIndex() {
        let strict: StrictString = "123\n456\n789"
        let string = String(strict)

        XCTAssertEqual(strict.lines.startIndex.samePosition(in: strict.scalars), strict.scalars.startIndex)
        XCTAssertEqual(string.lines.startIndex.samePosition(in: string.scalars), string.scalars.startIndex)

        let index = strict.lines.index(after: strict.lines.startIndex)
        XCTAssertEqual(index.samePosition(in: strict.scalars), strict.scalars.index(strict.scalars.startIndex, offsetBy: 4))
        let stringIndex = string.lines.index(after: string.lines.startIndex)
        XCTAssertEqual(stringIndex.samePosition(in: string.scalars), string.scalars.index(string.scalars.startIndex, offsetBy: 4))

        XCTAssertEqual(index.samePosition(in: strict.clusters), strict.clusters.index(strict.clusters.startIndex, offsetBy: 4))
        XCTAssertEqual(stringIndex.samePosition(in: string.clusters), string.clusters.index(string.clusters.startIndex, offsetBy: 4))
    }

    func testSemanticMarkup() {
        let markup: SemanticMarkup = "..."
        XCTAssertEqual(markup.scalars, markup.source.scalars)
        XCTAssertEqual(StrictString(markup.clusters), StrictString(markup.source.clusters))
        XCTAssertEqual(StrictString(markup.lines), StrictString(markup.source.lines))

        var mutable = markup
        mutable.scalars  = markup.scalars
        mutable.clusters = markup.clusters
        mutable.lines = markup.lines
        XCTAssertEqual(mutable.scalars, markup.scalars)
        XCTAssertEqual(StrictString(mutable.clusters), StrictString(markup.clusters))
        XCTAssertEqual(StrictString(mutable.lines), StrictString(markup.lines))

        XCTAssertEqual(markup.subscripted().rawTextApproximation(), "...")

        XCTAssert(markup.hashValue ≤ Int.max)
        XCTAssertEqual(SemanticMarkup("").source, "")
        XCTAssertEqual(SemanticMarkup(["A", "B", "C"]).source, "ABC")
        XCTAssertEqual(SemanticMarkup().source, "")
    }

    func testStrictString() {

        var string = StrictString("\u{BC}")
        let appendix: UnicodeScalar = "\u{BD}"
        string.append(appendix)
        XCTAssertEqual(String(string), "1⁄41⁄2", "Normalization problem.")

        let decomposed = StrictString("éé")
        let decomposed2 = StrictString("́ée")
        XCTAssertEqual(decomposed.firstMatch(for: "e".scalars)?.range, decomposed.startIndex ..< decomposed.index(after: decomposed.startIndex))
        XCTAssertEqual(decomposed2.firstMatch(for: "́".scalars)?.range, decomposed2.startIndex..<decomposed2.index(after: decomposed2.startIndex))

        let components = decomposed.components(separatedBy: "́".scalars).map({StrictString($0.contents)})
        XCTAssertEqual(components, [StrictString("e"), StrictString("e"), StrictString()])
        let separatedComponents = decomposed.components(separatedBy: "e".scalars).map({StrictString($0.contents)})
        XCTAssertEqual(separatedComponents, [StrictString(), StrictString("́"), StrictString("́")])

        XCTAssert(decomposed.hasPrefix("e".scalars), "Problem with decomposition.")
        XCTAssert(decomposed.hasSuffix("́".scalars), "Problem with decomposition.")

        XCTAssert(decomposed2.hasPrefix("́".scalars), "Problem with decomposition.")
        XCTAssert(decomposed2.hasSuffix("e".scalars), "Problem with decomposition.")

        let commonPrefix = StrictString(decomposed.commonPrefix(with: "ee".scalars).contents)
        XCTAssertEqual(commonPrefix, StrictString("e"))
        XCTAssertEqual(StrictString(decomposed2.commonPrefix(with: "́́".scalars).contents), StrictString("́"))

        XCTAssertEqual(StrictString(decomposed.commonSuffix(with: "́́".scalars).contents), StrictString("́"))
        XCTAssertEqual(StrictString(decomposed2.commonSuffix(with: "ee".scalars).contents), StrictString("e"))

        var decomposedCopy = decomposed
        decomposedCopy.replaceMatches(for: "e".scalars, with: "a".scalars)
        XCTAssertEqual(decomposedCopy, "áá")

        decomposedCopy = decomposed
        decomposedCopy.replaceMatches(for: "́".scalars, with: "̀".scalars)
        XCTAssertEqual(decomposedCopy, "èè")

        decomposedCopy = decomposed2
        decomposedCopy.replaceMatches(for: "e".scalars, with: "a".scalars)
        XCTAssertEqual(decomposedCopy, "́áa")

        decomposedCopy = decomposed2
        decomposedCopy.replaceMatches(for: "́".scalars, with: "̀".scalars)
        XCTAssertEqual(decomposedCopy, "̀èe")

        let clusters = StrictString("0").clusters
        XCTAssertEqual(clusters.index(before: clusters.endIndex), clusters.startIndex)

        XCTAssert(StrictString.ClusterView("0".characters).elementsEqual(clusters))
        let slice = clusters[clusters.startIndex ..< clusters.endIndex]
        XCTAssert(StrictString.ClusterView(slice).elementsEqual(clusters))

        XCTAssertEqual(StrictString("A" as ExtendedGraphemeCluster), "A")
        XCTAssertEqual("...\(StrictString("A"))...", "...A...")

        var mutable: StrictString = "0"
        mutable.clusters.truncate(at: mutable.clusters.startIndex)
        XCTAssertEqual(mutable, "")

        mutable = "ABC"
        mutable.write("DEF")
        XCTAssertEqual(mutable, "ABCDEF")

        mutable.write(to: &mutable)
        XCTAssertEqual(mutable, "ABCDEFABCDEF")

        XCTAssertEqual(StrictString("A").description, "A")

        XCTAssert(StrictString("A") < StrictString("B"))

        XCTAssertEqual(StrictString("..." as StaticString), "...")
    }

    func testString() {
        func runTests<S : StringFamily>(helloWorld: S) {

            XCTAssertEqual(S(helloWorld.scalars), helloWorld)
            XCTAssertEqual(S(helloWorld.clusters), helloWorld)

            XCTAssertNotNil(helloWorld.scalars.first)

            let set: Set<S> = [helloWorld]
            XCTAssert(helloWorld ∈ set)

            XCTAssert(S(S.ClusterView()).scalars.isEmpty)
            XCTAssert(S(S.ScalarView()).clusters.isEmpty)
        }

        runTests(helloWorld: "Hello, world!")
        runTests(helloWorld: StrictString("Hello, world!"))

        XCTAssertEqual(StrictString("Hello, world!"), "Hello, world!")

        let simple = "1"
        let simpleUTF8 = try? String(file: simple.data(using: .utf8)!, origin: nil)
        XCTAssertEqual(simpleUTF8, simple)

        let unicode = "שלום! 🇮🇱 Γεια σας! 🇬🇷"
        let utf8 = try? String(file: unicode.data(using: .utf8)!, origin: nil)
        XCTAssertEqual(utf8, unicode)
        let utf16 = try? String(file: unicode.data(using: .utf16)!, origin: nil)
        XCTAssertEqual(utf16, unicode)
        #if false
            // [_Workaround: macOS does not fail UTF‐16 on invalid surrogate use, so this is mistaken for UTF‐16. (Swift 3.1.0)_]
            let utf32 = try? String(file: unicode.data(using: .utf32)!, origin: nil)
            XCTAssertEqual(utf32, unicode)

            let european = "¡¢£¤¥§©«¬®°±¶·»¿ÆÐ×Þßæð÷þ".data(using: .isoLatin1)! + Data([0xD8, 0x00, 0xD8, 0x00, 0x00, 0xD8, 0x00, 0xD8])
            let latin1 = try? String(file: european, origin: nil)
            XCTAssertEqual(latin1?.data(using: .isoLatin1), european)
        #endif
    }

    func testStringClusterIndex() {
        let strict = StrictString("français")
        let string = String(strict)
        let index = string.clusters.index(string.clusters.startIndex, offsetBy: 7)
        XCTAssertEqual(index.samePosition(in: strict.scalars), strict.scalars.index(strict.scalars.startIndex, offsetBy: 8))
        XCTAssertEqual(string.clusters.startIndex.samePosition(in: strict.lines), strict.lines.startIndex)
        XCTAssertNil(index.samePosition(in: strict.lines))
        XCTAssertEqual(index.line(in: strict.lines), strict.lines.startIndex)

        XCTAssertEqual(index.samePosition(in: string.scalars), string.scalars.index(string.scalars.startIndex, offsetBy: 8))
        XCTAssertEqual(string.clusters.startIndex.samePosition(in: string.lines), string.lines.startIndex)
        XCTAssertNil(index.samePosition(in: string.lines))
        XCTAssertEqual(index.line(in: string.lines), string.lines.startIndex)
    }

    func testStringScalarIndex() {
        let strict = StrictString("français")
        let string = String(strict)
        let index = string.scalars.index(string.scalars.startIndex, offsetBy: 8)
        let internalIndex = string.scalars.index(string.scalars.startIndex, offsetBy: 5)
        XCTAssertEqual(index.samePosition(in: strict.clusters), strict.clusters.index(strict.clusters.startIndex, offsetBy: 7))
        XCTAssertNil(internalIndex.samePosition(in: strict.clusters))
        XCTAssertEqual(strict.scalars.startIndex.samePosition(in: strict.lines), strict.lines.startIndex)
        XCTAssertEqual(strict.scalars.endIndex.samePosition(in: strict.lines), strict.lines.endIndex)
        XCTAssertNil(internalIndex.samePosition(in: strict.lines))
        XCTAssertEqual(internalIndex.cluster(in: strict.clusters), strict.clusters.index(strict.clusters.startIndex, offsetBy: 4))

        let multiline = StrictString("123\n456\n789")
        let secondLine = multiline.scalars.index(multiline.scalars.startIndex, offsetBy: 4)
        XCTAssertEqual(secondLine.samePosition(in: multiline.lines), multiline.lines.index(after: multiline.lines.startIndex))
        let middleOfSecondLine = multiline.scalars.index(multiline.scalars.startIndex, offsetBy: 6)
        XCTAssertNil(middleOfSecondLine.samePosition(in: multiline.lines))
        let thirdLine = multiline.scalars.index(multiline.scalars.startIndex, offsetBy: 8)
        XCTAssertEqual(thirdLine.samePosition(in: multiline.lines), multiline.lines.index(multiline.lines.startIndex, offsetBy: 2))

        XCTAssertEqual(multiline.scalars.startIndex.line(in: multiline.lines), multiline.lines.startIndex)
        XCTAssertEqual(secondLine.line(in: multiline.lines), multiline.lines.index(after: multiline.lines.startIndex))
        XCTAssertEqual(middleOfSecondLine.line(in: multiline.lines), multiline.lines.index(after: multiline.lines.startIndex))
        XCTAssertEqual(thirdLine.line(in: multiline.lines), multiline.lines.index(multiline.lines.startIndex, offsetBy: 2))
        XCTAssertEqual(multiline.scalars.endIndex.line(in: multiline.lines), multiline.lines.endIndex)

        let multilineString = String(multiline)
        XCTAssertEqual(secondLine.samePosition(in: multilineString.lines), multilineString.lines.index(after: multilineString.lines.startIndex))
        XCTAssertNil(middleOfSecondLine.samePosition(in: multilineString.lines))
        XCTAssertEqual(thirdLine.samePosition(in: multilineString.lines), multilineString.lines.index(multilineString.lines.startIndex, offsetBy: 2))

        XCTAssertEqual(multilineString.scalars.startIndex.line(in: multilineString.lines), multilineString.lines.startIndex)
        XCTAssertEqual(secondLine.line(in: multilineString.lines), multilineString.lines.index(after: multilineString.lines.startIndex))
        XCTAssertEqual(middleOfSecondLine.line(in: multilineString.lines), multilineString.lines.index(after: multilineString.lines.startIndex))
        XCTAssertEqual(thirdLine.line(in: multilineString.lines), multilineString.lines.index(multilineString.lines.startIndex, offsetBy: 2))
        XCTAssertEqual(multilineString.scalars.endIndex.line(in: multilineString.lines), multilineString.lines.endIndex)

        XCTAssertEqual(multilineString.scalars.endIndex.samePosition(in: multilineString.lines), multilineString.lines.endIndex)
    }

    func testUnicodeScalar() {
        XCTAssertEqual(("A" as UnicodeScalar).hexadecimalCode, "0041")
        XCTAssertEqual(("‐" as UnicodeScalar).hexadecimalCode, "2010")

        func verifyVisible(_ codePoint: Int) {
            if let scalar = UnicodeScalar(codePoint) {
                #if !os(Linux)
                    // [_Workaround: A number of obscure compatibility characters end up empty on Linux. (Swift 3.1.0)_]
                    XCTAssertNotEqual(scalar.visibleRepresentation, "")
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

            XCTAssertEqual(helloWorld.scalars[helloWorld.scalars.startIndex], "H")

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
            ("testLineView", testLineView),
            ("testLineViewIndex", testLineViewIndex),
            ("testSemanticMarkup", testSemanticMarkup),
            ("testStrictString", testStrictString),
            ("testString", testString),
            ("testStringClusterIndex", testStringClusterIndex),
            ("testStringScalarIndex", testStringScalarIndex),
            ("testUnicodeScalar", testUnicodeScalar),
            ("testUnicodeScalarView", testUnicodeScalarView)
        ]
    }
}
