/*
 XML.Element.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

extension XML {

  /// An XML element.
  public struct Element {

    // MARK: - Initailization

    /// Creates an element with a particular name.
    ///
    /// - Parameters:
    ///   - name: The name.
    public init(name: StrictString) {
      self.name = name
    }

    /// Creates an element with a particular name that is already in escaped form.
    ///
    /// - Parameters:
    ///   - escapedName: The name in escaped form.
    public init(escapedName: StrictString) {
      self.name = Element.unescape(escapedName)
    }

    // MARK: - Properties

    /// The name of the element.
    public var name: StrictString

    /// The name of the element with character escapes applied.
    public var escapedName: StrictString {
      get {
        return Element.escape(name)
      }
      set {
        name = Element.unescape(newValue)
      }
    }
    private static func escape(_ name: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return name
    }
    private static func unescape(_ name: StrictString) -> StrictString {
      #warning("Not implemented yet.")
      return name
    }

    // MARK: - Source

    /// The source of the element.
    public func source() -> StrictString {
      return "<\(escapedName)></\(escapedName)>"
    }
  }
}
