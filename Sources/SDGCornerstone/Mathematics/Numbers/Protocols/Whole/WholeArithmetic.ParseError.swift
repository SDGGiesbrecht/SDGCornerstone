/*
 WholeArithmetic.ParseError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An error that occurs while parsing a number from a string.
public enum WholeArithmeticParseError : Error {

    /// A character is present which is not a valid digit.
    case invalidDigit(UnicodeScalar)
}
