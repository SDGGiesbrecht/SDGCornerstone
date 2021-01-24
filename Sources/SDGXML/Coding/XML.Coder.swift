/*
 XML.Coder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML {

  internal enum Coder {

    internal static func description(of codingPath: [CodingKey]) -> StrictString {
      let string = String(codingPath.lazy.map({ $0.stringValue }).joined(separator: " → "))
      return StrictString(string)
    }
  }
}
