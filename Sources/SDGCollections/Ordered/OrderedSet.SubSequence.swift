/*
 OrderedSet.SubSequence.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_CANNOT_FETCH_SWIFT_COLLECTIONS
  import OrderedCollections
#endif

#if !PLATFORM_CANNOT_FETCH_SWIFT_COLLECTIONS
  extension OrderedCollections.OrderedSet.SubSequence: SearchableBidirectionalCollection {}
#endif
