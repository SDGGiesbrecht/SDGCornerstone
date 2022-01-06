/*
 StrictString.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText

extension StrictString: FileConvertible {

  // MARK: - FileConvertible

  public init(file: Data, origin: URL?) throws {
    self.init(try String(file: file, origin: origin))
  }

  public var file: Data {
    return String(self).file
  }
}
