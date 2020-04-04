/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, Web doesn’t have foundation yet.)
#if !os(WASI)
  import Foundation
  #if canImport(CoreGraphics)
    import CoreGraphics  // Not included in Foundation on iOS.
  #endif
#endif

extension Double: TextConvertibleNumber {}
// #workaround(workspace version 0.32.0, Web doesn’t have foundation yet.)
#if !os(WASI)
  extension CGFloat: TextConvertibleNumber {}
#endif
#if !(os(Windows) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  // #workaround(Swift 5.1.5, Compiler doesn’t recognize os(WASI).)
  #if !os(WASI)
    extension Float80: TextConvertibleNumber {}
  #endif
#endif
extension Float: TextConvertibleNumber {}
