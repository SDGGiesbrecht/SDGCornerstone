/*
 main.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.6, Directory should be “generate‐root‐collation”, but for Windows bug.)

import SDGCollation

#if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
  let root = try CollationOrder.generateRoot()
  try root.save(to: collationResourcesDirectory.appendingPathComponent("Root"))
#endif
