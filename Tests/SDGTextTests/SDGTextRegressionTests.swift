/*
 SDGTextRegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText

import XCTest

import SDGXCTestUtilities

class SDGTextRegressionTests: TestCase {

  func testLastLineNotDropped() {
    // Untracked

    XCTAssertEqual("".lines.count, 1)
    XCTAssertEqual("\n".lines.count, 2)
    XCTAssertEqual("\n\n".lines.count, 3)
  }

  func testMatchlessComponentSeperation() {
    // Untracked

    let glitch = StrictString("@version 8.0.0")
    let components = glitch.components(
      separatedBy: ConditionalPattern({ $0 ∈ ["#", "%"] as Set<UnicodeScalar> })
    )
    XCTAssert(¬components.isEmpty, "Empty result of splitting collection at matches.")
  }

  func testMatchlessSearch() {
    // Untracked

    XCTAssertNil(StrictString("...").firstMatch(for: "_".scalars))
  }

  func testNestingLevelLocation() {
    // Untracked

    let nestString = StrictString("%{1~a~a^a|^}")
    let open: StrictString = "{"
    let close: StrictString = "}"
    let start = nestString.index(nestString.startIndex, offsetBy: 1)
    let end = nestString.index(nestString.startIndex, offsetBy: 12)
    let nestRange = nestString.firstNestingLevel(startingWith: open, endingWith: close)?.container
      .range
    XCTAssertEqual(nestRange, start..<end)
  }

  func testReverseSearch() {
    // Untracked

    let glitch = StrictString("x{a^a}")
    XCTAssertEqual(
      glitch.lastMatch(for: "{".scalars)?.range,
      glitch.index(
        after: glitch.startIndex
      )..<glitch.index(after: glitch.index(after: glitch.startIndex))
    )
  }

  func testSemanticMarkupToAttributedStringPreservesFont() {
    // Untracked

    #if canImport(AppKit) || canImport(UIKit)
      #if canImport(UIKit)
        typealias NSFont = UIFont
      #endif
      let markup = SemanticMarkup("...")
      for font in [
        Font.system,
        Font.system.resized(to: Font.system.size ÷ 2),
        Font(NSFont(name: "Helvetica", size: 12)!)
      ] {
        let attributedString = markup.richText(font: font)
        let attribute = attributedString.attribute(.font, at: 0, effectiveRange: nil)
        var originalName = font.fontName
        if originalName == ".SFNSText" ∨ originalName == ".SFNS\u{2D}Regular" {
          originalName = ".AppleSystemUIFont"
        }
        var resultingName = (attribute as? NSFont)?.fontName
        if resultingName == ".SFNSText" ∨ resultingName == ".SFNS\u{2D}Regular" {
          resultingName = ".AppleSystemUIFont"
        }
        XCTAssertEqual(resultingName, originalName)
      }
    #endif
  }
}
