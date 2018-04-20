/*
 Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
// MARK: - #if canImport(AppKit)
// `NSFont` or `UIFont`.
public typealias Font = NSFont
#elseif canImport(UIKit)
// MARK: - #if canImport(UIKit)
// `NSFont` or `UIFont`.
public typealias Font = UIFont
#endif

#if canImport(AppKit) || canImport(UIKit)
// MARK: - #if canImport(AppKit) || canImport(UIKit)

extension Font {

    /// Returns the size of the standard system font.
    public class var systemSize: CGFloat {
        #if os(tvOS)
            return 29 // From https://developer.apple.com/tvos/human-interface-guidelines/visual-design/typography.
        #else
            return systemFontSize
        #endif
    }
}
#endif
