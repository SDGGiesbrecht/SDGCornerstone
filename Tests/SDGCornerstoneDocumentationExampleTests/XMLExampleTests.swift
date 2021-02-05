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

import SDGXML

import SDGXCTestUtilities

class XMLExampleTests: TestCase {

  func testXMLEncoding() throws {

    // @example(xmlEncoding)
    struct Document: Codable {

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
    }

    let encoder = XML.Encoder()
    let xml = try encoder.encodeToSource(Document())
    #warning("Document stuff missing.")
    #warning("Root element name not customized.")
    XCTAssertEqual(
      xml,
      [
        #"<Document attribute="attribute">"#,
        #" <basicChildElement>basic child element</basicChildElement>"#,
        #" <custom>A mix of text and <elements/>.</custom>"#,
        #"</Document>"#,
      ].joined(separator: "\n")
    )
    // @endExample
  }
}
