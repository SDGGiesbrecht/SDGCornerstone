/*
 Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

/// A font.
public struct Font: Sendable {

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
    #elseif os(Windows)
      return Font(fontName: "Segoe UI", size: 9)
    #elseif os(WASI)
      return Font(fontName: "system\u{2D}ui", size: 16)
    #elseif os(Linux)
      return Font(fontName: "Ubuntu", size: 11)
    #elseif os(Android)
      return Font(fontName: "Roboto", size: 18)
    #endif
  }

  // MARK: - Initialization

  private init(definition: Font.Definition) {
    self.definition = definition
  }

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
    ///   - cocoa: The Cocoa font.
    public init(_ cocoa: NSFont) {
      self.definition = .cocoa(cocoa)
    }
  #elseif canImport(UIKit)
    // #documentation(Font.init(cocoa:))
    /// Creates a font by wrapping a Cocoa font.
    ///
    /// - Parameters:
    ///   - cocoa: The Cocoa font.
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
      #if PLATFORM_HAS_COCOA
        case .cocoa(let font):
          return font.fontName
      #endif
      }
    }
    set {
      switch definition {
      case .identifier(_, let size):
        definition = .identifier(name: newValue, size: size)
      #if PLATFORM_HAS_COCOA
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
      #if PLATFORM_HAS_COCOA
        case .cocoa(let font):
          return Double(font.pointSize)
      #endif
      }
    }
    set {
      self = resized(to: newValue)
    }
  }

  // MARK: - Variations

  /// The same font in a different size.
  ///
  /// - Parameters:
  ///   - size: The new point size.
  public func resized(to size: Double) -> Font {
    switch definition {
    case .identifier(let name, _):
      return Font(definition: .identifier(name: name, size: size))
    #if PLATFORM_HAS_COCOA
      case .cocoa(let font):
        #if canImport(AppKit)
          return Font(definition: .cocoa(NSFontManager.shared.convert(font, toSize: CGFloat(size))))
        #elseif canImport(UIKit)
          return Font(definition: .cocoa(font.withSize(CGFloat(size))))
        #endif
    #endif
    }
  }
}
