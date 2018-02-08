/*
 EnglishCasing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A casing position used by the English language.
///
/// - SeeAlso: `Casing`
public enum EnglishCasing {

    /// The middle of a sentence.
    ///
    /// Everything is lowercase (except words such as names or acronyms which invariably appear capitalized).
    case sentenceMedial

    /// The beginning of a sentence.
    ///
    /// The first letter is capitalized. The remainding words are treated the same as `sentenceMedial`.
    case sentenceInitial

    /// The middle of a title.
    ///
    /// The first letter of every word is capitalized, except articles or prepositions.
    case titleMedial

    /// The beginning of a title.
    ///
    /// The first letter is capitalized even if it is part of an article or preposition. The remaining words are treated the same as `titleMedial`.
    case titleInitial

    internal func applySimpleAlgorithm(to string: StrictString) -> StrictString {
        let invalidUse = UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in // [_Exempt from Test Coverage_]
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return StrictString("Invalid use of \(#function). It cannot handle “\(string)”.")
            }
        })
        assert(¬string.contains(" "), invalidUse)
        switch self {
        case .sentenceMedial:
            return string
        case .sentenceInitial, .titleMedial, .titleInitial:
            assert(¬string.isEmpty, invalidUse)
            var text = string
            let first = String(text.removeFirst())
            let replacement = first.uppercased()
            assert(replacement ≠ first, invalidUse)
            return text.prepending(contentsOf: replacement.scalars)
        }
    }
}
