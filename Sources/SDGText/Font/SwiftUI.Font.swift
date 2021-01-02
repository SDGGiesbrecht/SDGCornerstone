/*
 SwiftUI.Font.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUI.Font {

    /// Creates a `SwiftUI.Font` from a `Font`.
    ///
    /// - Parameters:
    ///   - font: The font.
    public init(_ font: Font) {
      switch font.definition {
      case .identifier(let name, let size):
        self = SwiftUI.Font.custom(name, size: CGFloat(size))
      #if canImport(AppKit) || canImport(UIKit)
        case .cocoa(let font):
          self = SwiftUI.Font(font)
      #endif
      }
    }
  }
#endif
