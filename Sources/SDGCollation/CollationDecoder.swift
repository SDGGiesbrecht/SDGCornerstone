
import Foundation

import SDGControlFlow
import SDGMathematics

internal class CollationDecoder : Decoder, SingleValueDecodingContainer, UnkeyedDecodingContainer {

    // MARK: - Initialization

    internal init() {}

    // MARK: - Properties

    private var data: Data = Data()

    // MARK: - Usage

    internal func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        self.data = data
        return try decode(type)
    }

    // MARK: - Decoder

    internal var codingPath: [CodingKey] {
        _unreachable()
    }

    internal var userInfo: [CodingUserInfoKey : Any] {
        _unreachable()
    }

    internal func container<Key>(
        keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        _unreachable()
    }

    internal func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return self
    }

    internal func singleValueContainer() throws -> SingleValueDecodingContainer {
        return self
    }

    // SingleValueDecodingContainer

    internal func decodeNil() -> Bool {
        _unreachable()
    }

    internal func decode(_ type: String.Type) throws -> String {
        let encodedCount = try decode(UInt8.self)
        let count = Int(truncatingIfNeeded: encodedCount)
        let bytes = data.suffix(count)
        data.removeLast(count)
        return try String(file: bytes, origin: nil)
    }

    internal func decode(_ type: UInt8.Type) throws -> UInt8 {
        return data.removeLast()
    }

    internal func decode(_ type: CollationIndex.Type) throws -> UInt32 {
        let count = MemoryLayout<CollationIndex>.size
        let bytes = data.suffix(count)
        data.removeLast(count)

        var littleEndian: UInt32 = 0
        for byte in bytes.indices {
            littleEndian = littleEndian << 8
            littleEndian += UInt32(truncatingIfNeeded: byte)
        }
        return UInt32(littleEndian: littleEndian)
    }

    internal func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try T(from: self)
    }

    // MARK: - UnkeyedDecodingContainer

    internal var count: Int? {
        _unreachable()
    }
    internal var isAtEnd: Bool {
        _unreachable()
    }
    internal var currentIndex: Int {
        _unreachable()
    }

    internal func nestedContainer<NestedKey>(
        keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        _unreachable()
    }

    internal func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        _unreachable()
    }

    internal func superDecoder() throws -> Decoder {
        _unreachable()
    }
}
