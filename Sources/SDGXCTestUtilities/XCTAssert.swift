/*
 XCTAssert.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

// #workaround(Swift 5.1, The generated Xcode project cannot import XCTest on iOS devices.)
#if !Xcode || MANIFEST_LOADED_BY_XCODE || !(os(iOS) || os(tvOS)) || targetEnvironment(simulator)

import XCTest

import SDGLogic
import SDGMathematics
import SDGText

// @localization(🇩🇪DE) @notLocalized(🇨🇦EN)
/// Stellt fest, ob zwei Werte gleich sind.
///
/// - Parameters:
///     - ausdruck1: Der erste Ausdruck.
///     - ausdruck2: Der zweite Ausdruck.
///     - mitteilung: Eine beschreibung des Fehlers.
///     - datei: Die Datei.
///     - zeile: Die Zeile.
@inlinable public func XCTFeststellenGleich<T>(
    _ ausdruck1: @autoclosure () throws -> T,
    _ ausdruck2: @autoclosure () throws -> T,
    _ mitteilung: @autoclosure () -> Zeichenkette = "", // @exempt(from: tests)
    datei: StatischeZeichenkette = #file,
    zeile: NZahl = #line) where T : Vergleichbar { // @exempt(from: tests)
    XCTAssertEqual(try ausdruck1(), try ausdruck2(), mitteilung(), file: datei, line: zeile) // @exempt(from: tests)
}

#endif

#endif
