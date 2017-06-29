/*
 FixedScaleOneDimensionalPoint.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A one dimensional point with a fixed scale.
public protocol FixedScaleOneDimensionalPoint : OneDimensionalPoint, Strideable {

    // [_Workaround: When it is possible to add the restriction Vector == Stride, Vector should no longer need to be specified by each conforming type. (Swift 3.1.0)_]
}
