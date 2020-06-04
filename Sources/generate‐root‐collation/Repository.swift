/*
 Repository.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation

  let repositoryRoot = URL(fileURLWithPath: #file).deletingLastPathComponent()
    .deletingLastPathComponent().deletingLastPathComponent()

  let resourcesDirectory = repositoryRoot.appendingPathComponent("Resources")
  let collationResourcesDirectory = resourcesDirectory.appendingPathComponent("SDGCollation")
#endif
