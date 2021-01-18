/*
 XML.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections
import SDGText

/// A namespace for types related to XML.
public enum XML {

  // From https://www.w3.org/TR/xml11/#IDAKUDS
  private static let legalStarters: CharacterSet = {
    var starters: CharacterSet = []
    starters.insert(":")
    starters ∪= CharacterSet(charactersIn: "A"..<"Z")
    starters.insert("_")
    starters ∪= CharacterSet(charactersIn: "a"..<"z")
    starters ∪= CharacterSet(charactersIn: "\u{C0}"..<"\u{D6}")
    starters ∪= CharacterSet(charactersIn: "\u{D8}"..<"\u{F6}")
    starters ∪= CharacterSet(charactersIn: "\u{F8}"..<"\u{2FF}")
    starters ∪= CharacterSet(charactersIn: "\u{370}"..<"\u{37D}")
    starters ∪= CharacterSet(charactersIn: "\u{37F}"..<"\u{1FFF}")
    starters ∪= CharacterSet(charactersIn: "\u{200C}"..<"\u{200D}")
    starters ∪= CharacterSet(charactersIn: "\u{2070}"..<"\u{218F}")
    starters ∪= CharacterSet(charactersIn: "\u{2C00}"..<"\u{2FEF}")
    starters ∪= CharacterSet(charactersIn: "\u{3001}"..<"\u{D7FF}")
    starters ∪= CharacterSet(charactersIn: "\u{F900}"..<"\u{FDCF}")
    starters ∪= CharacterSet(charactersIn: "\u{FDF0}"..<"\u{FFFD}")
    starters ∪= CharacterSet(charactersIn: "\u{10000}"..<"\u{EFFFF}")
    return starters
  }()
  private static let legalCharacters: CharacterSet = {
    var characters: CharacterSet = legalStarters
    characters.insert("\u{2D}")
    characters.insert(".")
    characters ∪= CharacterSet(charactersIn: "0"..<"9")
    characters.insert("\u{B7}")
    characters ∪= CharacterSet(charactersIn: "\u{300}"..<"\u{36F}")
    characters ∪= CharacterSet(charactersIn: "\u{203F}"..<"\u{2040}")
    return characters
  }()

  /// Sanitizes an arbitrary string so it can be safely used as an XML name.
  ///
  /// - Parameters:
  ///   - name: The name.
  public static func sanitize(name: StrictString) -> StrictString {
    var percentEncoded = String(name).addingPercentEncoding(
      withAllowedCharacters: legalCharacters.subtracting(["_"])
    )!
    if let first = percentEncoded.scalars.first,
      first ∉ legalStarters
    {
      percentEncoded.scalars.removeFirst()
      let sanitized = String(first).addingPercentEncoding(withAllowedCharacters: legalStarters)!
      percentEncoded.scalars.prepend(contentsOf: sanitized.scalars)
    }
    percentEncoded.scalars.replaceMatches(for: "%".scalars, with: "_".scalars)
    return StrictString(percentEncoded)
  }
}
