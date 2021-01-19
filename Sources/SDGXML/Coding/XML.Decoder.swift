/*
 XML.Decoder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText

extension XML {

  /// An decoder which converts XML into `Decodable` values.
  public struct Decoder {

    // MARK: - Initialization

    /// Creates an XML decoder.
    ///
    /// - Parameters:
    ///   - userInformation: User‐provided information for use during encoding.
    public init(userInformation: [CodingUserInfoKey: Any] = [:]) {
      self.userInformation = userInformation
    }

    // MARK: - Properties

    public var userInformation: [CodingUserInfoKey: Any]

    // MARK: - Encoding

    /// Decodes a top‐level value from XML source.
    ///
    /// - Parameters:
    ///   - type: The type to decode.
    ///   - source: The source from which to decode.
    public func decode<T: Decodable>(_ type: T.Type, from source: StrictString) throws -> T {
      let element = try XML.Element(source: source)
      let implementation = Implementation(rootElement: element, userInformation: userInformation)
      return try implementation.decode(type)
    }

    /// Decodes a top‐level value from XML data.
    ///
    /// - Parameters:
    ///   - type: The type to decode.
    ///   - data: The data from which to decode.
    public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
      return try decode(type, from: StrictString(file: data, origin: nil))
    }
  }
}
