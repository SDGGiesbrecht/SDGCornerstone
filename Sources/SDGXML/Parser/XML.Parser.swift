/*
 XML.Parser.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(FoundationXML)
  import FoundationXML
#endif

import SDGText
import SDGPersistence

extension XML {

  internal class Parser: NSObject, XMLParserDelegate {

    // MARK: - Static Methods

    internal static func parse(_ source: StrictString) throws -> XML.Document {
      return try Parser(source: source).parse()
    }

    // MARK: - Initialization

    private init(source: StrictString) {
      parser = Foundation.XMLParser(data: source.file)
      super.init()
      parser.delegate = self
    }

    // MARK: - Properties

    private let parser: Foundation.XMLParser
    private var document: XML.Document?
    private var openElements: [XML.Element] = []
    private var error: Error?

    // MARK: - Parsing

    private func parse() throws -> XML.Document {
      if parser.parse() {
        return document!
      } else {
        throw error!
      }
    }

    // MARK: - XMLParserDelegate

    internal func parser(
      _ parser: XMLParser,
      didStartElement elementName: String,
      namespaceURI: String?,
      qualifiedName qName: String?,
      attributes attributeDict: [String: String] = [:]
    ) {
      var attributes: [StrictString: AttributeValue] = [:]
      for (key, value) in attributeDict {
        attributes[StrictString(key)] = AttributeValue(text: StrictString(value))
      }
      openElements.append(XML.Element(name: StrictString(elementName), attributes: attributes))
    }

    internal func parser(
      _ parser: XMLParser,
      didEndElement elementName: String,
      namespaceURI: String?,
      qualifiedName qName: String?
    ) {
      let complete = openElements.popLast()!
      if let parent = openElements.indices.last {
        openElements[parent].content.append(.element(complete))
      } else {
        document = XML.Document(rootElement: complete)
      }
    }

    internal func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
      error = parseError
    }

    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
      if let last = openElements.indices.last {
        openElements[last].content.append(.characterData(CharacterData(text: StrictString(string))))
      }
    }

    internal func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
      do {
        self.parser(parser, foundCharacters: try String(file: CDATABlock, origin: nil))
      } catch {  // @exempt(from: tests) Reachable only with corrupt UTF‐8.
        self.error = error
        self.parser.abortParsing()
      }
    }
  }
}
