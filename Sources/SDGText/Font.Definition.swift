/*
 Font.Definition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

  extension Font {

    internal enum Definition {

      #if canImport(SwiftUI)
        @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
        case swiftUI(SwiftUI.Font)
      #endif

      #if canImport(AppKit)
        case cocoa(NSFont)
      #elseif canImport(UIKit)
        case cocoa(UIFont)
      #endif
    }
  }
#endif
