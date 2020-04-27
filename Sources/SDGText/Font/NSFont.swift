/*
 NSFont.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  extension NSFont {

    /// Creates an `NSFont` from a `Font`.
    ///
    /// - Parameters:
    ///   - font: The font.
    public static func from(_ font: Font) -> NSFont? {
      switch font.definition {
      case .identifier(let name, let size):
        return NSFont(name: name, size: CGFloat(size))
      case .cocoa(let font):
        return font
      }
    }
  }
#endif
