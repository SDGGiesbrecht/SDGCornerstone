/*
 XML.Document.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML {

  /// An XML document.
  public struct Document {

    // MARK: - Static Methods

    /// Parses a document from its XML source.
    public static func parse(source: StrictString) throws -> XML.Document {
      #warning("Switch to initializer if no specialized errors?")
      return try XML.Parser.parse(source)
    }

    // MARK: - Initialization

    /// Creates an XML document.
    ///
    /// - Parameters:
    ///   - rootElement: The root element.
    public init(rootElement: Element) {
      self.rootElement = rootElement
    }

    // MARK: - Properties

    /// The root element.
    public var rootElement: Element
  }
}
