/*
 Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
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
        size = 16 // From https://developer.apple.com/watchos/human-interface-guidelines/visual-design/typography/.
        #elseif os(tvOS)
        size = 29 // From https://developer.apple.com/tvos/human-interface-guidelines/visual-design/typography.
        #else
        size = UIFont.systemFontSize
        #endif
        return Font(UIFont.systemFont(ofSize: size))
        #endif
    }

    // MARK: - Initialization

    #if canImport(AppKit)
    // @documentation(Font.init(native:))
    /// Creates a font with a native font.
    public init(_ native: NSFont) {
        self.native = native
    }
    #elseif canImport(UIKit)
    // #documentation(Font.init(native:))
    /// The native font.
    public init(_ native: UIFont) {
        self.native = native
    }
    #endif

    // MARK: - Properties

    /// The name of the font. (This is a machine identifier; it is not for display.)
    public var fontName: String {
        get {
            return native.fontName
        }
        set {
            native = NSFont(name: newValue, size: native.pointSize) ?? Font.system.native
        }
    }

    /// The point size of the font.
    public var size: Double {
        get {
            return Double(native.pointSize)
        }
        set {
            native = NSFontManager.shared.convert(native, toSize: CGFloat(newValue))
        }
    }

    #if canImport(AppKit)
    // @documentation(Font.native)
    /// The native font.
    public var native: NSFont
    #elseif canImport(UIKit)
    // #documentation(Font.native)
    /// The native font.
    public var native: UIFont
    #endif
}
#endif
