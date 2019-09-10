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

configuration.documentation.currentVersion = Version(2, 3, 0)

configuration.documentation.projectWebsite = URL(string: "https://sdggiesbrecht.github.io/SDGCornerstone")!
configuration.documentation.documentationURL = URL(string: "https://sdggiesbrecht.github.io/SDGCornerstone")!
configuration.documentation.api.yearFirstPublished = 2017
configuration.documentation.repositoryURL = URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.continuousIntegration.skipSimulatorOutsideContinuousIntegration = true
configuration.documentation.api.encryptedTravisCIDeploymentKey = "gzx7ARrCgcNJiDtT/FALmdVgEYO5p7ZxlUuzOgwUTe9whOKD18POfAkgtRgYHLT7BMeN6+l9d26FJYfeH9Gvr6M4GVLqFpxKeW/DbcGABiJKok+qXkCXjbW+7ImqqarMyhXLyTZA5CdTAVTMLc9CnpqQJZphih2mbQZf06Jg3ZzCLRcsWmfvoehEgGTkt/xWNomYKZSuXOJZqNAMz847Tdx3rnOz8D41m1y+Y1xEOCdEnxtIg3JYQDs2OGjq0VT61qRaNm3fDf/f/VUK77q6vLUhCAXmdm19Qw5vSRt4u8G6pTuFdHxlRy9NrIHXzFj7IeomvtJzmAgxo+f+zRTgBcwbOpwHy3H2B1DILGwpWxQxsKelSjGJM8mEvs6cdXjTuvuLC4vwrkQyauDFlA2O/O3vZJFGyw6hJT2crVAO6tU2r71I36MgtI7ut8FCuHFVINg9suUY2MxzF1E6sJ3v7Q9btz2HTFpiO/2/v3kSsbt/jJUCv2/dak3TrIlmispW+8Pba/xmQmlPj6MW+LdaWDV6fkexpi7+QyLfPTCAbfPuXx9ePIoWGmrSqe0nDsZIiPC+uPUXVYlj25I84YA+QI3eb2eTVWO/nhw/461184rU6Tv5g2SBj0FIkaDTHe21U8vskKvRTDjwuQ1/uQLl34SoVHPcM+XRl6sb3CNA+Zs="

configuration._applySDGOverrides()
configuration._validateSDGStandards()

configuration.documentation.api.ignoredDependencies = [

    // Swift
    "Dispatch",
    "Foundation",
    "XCTest"
]

// #workaround(workspace version 0.22.0, Too long for Travis CI.)
configuration.documentation.relatedProjects = []
