/*
 XML.Encoder.Implementation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGText
import SDGLocalization

extension XML.Encoder {

  internal class Implementation: Encoder {

    // MARK: - Initailzation

    internal init(rootElementName: StrictString, userInfo: [CodingUserInfoKey: Any]) {
      partialElements = [XML.Element(name: rootElementName)]
      codingPath = []
      self.userInfo = userInfo
    }

    // MARK: - State

    private var partialElements: [XML.Element]
    internal var currentElement: XML.Element {
      get {
        return partialElements.last!
      }
      set {
        let last = partialElements.indices.last!
        partialElements[last] = newValue
      }
    }

    internal func beginElement(named name: CodingKey) {
      codingPath.append(name)
      partialElements.append(XML.Element(name: XML.sanitize(name: StrictString(name.stringValue))))
    }
    internal func endElement(orderIsSignificant: Bool) {
      var finished = partialElements.removeLast()

      if ¬orderIsSignificant {
        sortChildren(of: &finished)
      }

      let last = partialElements.indices.last!
      partialElements[last].content.append(.element(finished))
      codingPath.removeLast()
    }

    // MARK: - Stabilization

    private func sortChildren(of element: inout XML.Element) {
      element.content.sort(by: { first, second in
        guard case .element(let firstElement) = first,
          case .element(let secondElement) = second
        else {
          unreachable()  // Keyed containers do not encode character data.
        }
        return firstElement.name < secondElement.name
      })
    }

    // MARK: - Encoder

    internal var codingPath: [CodingKey]
    internal var userInfo: [CodingUserInfoKey: Any]

    internal func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key>
    where Key: CodingKey {
      return KeyedEncodingContainer(KeyedContainer(encoder: self))
    }

    internal func unkeyedContainer() -> UnkeyedEncodingContainer {
      return UnkeyedContainer(encoder: self)
    }

    internal func singleValueContainer() -> SingleValueEncodingContainer {
      return SingleValueContainer(encoder: self)
    }
  }
}
