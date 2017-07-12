/*
 ReadMe.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Define Example: Read‐Me_]
import Foundation
import SDGCornerstone

// Localization

func sayHello() {

    enum ApplicationLocalization : String, Localization {
        case english = "en"
        case français = "fr"
        static let fallbackLocalization = ApplicationLocalization.english
    }

    let text = UserFacingText({ (localization: ApplicationLocalization, _: Void) -> StrictString in
        switch localization {
        case .english:
            return "Hello, world!"
        case .français:
            return "Bonjour, le monde !"
        }
    })

    print(text.resolved())
}

// Preferences

func storeAndRetrieveUsersName() {
    let preferences = Preferences.applicationPreferences

    // Store
    preferences["name"].value = "John Doe"

    // Retrieve
    if let usersName = preferences["name"].value?.as(String.self) {
        print("Hello, \(usersName)!")
    }
}

// File System

func saveAndLoadFile() {
    let file = "content"
    let url = FileManager.default.url(in: .applicationSupport, at: "folder/file.txt")

    do {

        // Save
        try file.save(to: url)

        // Load
        _ = try String(from: url)

    } catch {
        print("An unexpected error occurred.")
    }
}

// Shared Values

func shareValue() {

    class Owner {
        var property: Shared<String>
        init(property: Shared<String>) {
            self.property = property
        }
    }

    let originalOwner = Owner(property: Shared("original"))
    let anotherOwner = Owner(property: originalOwner.property)

    anotherOwner.property.value = "changed"

    print(originalOwner.property.value)
    // Prints “changed”.
}

// Pattern Matching

func searchForPattern() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    if numbers.contains(CompositePattern([
        LiteralPattern([1]), // 1
        ConditionalPattern(condition: { $0.isEven }), // 2
        AlternativePatterns([
            LiteralPattern([30, 40]), // (∅)
            LiteralPattern([3, 4]) // 3, 4
            ]),
        RepetitionPattern(NotPattern(LiteralPattern([5, 7]))), // 5, 6, 7, 8, 9 (...)
        LiteralPattern([10]) // 10
        ])) {

        print("I found a match!")
    }
}

// Randomization

func playWithDice() {

    func rollDie() -> Int {
        return Int(randomInRange: 1 ... 6)
    }

    if rollDie() == 1 ∧ rollDie() == 1 {
        print("Snake eyes!")
    } else {
        print("Not this time...")
    }
}

// Arbitrary Precision Arithmetic

let tenDuotrigintillion: WholeNumber = "10 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000"

#if os(macOS) || os(Linux)

    // Shell Commands

    func introduceShell() {
        _ = try? Shell.default.run(command: ["echo", "Hello, world!"])
    }
#endif
// [_End_]
