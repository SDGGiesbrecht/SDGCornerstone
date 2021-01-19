/*
 XML.Encoder.MiscellaneousKey.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension XML.Encoder {

  internal struct MiscellaneousKey: CodingKey {

    // MARK: - Initialization

    internal init(_ string: String) {
      self.stringValue = string
    }

    internal init(_ index: Int) {
      self.intValue = index
      self.stringValue = String(index.inDigits())
    }

    // MARK: - Coding Key

    internal init?(intValue: Int) {
      self.init(intValue)
    }

    internal init?(stringValue: String) {
      self.stringValue = stringValue
    }

    internal var intValue: Int?
    internal var stringValue: String
  }
}
