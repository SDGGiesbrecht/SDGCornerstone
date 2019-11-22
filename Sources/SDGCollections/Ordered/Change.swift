/*
 Change.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Rethink")

@usableFromInline internal enum IndividualChange<Index, OtherIndex> {
  case keep(Index)
  case remove(Index)
  case insert(OtherIndex)
}

/// A single change in a sequence of modifications which transform one collection into another.
public enum Change<Index: Comparable, OtherIndex: Comparable> {

  /// No change to a range in the original collection.
  case keep(Range<Index>)
  /// A removal of a range from the original collection.
  case remove(Range<Index>)
  /// An insertion of elements from a range of the new collection.
  case insert(Range<OtherIndex>)
}
