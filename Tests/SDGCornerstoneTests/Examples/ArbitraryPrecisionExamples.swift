/*
 ArbitraryPrecisionExamples.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

// [_Define Example: WholeNumber Literals_]
let million: WholeNumber = 1_000_000
let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
let yobiMultiplier = WholeNumber(binary: "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
// [_End_]

// [_Define Example: Integer Literals_]
let negativeMillion: Integer = −1_000_000
let negativeDecillion: Integer = −"1 000 000 000 000 000 000 000 000 000 000 000"
let negativeYobiMultiplier = −Integer(binary: "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
// [_End_]

// [_Define Example: RationalNumber Literals_]
let third: RationalNumber = 1 ÷ 3
let decillionth: RationalNumber = "0.000 000 000 000 000 000 000 000 000 000 000 1"
let half = RationalNumber(binary: "0.1")
// [_End_]
