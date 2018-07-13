/*
 BézierPath.swift

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
/// An alias for `NSBezierPath` or `UIBezierPath`.
public typealias BézierPath = NSBezierPath
#elseif canImport(UIKit)
// MARK: - #if canImport(UIKit)
/// An alias for `NSBezierPath` or `UIBezierPath`.
public typealias BézierPath = UIBezierPath
#endif

#if canImport(AppKit) || canImport(UIKit)
// MARK: - #if canImport(AppKit) || canImport(UIKit)
extension BézierPath {

    #if canImport(UIKit)
    // MARK: - #if canImport(UIKit)
    /// Appends a straight line to the receiver’s path.
    @_inlineable public func line(to point: CGPoint) {
        addLine(to: point)
    }
    #endif

    /// Appends an arc of a circle to the receiver’s path.
    @_inlineable public func appendArc(withCentre centre: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        #if canImport(AppKit)
        return appendArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        #elseif canImport(UIKit)
        return addArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        #endif
    }
}
#endif
