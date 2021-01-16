/*
 XML.Encoder.UnkeyedContainer.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension XML.Encoder {

  internal struct UnkeyedContainer: UnkeyedEncodingContainer {

    // MARK: - Initialization

    internal init(_ encoder: Implementation) {
      self.encoder = encoder
    }

    // MARK: - Properties

    private let encoder: Implementation

    // MARK: - UnkeyedEncodingContainer

    internal var codingPath: [CodingKey] {
      return encoder.codingPath
    }

    internal var count: Int {
      return encoder.partialNodes.last?.children.count ?? 0
    }

    internal mutating func encodeNil() throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Bool) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: String) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Double) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Float) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int8) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int16) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int32) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: Int64) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt8) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt16) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt32) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode(_ value: UInt64) throws {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func encode<T>(_ value: T) throws where T: Encodable {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func nestedContainer<NestedKey>(
      keyedBy keyType: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey>
    where NestedKey: CodingKey {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
      #warning("Not implemented yet.")
      fatalError()
    }

    internal mutating func superEncoder() -> Encoder {
      #warning("Not implemented yet.")
      fatalError()
    }
  }
}
