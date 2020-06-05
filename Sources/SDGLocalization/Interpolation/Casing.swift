/*
 Casing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation
#endif

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText

/// A casing position used by languages that have distinct letter cases (but which use the same casing for titles as for sentences).
///
/// - SeeAlso: `EnglishCasing`
public enum Casing: CaseIterable, Decodable, Encodable, Hashable {

  /// The middle of a sentence.
  ///
  /// Everything is lowercase (except words such as names or acronyms which invariably appear capitalized).
  case sentenceMedial

  /// The beginning of a sentence.
  ///
  /// The first letter is capitalized. The remainding words are treated the same as `sentenceMedial`.
  case sentenceInitial

  /// Takes a string in the sentence medial case and transforms it to the expected case.
  ///
  /// - Warning: This method is only intended for use with compile‐time constants to reduce repetition in source code. Only the very simplest strings are supported. Passing a string which contains anything besides lowercase letters and combining marks will cause a precondition failure.
  ///
  /// - Parameters:
  ///     - compileTimeString: The string to transform.
  public func apply(to compileTimeString: StaticString) -> StrictString {
    var string = StrictString(compileTimeString)
    // #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
    #if !os(WASI)
      assert(
        ¬string.contains(where: {
          $0 ∉ CharacterSet.lowercaseLetters ∪ CharacterSet.nonBaseCharacters
        }),
        UserFacing<StrictString, _APILocalization>({ localization in  // @exempt(from: tests)
          switch localization {  // @exempt(from: tests)
          case .englishCanada:
            return "“\(string)” is too complex for automatic casing."
          }
        })
      )
    #endif

    switch self {
    case .sentenceMedial:
      return string
    case .sentenceInitial:
      let first = String(string.removeFirst())
      let replacement = first.uppercased()
      return string.prepending(contentsOf: replacement.scalars)
    }
  }

  // MARK: Decodable

  public init(from decoder: Decoder) throws {
    try self.init(from: decoder, via: String.self, convert: { return Casing.codes[$0] })
  }

  // MARK: - Encodable

  private static let codes: BijectiveMapping<Casing, String> = {
    var dictionary: [Casing: String] = [:]
    for entry in allCases {
      let value: String
      switch entry {
      case .sentenceMedial:
        value = "α"
      case .sentenceInitial:
        value = "Α"
      }
      dictionary[entry] = value
    }
    return BijectiveMapping(dictionary)
  }()

  public func encode(to encoder: Encoder) throws {
    try self.encode(to: encoder, via: Casing.codes[self]!)
  }
}
