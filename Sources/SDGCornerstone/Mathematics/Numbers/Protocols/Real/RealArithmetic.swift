/*
 RealArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogicCore
import SDGMathematicsCore

/// A type that can be used for real arithmetic.
///
/// Conformance Requirements:
///
/// - `RationalArithmetic`
/// - `static var π: Self { get }`
/// - `static var e: Self { get }`
/// - `mutating func formLogarithm(toBase base: Self)`
/// - `static func sin(_ angle: Angle<Self>) -> Self`
/// - `static func arctan(_ tangent: Self) -> Angle<Self>`
public protocol RealArithmetic : RealArithmeticCore, RationalArithmetic {

}
