/*
 CGPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

#if !os(Linux)
    // MARK: - #if !os(Linux)

    import CoreGraphics

    struct CGPoint : TwoDimensionalPoint {
        // [_Workaround: Temporary stand‐in for the real CGPoint. See CGPoint.swift. (Swift 4.0.3)_]

        typealias Vector = CGVector

        var x: CGFloat
        var y: CGFloat

        static func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
            return (lhs.x, lhs.y) == (rhs.x, rhs.y)
        }
    }
#endif
