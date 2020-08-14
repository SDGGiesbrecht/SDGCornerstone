/*
 StrictInterpolationExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

import SDGXCTestUtilities

class StrictInterpolationExampleTests: TestCase {

  func testStrictInterpolation() {
    #if !os(Windows)  // #workaround(Swift 5.2.4, Segmentation fault.)
      func getError() -> Any {
        return ""
      }
      // @example(strictInterpolation)
      var strict: StrictString = ""

      // String‐like types can be interpolated directly:
      let string: String = "Hello, world!"
      let character: Unicode.Scalar = "?"
      strict = "\(string) ...\(character)"

      // Most other types must be explicitly converted to some predictable text representation:
      let number = Int.random(in: 0...1000)
      strict = "“\(number.inRomanNumerals())” means the same as “\(number.inDigits())”."

      // The Swift compiler’s own description of any value can still be requested explicitly:
      let something: Any = getError()
      strict = "Error: \(arbitraryDescriptionOf: something)"
      // @endExample
      _ = strict

      func fehlerHolen() -> Any {
        return ""
      }
      // @example(strengeInterpolation)
      var streng: StrengeZeichenkette = ""

      // Typen, die Zeichenketten ähneln können direkt interpoliert werden:
      let zeichenkette: Zeichenkette = "Hallo, Welt!"
      let zeichen: Unicode.Skalar = "?"
      streng = "\(zeichenkette) ...\(zeichen)"

      // Die meisten anderen Typen müssen ausdrücklich in einer bestimmten Textform umgewandelt werden:
      let zahl = GZahl.zufällige(in: 0...1000)
      streng =
        "„\(zahl.inRömischerZahlschrift())“ bedeutet das selbe wie „\(zahl.inZahlzeichen())“."

      // Die Beschreibungen des Swift‐Übersetzers können immer noch ausdrücklich verlangt werden:
      let etwas: Any = fehlerHolen()
      streng = "Fehler: \(willkürlicheBeschreibungVon: etwas)"
      // @endExample
      _ = streng
    #endif
  }
}
