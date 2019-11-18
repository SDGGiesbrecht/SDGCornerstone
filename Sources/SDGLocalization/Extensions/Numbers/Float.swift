/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

extension Double: TextConvertibleNumber {}
#if canImport(CoreGraphics)
  extension CGFloat: TextConvertibleNumber {}
#endif
#if !(os(iOS) || os(watchOS) || os(tvOS))
  extension Float80: TextConvertibleNumber {}
#endif
extension Float: TextConvertibleNumber {}
