/*
 BézierPath.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || canImport(UIKit)
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGMathematics

/// A Bézier path.
public struct BézierPath {

    // MARK: - Initialization

    #if canImport(AppKit)
    // @documentation(BézierPath.init(native:))
    /// Creates a Bézier path with a native Bézier path.
    public init(_ native: NSBezierPath) {
        self.native = native
    }
    #elseif canImport(UIKit)
    // #documentation(BézierPath.init(native:))
    /// The native font.
    public init(_ native: UIBezierPath) {
        self.native = native
    }
    #endif

    // MARK: - Properties

    #if canImport(AppKit)
    // @documentation(BézierPath.native)
    /// The native Bézier path.
    public var native: NSBezierPath
    #elseif canImport(UIKit)
    // #documentation(BézierPath.native)
    /// The native font.
    public var native: UIBezierPath
    #endif

    // MARK: - Drawing

    /// Appends a straight line to the path.
    ///
    /// - Parameters:
    ///     - point: The target point.
    public mutating func appendLine(to point: TwoDimensionalPoint<Double>) {
        #if canImport(AppKit)
        native.line(to: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y)))
        #elseif canImport(UIKit)
        native.addLine(to: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y)))
        #endif
    }

    /// Appends an arc of a circle to the path.
    ///
    /// - Parameters:
    ///     - centre: The centre point of the circle used to define the arc.
    ///     - radius: The radius of the arc.
    ///     - startAngle: The starting angle of the arc, measured counterclockwise from the x‐axis.
    ///     - endAngle: The end angle of the arc, measured counterclockwise from the x‐axis.
    ///     - clockwise: Whether or not the arc should be drawn in the clockwise direction.
    public func appendArc(
        centre: TwoDimensionalPoint<Double>,
        radius: Double,
        startAngle: Angle<Double>,
        endAngle: Angle<Double>,
        clockwise: Bool) {
        #if canImport(AppKit)
        return native.appendArc(
            withCenter: CGPoint(x: CGFloat(centre.x), y: CGFloat(centre.y)),
            radius: CGFloat(radius),
            startAngle: CGFloat(startAngle.inDegrees),
            endAngle: CGFloat(endAngle.inDegrees),
            clockwise: clockwise)
        #elseif canImport(UIKit)
        return native.addArc(
            withCenter: CGPoint(x: CGFloat(centre.x), y: CGFloat(centre.y)),
            radius: CGFloat(radius),
            startAngle: CGFloat(startAngle.inDegrees),
            endAngle: CGFloat(endAngle.inDegrees),
            clockwise: clockwise)
        #endif
    }
}
#endif
