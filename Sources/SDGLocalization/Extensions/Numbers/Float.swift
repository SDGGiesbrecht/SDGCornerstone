/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
#if !((os(macOS) && arch(arm64)) || os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  extension Float80: TextConvertibleNumber {}
#endif
extension Float: TextConvertibleNumber {}
#if !PLATFORM_LACKS_SWIFT_FLOAT_16
  @available(tvOS 14, iOS 14, watchOS 7, *)
  extension Float16: TextConvertibleNumber {}
#endif
