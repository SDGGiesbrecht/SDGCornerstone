/*
 ExtendedGraphemeClusterView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A view of a string’s contents as a collection of extended grapheme clusters.
public protocol ExtendedGraphemeClusterView: RangeReplaceableCollection,
  SearchableBidirectionalCollection, Sendable
where Element == ExtendedGraphemeCluster, Index == String.Index {}
