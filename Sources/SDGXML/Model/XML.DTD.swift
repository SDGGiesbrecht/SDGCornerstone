/*
 XML.DTD.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML {

  /// An XML DTD.
  public enum DTD: Equatable, Sendable {

    // MARK: - Cases

    /// A system DTD.
    case system(StrictString)

    // MARK: - Source

    /// The source of the DTD.
    ///
    /// - Parameters:
    ///   - element: The name of the root element.
    public func source(element: StrictString) -> StrictString {
      switch self {
      case .system(let identifier):
        return "<!DOCTYPE \(element) SYSTEM \u{22}\(identifier)\u{22}>"
      }
    }
  }
}
