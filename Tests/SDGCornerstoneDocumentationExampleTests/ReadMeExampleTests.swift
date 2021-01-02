/*
 ReadMeExampleTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText
import SDGPersistence
import SDGLocalization
import SDGPrecisionMathematics
import SDGExternalProcess

import XCTest

import SDGXCTestUtilities

class ReadMeExampleTests: TestCase {

  func testReadMe() {
    // #workaround(Swift 5.3.1, Segmentation fault.)
    // #workaround(Swift 5.3.2, Web lacks FileManager.)
    #if !(os(Windows) || os(WASI))
      LocalizationSetting(orderOfPrecedence: ["en"]).do {
        // @example(readMe🇨🇦EN)
        // ••••••• Localization •••••••

        enum ApplicationLocalization: String, Localization {
          case english = "en"
          case français = "fr"
          static let fallbackLocalization = ApplicationLocalization.english
        }

        // Define
        let text = UserFacing<StrictString, ApplicationLocalization>({ localization in
          switch localization {
          case .english:
            return "Hello, world!"
          case .français:
            return "Bonjour, le monde !"
          }
        })

        // Use
        XCTAssertEqual(
          text.resolved(),
          "Hello, world!"
        )

        // ••••••• Preferences •••••••

        let preferences = PreferenceSet.applicationPreferences

        // Save
        preferences["name"].value.set(to: "John Doe")
        // Load
        let loaded: String? = preferences["name"].value.as(String.self)

        XCTAssertEqual(
          loaded,
          "John Doe"
        )

        // ••••••• File System •••••••

        let url = FileManager.default.url(in: .applicationSupport, at: "folder/file.txt")
        do {
          // Save
          try "Contents".save(to: url)
          // Load
          let loaded = try String(from: url)

          XCTAssertEqual(
            loaded,
            "Contents"
          )
        } catch {
          XCTFail(error.localizedDescription)
        }

        // ••••••• Shared Values •••••••

        class Owner {
          @SharedProperty var property: String = ""
        }

        let originalOwner = Owner()
        originalOwner.property = "original"
        let anotherOwner = Owner()
        anotherOwner.$property = originalOwner.$property

        anotherOwner.property = "changed"
        XCTAssertEqual(
          originalOwner.property,
          "changed"
        )

        // ••••••• Pattern Matching •••••••

        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let patternFirstPart =
          [1]  // 1
          + ConditionalPattern({ $0.isEven })  // 2
          + ([30, 40]  // (∅)
            ∨ [3, 4])  // 3, 4
        let pattern =
          patternFirstPart
          + RepetitionPattern(¬[5, 7])  // 5, 6, 7, 8, 9 (...)
          + [10]  // 10

        XCTAssertEqual(
          numbers.firstMatch(for: pattern)?.range,
          numbers.startIndex..<numbers.endIndex
        )

        // ••••••• Arbitrary Precision Arithmetic •••••••

        let tenDuotrigintillion: WholeNumber =
          "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"
        XCTAssert(tenDuotrigintillion.isDivisible(by: 10))

        // ••••••• Shell Commands •••••••

        #if !(os(tvOS) || os(iOS) || os(watchOS))
          XCTAssertEqual(
            try? Shell.default.run(command: ["echo", "Hello, world!"]).get(),
            "Hello, world!"
          )
        #endif
        // @endExample
      }
    #endif
  }
}
