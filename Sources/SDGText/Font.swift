/*
 Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
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

    #if canImport(SwiftUI)
      // @documentation(Font.init(swiftUI:))
      /// Creates a font by wrapping a SwiftUI font.
      ///
      /// - Parameters:
      ///     - swiftUI: The SwiftUI font.
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public init(_ swiftUI: SwiftUI.Font) {
        self.definition = .swiftUI(swiftUI)
      }
    #endif

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
        return native.fontName
      }
      set {
        #if canImport(AppKit)
          if let succeeded = NSFont(name: newValue, size: native.pointSize) {
            native = succeeded
          }
        #elseif canImport(UIKit)
          if let succeeded = UIFont(name: newValue, size: native.pointSize) {
            native = succeeded
          }
        #endif
      }
    }

    /// The point size of the font.
    public var size: Double {
      get {
        return Double(native.pointSize)
      }
      set {
        #if canImport(AppKit)
          native = NSFontManager.shared.convert(native, toSize: CGFloat(newValue))
        #elseif canImport(UIKit)
          native = native.withSize(CGFloat(newValue))
        #endif
      }
    }

    #warning("Can these be converted to initializers on the respective type?")
    #if canImport(SwiftUI)
      // @documentation(Font.swiftUI())
      /// The SwiftUI font.
      public func swiftUI() -> SwiftUI.Font {
      }
    #endif
    #if canImport(AppKit)
      // @documentation(Font.cocoa())
      /// The Cocoa font.
      public func cocoa() -> NSFont {
      }
    #elseif canImport(UIKit)
      // #documentation(Font.cocoa())
      /// The Cocoa font.
      public func cocoa() -> UIFont {
      }
    #endif

    // MARK: - Variations

    /// The same font in a different size.
    ///
    /// - Parameters:
    ///     - size: The new point size.
    public func resized(to size: Double) -> Font {
      #if canImport(AppKit)
        return Font(NSFontManager.shared.convert(native, toSize: CGFloat(size)))
      #else
        return Font(UIFont(descriptor: native.fontDescriptor, size: CGFloat(size)))
      #endif
    }
  }
#endif
