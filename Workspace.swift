/*
 Workspace.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(10, 1, 3)

configuration.documentation.projectWebsite = URL(
  string: "https://sdggiesbrecht.github.io/SDGCornerstone"
)!
configuration.documentation.documentationURL = URL(
  string: "https://sdggiesbrecht.github.io/SDGCornerstone"
)!
configuration.documentation.api.yearFirstPublished = 2017
configuration.documentation.repositoryURL = URL(
  string: "https://github.com/SDGGiesbrecht/SDGCornerstone"
)!

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.continuousIntegration.skipSimulatorOutsideContinuousIntegration = true

configuration._applySDGOverrides()
configuration._validateSDGStandards()

// #workaround(Swift 5.8.0, Must use Workspace until all platforms support plugins.)
configuration.git.additionalGitIgnoreEntries.append(
  contentsOf: [
    "Tests/SDGEmbedResourcesTests/Resources",
    "Tests/SDGEmbedResourcesTests/Resources.swift",
  ]
)
