/*
 XML.Coder.MiscellaneousKey.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML.Coder {

  internal struct MiscellaneousKey: CodingKey {

    // MARK: - Static Properties

    internal static var `super`: MiscellaneousKey {
      return MiscellaneousKey("super")
    }

    // MARK: - Initialization

    internal init(_ string: String) {
      self.stringValue = string
    }

    internal init(_ index: Int) {
      self.intValue = index
      self.stringValue = String(index.inDigits())
    }

    internal init<T>(defaultFor value: T) {
      if let specified = (value as? CustomXMLRepresentable)?.defaultElementName {
        self.init(String(specified))
      } else {
        self.init(String(StrictString("\(arbitraryDescriptionOf: T.self)")))
      }
    }

    // MARK: - Coding Key

    internal init?(intValue: Int) {  // @exempt(from: tests) Unreachable?
      self.init(intValue)
    }

    internal init?(stringValue: String) {  // @exempt(from: tests) Unreachable?
      self.init(stringValue)
    }

    internal var intValue: Int?
    internal var stringValue: String
  }
}
