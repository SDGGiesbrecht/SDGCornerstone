/*
 XMLEncoder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// An encoder which converts `Encodable` values into XML.
public class XMLEncoder {

  // MARK: - Initialization

  /// Creates an XML encoder.
  public init() {}

  // MARK: - Encoding

  /// Encodes a top‐level value as XML.
  ///
  /// - Parameters:
  ///   - value: The value.
  public func encode<Value: Encodable>(_ value: Value) throws -> Data {
    let implementation = Implementation()
    let root = try implementation.box(value)
    return root.source().file
  }
}
