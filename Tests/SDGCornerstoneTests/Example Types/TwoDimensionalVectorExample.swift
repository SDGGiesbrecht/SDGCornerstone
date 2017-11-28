/*
 TwoDimensionalVectorExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

#if !os(Linux)
    import CoreGraphics

    struct TwoDimensionalVectorExample : TwoDimensionalVector {

        var vector: CGVector

        // AdditiveArithmetic

        static let additiveIdentity = TwoDimensionalVectorExample(vector: CGVector(Δx : 0, Δy : 0))

        // Equatable

        static func == (lhs: TwoDimensionalVectorExample, rhs: TwoDimensionalVectorExample) -> Bool {
            return lhs.vector == rhs.vector
        }

        // VectorProtocol

        typealias Scalar = CGVector.Scalar

        // TwoDimensionalVector

        var Δx : CGFloat {
            get {
                return vector.Δx
            }
            set {
                vector.Δx = newValue
            }
        }

        var Δy : CGFloat {
            get {
                return vector.Δy
            }
            set {
                vector.Δy = newValue
            }
        }
    }
#endif
