/*
 Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

/// A font.
public struct Font {

  // MARK: - Static Properties

  /// Returns the standard system font.
  public static var system: Font {
    #if canImport(AppKit)
      return Font(NSFont.systemFont(ofSize: NSFont.systemFontSize))
    #elseif canImport(UIKit)
      let size: CGFloat
      #if os(watchOS)
        // From https://developer.apple.com/watchos/human-interface-guidelines/visual-design/typography/.
        size = 16
      #elseif os(tvOS)
        // From https://developer.apple.com/tvos/human-interface-guidelines/visual-design/typography.
        size = 29
      #else
        size = UIFont.systemFontSize
      #endif
      return Font(UIFont.systemFont(ofSize: size))
    #endif
  }

  // MARK: - Initialization

  /// Creates a font with a name and size.
  ///
  /// - Parameters:
  ///   - fontName: The machine identifier of the font.
  ///   - size: The size.
  public init(fontName: String, size: Double) {
    definition = .identifier(name: fontName, size: size)
  }

  #if canImport(AppKit)
    // @documentation(Font.init(cocoa:))
    /// Creates a font by wrapping a Cocoa font.
    ///
    /// - Parameters:
    ///     - cocoa: The Cocoa font.
    public init(_ cocoa: NSFont) {
      self.definition = .cocoa(cocoa)
    }
  #elseif canImport(UIKit)
    // #documentation(Font.init(cocoa:))
    /// Creates a font by wrapping a Cocoa font.
    ///
    /// - Parameters:
    ///     - cocoa: The Cocoa font.
    public init(_ cocoa: UIFont) {
      self.definition = .cocoa(cocoa)
    }
  #endif

  // MARK: - Properties

  internal var definition: Definition

  /// The name of the font.
  ///
  /// This is a machine identifier; it is not for display.
  public var fontName: String {
    get {
      switch definition {
      case .identifier(let name, _):
        return name
      #if canImport(AppKit) || canImport(UIKit)
        case .cocoa(let font):
          return font.fontName
      #endif
      }
    }
    set {
      switch definition {
      case .identifier(_, let size):
        definition = .identifier(name: newValue, size: size)
      #if canImport(AppKit) || canImport(UIKit)
        case .cocoa(let font):
          definition = .identifier(name: newValue, size: Double(font.pointSize))
      #endif
      }
    }
  }

  /// The point size of the font.
  public var size: Double {
    get {
      switch definition {
      case .identifier(_, let size):
        return size
      #if canImport(AppKit) || canImport(UIKit)
        case .cocoa(let font):
          return Double(font.pointSize)
      #endif
      }
    }
    set {
      switch definition {
      case .identifier(let name, _):
        definition = .identifier(name: name, size: newValue)
      #if canImport(AppKit) || canImport(UIKit)
        case .cocoa(let font):
          #if canImport(AppKit)
            definition = .cocoa(NSFontManager.shared.convert(font, toSize: CGFloat(newValue)))
          #elseif canImport(UIKit)
            definition = .cocoa(font.withSize(CGFloat(newValue)))
          #endif
      #endif
      }
    }
  }

  // MARK: - Variations

  /// The same font in a different size.
  ///
  /// - Parameters:
  ///     - size: The new point size.
  public func resized(to size: Double) -> Font {
    var result = self
    result.size = size
    return result
  }
}
