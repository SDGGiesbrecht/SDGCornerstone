/*
 XML.Encoder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGPersistence

extension XML {

  /// An encoder which converts `Encodable` values into XML.
  public struct Encoder {

    // MARK: - Initialization

    /// Creates an XML encoder.
    ///
    /// - Parameters:
    ///   - userInformation: User‐provided information for use during encoding.
    public init(userInformation: [CodingUserInfoKey: Any] = [:]) {
      self.userInformation = userInformation
    }

    // MARK: - Properties

    var userInformation: [CodingUserInfoKey: Any]

    // MARK: - Encoding

    /// Encodes a top‐level value as XML source.
    ///
    /// - Parameters:
    ///   - value: The value.
    public func encodeToSource<Value: Encodable>(_ value: Value) throws -> StrictString {
      let implementation = Implementation(
        rootElementName: XML.sanitize(name: "\(arbitraryDescriptionOf: Value.self)"),
        userInfo: userInformation
      )
      try value.encode(to: implementation)
      return implementation.currentElement.source()
    }

    /// Encodes a top‐level value as XML data.
    ///
    /// - Parameters:
    ///   - value: The value.
    public func encode<Value: Encodable>(_ value: Value) throws -> Data {
      return try encodeToSource(value).file
    }
  }
}
