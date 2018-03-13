/*
 EnglishCasing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

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

    /// Takes a string in the sentence medial case and transforms it to the expected case.
    ///
    /// - Warning: This method is only intended for use with compile‐time constants to reduce repetition in source code. Only the very simplest strings are supported. Passing a string which contains anything besides lowercase a–z will cause an precondition failure.
    @_transparent public func apply(to compileTimeString: StaticString) -> StrictString {
        var string = StrictString(compileTimeString)
        assert(¬string.contains(where: { $0 ∉ "a" ..< "z" }), UserFacingText({ (localization: _APILocalization) in // [_Exempt from Test Coverage_]
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return StrictString("“\(string)” is too complex for automatic casing.")
            }
        }))

        switch self {
        case .sentenceMedial:
            return string
        case .sentenceInitial, .titleMedial, .titleInitial:
            let first = String(string.removeFirst())
            let replacement = first.uppercased()
            return string.prepending(contentsOf: replacement.scalars)
        }
    }
}
