/*
 Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
// @documentation(SDGCornerstone.Font)
/// An alias for `NSFont` or `UIFont`.
public typealias Font = NSFont
#elseif canImport(UIKit)
// #documentation(SDGCornerstone.Font)
/// An alias for `NSFont` or `UIFont`.
public typealias Font = UIFont
#endif

#if canImport(AppKit) || canImport(UIKit)

extension Font {

    /// Returns the size of the standard system font.
    public static var systemSize: CGFloat {
        #if os(watchOS)
            return 16 // From https://developer.apple.com/watchos/human-interface-guidelines/visual-design/typography/.
        #elseif os(tvOS)
            return 29 // From https://developer.apple.com/tvos/human-interface-guidelines/visual-design/typography.
        #else
            return systemFontSize
        #endif
    }
}
#endif
