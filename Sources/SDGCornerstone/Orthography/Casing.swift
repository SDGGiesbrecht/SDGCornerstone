/*
 Casing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A casing position used by languages that have distinct letter cases (but which use the same casing for titles as for sentences).
///
/// - SeeAlso: `EnglishCasing`
public enum Casing {

    /// The middle of a sentence.
    ///
    /// Everything is lowercase (except words such as names or acronyms which invariably appear capitalized).
    case sentenceMedial

    /// The beginning of a sentence.
    ///
    /// The first letter is capitalized. The remainding words are treated the same as `sentenceMedial`.
    case sentenceInitial

    internal func applySimpleAlgorithm(to string: StrictString) -> StrictString {
        switch self {
        case .sentenceMedial:
            return string
        case .sentenceInitial:
            let invalidUse = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
                switch localization {
                case .englishCanada: // [_Exempt from Test Coverage_]
                    return StrictString("Invalid use of \(#function). It cannot handle “\(string)”.")
                }
            })
            assert(¬string.isEmpty, invalidUse)
            var text = string
            let first = String(text.removeFirst())
            let replacement = first.uppercased()
            assert(replacement ≠ first, invalidUse)
            return text.prepending(contentsOf: replacement.scalars)
        }
    }

    internal func applySimpleAlgorithm(to markup: SemanticMarkup) -> SemanticMarkup {
        return SemanticMarkup(applySimpleAlgorithm(to: markup.source))
    }
}
