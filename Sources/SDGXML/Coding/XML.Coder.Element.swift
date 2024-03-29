/*
 XML.Coder.Element.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText

extension XML.Coder {

  internal class Element {

    // MARK: - Initialization

    internal init(name: StrictString) {
      self.name = name
    }

    // MARK: - Properties

    internal var name: StrictString
    internal var attributes: [StrictString: StrictString] = [:]
    internal var data: StrictString?
    internal var children: [Element] = []

    internal var literal: XML.Element?

    internal var ordered: Bool = true

    internal var currentIndex: Int = 0

    // MARK: - Nil

    private static var nilAttribute: StrictString { "xsi:nil" }
    private static var nilValue: StrictString { "true" }
    internal var isNil: Bool {
      get {
        return attributes[Element.nilAttribute] == Element.nilValue
      }
      set {
        if newValue {
          attributes[Element.nilAttribute] = Element.nilValue
        } else {
          // @exempt(from: tests) Unreachable.
          attributes[Element.nilAttribute] = nil
        }
      }
    }

    // MARK: - Conversions

    internal func modelElement(indentationLevel: Int = 0) -> XML.Element {
      if let literal = self.literal {
        return literal
      }

      let content: [XML.Content]
      if let text = data {
        content = [.characterData(XML.CharacterData(text: text))]
      } else if children.isEmpty {
        // Don’t add spaces so the empty element will use a collapsed tag.
        content = []
      } else {
        var children = self.children
        if ¬ordered {
          children.sort(by: { $0.name < $1.name })
        }

        let indentationString: StrictString =
          "\n" + StrictString(repeating: " ", count: indentationLevel)
        let childIndentString: StrictString = indentationString.appending(contentsOf: " ")
        let indentation: XML.Content = .characterData(XML.CharacterData(text: indentationString))
        let childIndentation: XML.Content = .characterData(
          XML.CharacterData(text: childIndentString)
        )
        var formatted: [XML.Content] = []
        formatted.reserveCapacity(children.count × 2 + 1)
        for child in children {
          formatted.append(childIndentation)
          formatted.append(.element(child.modelElement(indentationLevel: indentationLevel + 1)))
        }
        formatted.append(indentation)

        content = formatted
      }

      var attributes: [StrictString: XML.AttributeValue] = [:]
      attributes.reserveCapacity(self.attributes.count)
      for (attribute, value) in self.attributes {
        attributes[XML.sanitize(name: attribute)] = XML.AttributeValue(text: value)
      }
      return XML.Element(name: XML.sanitize(name: name), attributes: attributes, content: content)
    }

    internal init(_ modelElement: XML.Element) {

      self.literal = modelElement

      self.name = XML.unsanitize(name: modelElement.name)

      var attributes: [StrictString: StrictString] = [:]
      attributes.reserveCapacity(modelElement.attributes.count)
      for (attribute, value) in modelElement.attributes {
        attributes[XML.unsanitize(name: attribute)] = value.text
      }
      self.attributes = attributes

      self.data = nil
      self.children = []
      for content in modelElement.content {
        switch content {
        case .characterData(let text):
          if data == nil {
            data = text.text
          }
        case .element(let child):
          children.append(XML.Coder.Element(child))
        }
      }
    }
  }
}
