/*
 XML.Encoder.Element.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGText

extension XML.Encoder {

  internal class Element {

    // MARK: - Initialization

    internal init(name: StrictString) {
      self.name = name
    }

    // MARK: - Properties

    internal var name: StrictString
    internal var data: StrictString?
    internal var children: [Element] = []
    internal var ordered: Bool = true

    // MARK: - Convertions

    internal func modelElement(indentationLevel: Int = 0) -> XML.Element {
      let content: [XML.Content]
      if let text = data {
        content = [.characterData(XML.CharacterData(text: text))]
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
      return XML.Element(name: XML.sanitize(name: name), content: content)
    }
  }
}
