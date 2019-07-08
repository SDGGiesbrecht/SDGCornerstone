/*
 Angle.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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
import SDGMathematics

extension Angle : CustomPlaygroundDisplayConvertible {

    // MARK: - CustomPlaygroundDisplayConvertible

    public var playgroundDescription: Any {
        #if canImport(CoreGraphics) && (canImport(AppKit) || canImport(UIKit))

        let floatAngle: Angle<Double> = Double(self.inRadians.floatingPointApproximation).radians

        var arrow = BézierPath()
        let centre = TwoDimensionalPoint<Double>(0, 0)
        arrow.move(to: centre)
        let radius: Double = 50
        let start = TwoDimensionalPoint<Double>(radius, 0)
        arrow.appendLine(to: start)
        arrow.appendArc(
            centre: centre,
            radius: radius,
            startAngle: 0.radians,
            endAngle: floatAngle,
            clockwise: floatAngle.isNegative)
        let end = centre + TwoDimensionalVector(direction: floatAngle, length: radius)

        let flip: Angle<Double>
        if floatAngle.isNegative {
            flip = Double.π.rad
        } else {
            flip = (0 as Double).rad
        }
        let arrowHeadLength: Double = 10
        let leftDirection = ((5 as Double × π()) ÷ 4).radians
        let adjustedLeftDirection = leftDirection + floatAngle + flip
        let leftSide = end + TwoDimensionalVector(direction: adjustedLeftDirection, length: arrowHeadLength)
        arrow.appendLine(to: leftSide)
        arrow.appendLine(to: end)

        let rightDirection = ((−1 as Double × π()) ÷ 4).radians
        let adjustedRightDirection = rightDirection + floatAngle + flip
        let rightSide = end + TwoDimensionalVector(direction: adjustedRightDirection, length: arrowHeadLength)
        arrow.appendLine(to: rightSide)
        arrow.appendLine(to: end)

        return arrow
        #else
        return String(describing: self)
        #endif
    }
}
