/*
 UnicodeScalarView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A view of a string’s contents as a collection of Unicode scalar values.
public protocol UnicodeScalarView : BidirectionalCollection, RangeReplaceableCollection {

    // [_Workaround: Iterator.Element should be constrained to UnicodeScalar, but this is not yet possible. (Swift 3.1.0)_]
}
