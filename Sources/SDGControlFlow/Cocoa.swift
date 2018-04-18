/*
 Cocoa.swift

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
// `NSBezierPath` or `UIBezierPath`.
public typealias BézierPath = NSBezierPath
#elseif canImport(UIKit)
// `NSBezierPath` or `UIBezierPath`.
public typealias BézierPath = UIBezierPath
#endif

#if canImport(AppKit)
// `NSFont` or `UIFont`.
public typealias Font = NSFont
#elseif canImport(UIKit)
// `NSFont` or `UIFont`.
public typealias Font = UIFont
#endif
