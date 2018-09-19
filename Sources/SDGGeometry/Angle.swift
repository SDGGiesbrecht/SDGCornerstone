/*
 Angle.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow

extension Angle : CustomPlaygroundDisplayConvertible {

    // MARK: - CustomPlaygroundDisplayConvertible

    // #documentation(SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription)
    /// Returns the custom playground description for this instance.
    @inlinable public var playgroundDescription: Any {
        #if canImport(CoreGraphics) && (canImport(AppKit) || canImport(UIKit))

        let floatAngle: Angle<CGFloat> = CGFloat(self.inRadians.floatingPointApproximation).radians

        let arrow: BézierPath = BézierPath()
        let centre: CGPoint = CGPoint(x: 0, y: 0)
        arrow.move(to: centre)
        let radius: CGFloat = 50
        let start: CGPoint = CGPoint(x: radius, y: 0)
        arrow.line(to: start)
        arrow.appendArc(withCentre: centre, radius: radius, startAngle: 0, endAngle: floatAngle.inDegrees, clockwise: floatAngle.isNegative)
        let end: CGPoint = centre + CGVector(direction: floatAngle, length: radius)

        let flip: Angle<CGFloat>
        if floatAngle.isNegative {
            flip = CGFloat.π.rad
        } else {
            flip = (0 as CGFloat).rad
        }
        let arrowHeadLength: CGFloat = 10
        let leftDirection: Angle<CGFloat> = ((5 as CGFloat × π()) ÷ 4).radians
        let adjustedLeftDirection: Angle<CGFloat> = leftDirection + floatAngle + flip
        let leftSide: CGPoint = end + CGVector(direction: adjustedLeftDirection, length: arrowHeadLength)
        arrow.line(to: leftSide)
        arrow.line(to: end)

        let rightDirection: Angle<CGFloat> = ((−1 as CGFloat × π()) ÷ 4).radians
        let adjustedRightDirection: Angle<CGFloat> = rightDirection + floatAngle + flip
        let rightSide: CGPoint = end + CGVector(direction: adjustedRightDirection, length: arrowHeadLength)
        arrow.line(to: rightSide)
        arrow.line(to: end)

        return arrow
        #else
        return String(describing: self)
        #endif
    }
}
