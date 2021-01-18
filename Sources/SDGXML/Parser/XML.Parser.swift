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
      document = XML.Document()
      super.init()
      parser.delegate = self
    }

    // MARK: - Properties

    private let parser: Foundation.XMLParser
    private var document: XML.Document
    private var openElements: [XML.Element] = []
    private var error: Error?

    // MARK: - Parsing

    private func parse() throws -> XML.Document {
      if parser.parse() {
        return document
      } else {
        throw error!
      }
    }

    // MARK: - XMLParserDelegate

    // Not needed:
    // parserDidStartDocument(_:)
    // parserDidEndDocument(_:)

    internal func parser(
      _ parser: XMLParser,
      didStartElement elementName: String,
      namespaceURI: String?,
      qualifiedName qName: String?,
      attributes attributeDict: [String: String] = [:]
    ) {
      #warning("“namespaceURL” not implemented yet.")
      #warning("“qualifiedName” not implemented yet.")
      #warning("“attributes” not implemented yet.")
      openElements.append(XML.Element(name: StrictString(elementName)))
    }

    internal func parser(
      _ parser: XMLParser,
      didEndElement elementName: String,
      namespaceURI: String?,
      qualifiedName qName: String?
    ) {
      let complete = openElements.popLast()
      if let parent = openElements.indices.last {
        openElements[parent].content.append(.element(complete!))
      }
    }

    internal func parser(
      _ parser: XMLParser,
      didStartMappingPrefix prefix: String,
      toURI namespaceURI: String
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      resolveExternalEntityName name: String,
      systemID: String?
    ) -> Data? {
      #warning("Not implemented yet.")
      print(#function)
      fatalError()
    }

    internal func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundProcessingInstructionWithTarget target: String,
      data: String?
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(_ parser: XMLParser, foundComment comment: String) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundAttributeDeclarationWithName attributeName: String,
      forElement elementName: String,
      type: String?,
      defaultValue: String?
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundElementDeclarationWithName elementName: String,
      model: String
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundExternalEntityDeclarationWithName name: String,
      publicID: String?,
      systemID: String?
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundInternalEntityDeclarationWithName name: String,
      value: String?
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundUnparsedEntityDeclarationWithName name: String,
      publicID: String?,
      systemID: String?,
      notationName: String?
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }

    internal func parser(
      _ parser: XMLParser,
      foundNotationDeclarationWithName name: String,
      publicID: String?,
      systemID: String?
    ) {
      #warning("Not implemented yet.")
      print(#function)
    }
  }
}
