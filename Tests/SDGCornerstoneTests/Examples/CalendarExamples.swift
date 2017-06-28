/*
 CalendarExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

func demonstrateGregorianYear() {
    // [_Define Example: Gregorian Year_]
    let year = GregorianYear(1) − 1
    // 1 BC

    let timespan = GregorianYear(1) − GregorianYear(−1)
    // 1 year
    // [_End_]
}
