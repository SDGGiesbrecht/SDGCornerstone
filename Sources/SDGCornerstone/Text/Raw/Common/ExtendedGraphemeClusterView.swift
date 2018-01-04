/*
 ExtendedGraphemeClusterView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A view of a string’s contents as a collection of extended grapheme clusters.
public protocol ExtendedGraphemeClusterView : BidirectionalCollection, RangeReplaceableCollection
where Element == ExtendedGraphemeCluster/*, Index == String.Index*/ {
    // [_Workaround: The above line triggers an abort trap. (Swift 4.0.3)_]

}
