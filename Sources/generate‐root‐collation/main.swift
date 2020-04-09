/*
 main.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollation

// #workaround(Swift 5.2.1, Web doesn’t have Foundation yet.)
#if !os(WASI)
  let root = try CollationOrder.generateRoot()
  try root.save(to: collationResourcesDirectory.appendingPathComponent("Root"))
#endif
