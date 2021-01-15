/*
 XMLNode.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

internal struct XMLNode {

  // MARK: - Initialization

  internal init(characterData: StrictString? = nil) {
    self.characterData = characterData
  }

  private var characterData: StrictString?
  internal var children: [(StrictString, XMLNode)] = []

  // MARK: - Source

  internal func source() -> StrictString {
    var result: StrictString = ""
    if let characterData = self.characterData {
      #warning("Probably needs escaping.")
      result.append(contentsOf: characterData)
    }
    for child in children {
      let name = child.0
      let contents = child.1
      result.append(contentsOf: "<\(name)>\(contents.source())</\(name)")
    }
    return result
  }
}
