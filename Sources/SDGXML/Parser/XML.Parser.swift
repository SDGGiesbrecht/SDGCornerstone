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
#if !PLATFORM_LACKS_FOUNDATION_XML
  #if canImport(FoundationXML)
    import FoundationXML
  #endif
#endif

import SDGCollections
import SDGText
import SDGPersistence

extension XML {

  #if !PLATFORM_LACKS_FOUNDATION_XML
    internal class Parser: NSObject, XMLParserDelegate {

      // MARK: - Aliases

      #if canImport(FoundationXML)
        private typealias FoundationXMLParser = FoundationXML.XMLParser
      #else
        private typealias FoundationXMLParser = Foundation.XMLParser
      #endif

      // MARK: - Static Methods

      internal static func parse(_ source: StrictString) throws -> XML.Document {
        return try Parser(source: source).parse()
      }

      // MARK: - Initialization

      private init(source: StrictString) {
        self.source = source
        parser = FoundationXMLParser(data: source.file)
        super.init()
        parser.delegate = self
      }

      // MARK: - Properties

      private let source: StrictString
      private let parser: FoundationXMLParser

      private var dtd: XML.DTD?
      private var document: XML.Document?
      private var openElements: [XML.Element] = []
      private var error: Error?

      // MARK: - Parsing

      private func parse() throws -> XML.Document {

        // Foundation.XMLParser does not report the DTD.
        parseDTD()

        if parser.parse() {
          guard var document = document else {
            // @exempt(from: tests) XMLParser should have thrown this itself.
            throw NSError(
              domain: XMLParser.errorDomain,
              code: XMLParser.ErrorCode.prematureDocumentEndError.rawValue,
              userInfo: nil
            )
          }
          document.dtd = dtd
          return document
        } else {
          // @exempt(from: tests) Some immature platforms fail to throw on their own.
          throw error!
        }
      }

      private func parseDTD() {
        if let doctypeStart = source.firstMatch(for: "<!DOCTYPE ".scalars),
          let doctypeEnd = source[doctypeStart.range.upperBound...].firstMatch(for: ">".scalars)
        {
          let doctypeContents = source[doctypeStart.range.upperBound..<doctypeEnd.range.lowerBound]
          if let systemStart = doctypeContents.firstMatch(for: " SYSTEM \u{22}".scalars),
            let systemEnd = doctypeContents[systemStart.range.upperBound...].firstMatch(
              for: "\u{22}".scalars
            )
          {
            let identifier = StrictString(
              doctypeContents[systemStart.range.upperBound..<systemEnd.range.lowerBound]
            )
            dtd = .system(identifier)
          }
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
          openElements[last].content.append(
            .characterData(CharacterData(text: StrictString(string)))
          )
        }
      }

      internal func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        do {
          self.parser(parser, foundCharacters: try String(file: CDATABlock, origin: nil))
        } catch {
          // @exempt(from: tests) Reachable only with corrupt UTF‐8.
          self.error = error
          self.parser.abortParsing()
        }
      }
    }
  #endif
}
