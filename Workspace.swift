/*
 Workspace.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(0, 15, 0)

configuration.documentation.projectWebsite = URL(string: "https://sdggiesbrecht.github.io/SDGCornerstone")!
configuration.documentation.documentationURL = URL(string: "https://sdggiesbrecht.github.io/SDGCornerstone")!
configuration.documentation.api.yearFirstPublished = 2017
configuration.documentation.repositoryURL = URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.documentation.readMe.shortProjectDescription["🇨🇦EN"] = "SDGCornerstone forms the foundation of the SDG module family. It establishes design patterns and provides general‐use extensions to the [Swift Standard Library](https://developer.apple.com/reference/swift) and [Foundation](https://developer.apple.com/reference/foundation)."

configuration.documentation.readMe.quotation = Quotation(original: "הִנְנִי יִסַּד בְּצִיּוֹן אָבֶן אֶבֶן בֹּחַן פִּנַּת יִקְרַת מוּסָד מוּסָד׃")
configuration.documentation.readMe.quotation?.translation["🇨🇦EN"] = "Behold, I establish in Zion a stone, a tested stone, a precious cornerstone, a sure foundation."
configuration.documentation.readMe.quotation?.link["🇨🇦EN"] = URL(string: "https://www.biblegateway.com/passage/?search=Isaiah+28&version=WLC;NIV")!
configuration.documentation.readMe.quotation?.citation["🇨🇦EN"] = "⁧יהוה⁩/Yehova"

configuration.documentation.readMe.featureList["🇨🇦EN"] = [
    "\u{2D} Localization tools (compatible with the Swift Package Manager and Linux).",
    "\u{2D} User preferences access (compatible with Linux).",
    "\u{2D} Platform‐independent access to best‐practice file system locations.",
    "\u{2D} Shared instances of value types.",
    "\u{2D} Generic pattern matching.",
    "\u{2D} Arbitrary‐precision arithmetic.",
    "\u{2D} Simple API for running shell commands (desktop platforms only).",
    "",
    "...and much more.",
    "",
    "Use the entire package together by importing the `SDGCornerstone` product, or pick and choose pieces by importing the various component products."
].joinedAsLines()

configuration.documentation.readMe.exampleUsage["🇨🇦EN"] = "\u{23}example(readMe🇨🇦EN)"

configuration.continuousIntegration.skipSimulatorOutsideContinuousIntegration = true
configuration.documentation.api.encryptedTravisCIDeploymentKey = "gzx7ARrCgcNJiDtT/FALmdVgEYO5p7ZxlUuzOgwUTe9whOKD18POfAkgtRgYHLT7BMeN6+l9d26FJYfeH9Gvr6M4GVLqFpxKeW/DbcGABiJKok+qXkCXjbW+7ImqqarMyhXLyTZA5CdTAVTMLc9CnpqQJZphih2mbQZf06Jg3ZzCLRcsWmfvoehEgGTkt/xWNomYKZSuXOJZqNAMz847Tdx3rnOz8D41m1y+Y1xEOCdEnxtIg3JYQDs2OGjq0VT61qRaNm3fDf/f/VUK77q6vLUhCAXmdm19Qw5vSRt4u8G6pTuFdHxlRy9NrIHXzFj7IeomvtJzmAgxo+f+zRTgBcwbOpwHy3H2B1DILGwpWxQxsKelSjGJM8mEvs6cdXjTuvuLC4vwrkQyauDFlA2O/O3vZJFGyw6hJT2crVAO6tU2r71I36MgtI7ut8FCuHFVINg9suUY2MxzF1E6sJ3v7Q9btz2HTFpiO/2/v3kSsbt/jJUCv2/dak3TrIlmispW+8Pba/xmQmlPj6MW+LdaWDV6fkexpi7+QyLfPTCAbfPuXx9ePIoWGmrSqe0nDsZIiPC+uPUXVYlj25I84YA+QI3eb2eTVWO/nhw/461184rU6Tv5g2SBj0FIkaDTHe21U8vskKvRTDjwuQ1/uQLl34SoVHPcM+XRl6sb3CNA+Zs="

configuration._applySDGOverrides()
configuration._validateSDGStandards()

// #workaround(workspace version 0.18.1, Coverage report is inaccurate.)
configuration.documentation.api.enforceCoverage = false
configuration.documentation.api.generate = false

// #workaround(workspace version 0.18.1, Generated test files are not ignored by default.)
configuration.repository.ignoredPaths.insert("Tests/LinuxMain.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGBinaryDataTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGCalendarTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGCollectionsTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGConcurrencyTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGControlFlowTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGCornerstoneDocumentationExampleTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGExternalProcessTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGGeometryTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGLocalizationTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGLogicTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGMathematicsTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGPersistenceTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGPrecisionMathematicsTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGRandomizationTests/XCTestManifests.swift")
configuration.repository.ignoredPaths.insert("Tests/SDGTextTests/XCTestManifests.swift")
