/*
 Decodable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText

extension Decodable {

  // #documentation(SDGCornerstone.Decodable.init(from:via:convert:))
  /// Creates a new instance by decoding a proxy type from the given decoder.
  ///
  /// - Parameters:
  ///   - decoder: The decoder.
  ///   - type: The proxy type.
  ///   - convert: A closure which converts from the proxy type.
  public init<Other>(
    from decoder: Decoder,
    via type: Other.Type,
    convert: (_ other: Other) throws -> Self?
  ) throws where Other: Decodable {
    let container = try decoder.singleValueContainer()
    let other = try container.decode(Other.self)

    func generateError(underlyingError: Error?) -> DecodingError {
      let context = DecodingError.Context(
        codingPath: container.codingPath,
        debugDescription: String(
          UserFacing<StrictString, _APILocalization>({ localization in
            switch localization {
            case .englishCanada:
              return
                "Invalid “\(typeName: Other.self)” representation of “\(typeName: Self.self)”: \(arbitraryDescriptionOf: other)"
            }
          }).resolved()
        ),
        underlyingError: underlyingError
      )
      return DecodingError.typeMismatch(Self.self, context)
    }

    do {
      guard let decoded = try convert(other) else {
        throw generateError(underlyingError: nil)
      }
      self = decoded
    } catch {
      throw generateError(underlyingError: error)
    }
  }
}
