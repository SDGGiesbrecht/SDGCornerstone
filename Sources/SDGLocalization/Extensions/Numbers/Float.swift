/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(CoreGraphics)
  import CoreGraphics  // Not included in Foundation on iOS.
#endif

extension Double: TextConvertibleNumber {}
extension CGFloat: TextConvertibleNumber {}
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  extension Float80: TextConvertibleNumber {}
#endif
extension Float: TextConvertibleNumber {}
// #workaround(Swift 5.3, macOS has no Float16 yet.)
#if !os(macOS)
  @available(tvOS 14, iOS 14, watchOS 7, *)
  extension Float16: TextConvertibleNumber {}
#endif
