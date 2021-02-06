/*
 XMLExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGText
import SDGXML

import SDGXCTestUtilities

class XMLExampleTests: TestCase {

  func testXMLEncoding() throws {
    #if !PLATFORM_LACKS_FOUNDATION_XML
      // @example(xmlEncoding)
      struct Document: Codable, CustomXMLRepresentable {

        var dtd: XML.DTD? {  // CustomXMLRepresentable
          return .system("file://localhost/Some/File.dtd")
        }

        var defaultElementName: StrictString? {  // CustomXMLRepresentable
          return "document"
        }

        var basicChildElement: String = "basic child element"

        @XML.Attribute var attribute: String = "attribute"

        struct CustomChild: Codable {
          init() {}
          func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(
              XML.Element(
                name: "custom",
                content: [
                  .characterData("A mix of text and "),
                  .element(XML.Element(name: "elements")),
                  .characterData("."),
                ]
              )
            )
          }
          init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let element = try container.decode(XML.Element.self)
            XCTAssertEqual(element.name, "custom")
            XCTAssertEqual(element.content.first?.description, "A mix of text and ")
          }
        }
        var custom: CustomChild = CustomChild()

        struct UnnamedChild: Codable {
          init() {}
        }
        var unnamedArray: [UnnamedChild] = [UnnamedChild(), UnnamedChild(), UnnamedChild()]

        struct NamedChild: Codable, CustomXMLRepresentable {
          var defaultElementName: StrictString? {
            return "named"
          }
        }
        var namedArray: [NamedChild] = [NamedChild(), NamedChild(), NamedChild()]
      }

      let encoder = XML.Encoder()
      let xml = try encoder.encodeToSource(Document())
      XCTAssertEqual(
        xml,
        [
          "<?xml version=\u{22}1.1\u{22} encoding=\u{22}UTF\u{2D}8\u{22}?>",
          "<!DOCTYPE document SYSTEM \u{22}file://localhost/Some/File.dtd\u{22}>",
          "<document attribute=\u{22}attribute\u{22}>",
          " <basicChildElement>basic child element</basicChildElement>",
          " <custom>A mix of text and <elements/>.</custom>",
          " <namedArray>",
          "  <named/>",
          "  <named/>",
          "  <named/>",
          " </namedArray>",
          " <unnamedArray>",
          "  <UnnamedChild/>",
          "  <UnnamedChild/>",
          "  <UnnamedChild/>",
          " </unnamedArray>",
          "</document>",
        ].joined(separator: "\n")
      )
    // @endExample
    endif
  }
}
