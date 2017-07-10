/*
 CGVector.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(Linux)
    import CoreGraphics

    extension CGVector : AdditiveArithmetic, TwoDimensionalVector {

        // MARK: - AdditiveArithmetic

        // [_Inherit Documentation: SDGCornerstone.AdditiveArithmetic.additiveIdentity_]
        /// The additive identity (origin).
        public static let additiveIdentity = zero

        // MARK: - TwoDimensionalVector

        // [_Inherit Documentation: SDGCornerstone.TwoDimensionalVector.init(Δx:Δy:)_]
        /// The difference in *y*.
        public init(Δx : CGFloat, Δy : CGFloat) {
            self = CGVector(dx: Δx, dy: Δy)
        }

        // [_Inherit Documentation: SDGCornerstone.TwoDimensionalVector.Δx_]
        /// The difference in *x*.
        public var Δx : CGFloat {
            get {
                return dx
            }
            set {
                dx = newValue
            }
        }

        // [_Inherit Documentation: SDGCornerstone.TwoDimensionalVector.Δy_]
        /// The difference in *y*.
        public var Δy : CGFloat {
            get {
                return dy
            }
            set {
                dy = newValue
            }
        }
    }

#endif
