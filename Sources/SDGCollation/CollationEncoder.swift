
import Foundation

import SDGControlFlow
import SDGMathematics

internal class CollationEncoder : Encoder, SingleValueEncodingContainer, UnkeyedEncodingContainer {

    // MARK: - Initialization

    internal init() {}

    // MARK: - Properties

    private var data: Data = Data()

    // MARK: - Usage

    internal func encode<T : Encodable>(_ value: T) throws -> Data {
        let _: Void = try encode(value)
        return data
    }

    // MARK: - Encoder

    internal var codingPath: [CodingKey] {
        _unreachable()
    }
    internal var userInfo: [CodingUserInfoKey : Any] {
        _unreachable()
    }

    internal func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        _unreachable()
    }

    internal func unkeyedContainer() -> UnkeyedEncodingContainer {
        return self
    }

    internal func singleValueContainer() -> SingleValueEncodingContainer {
        return self
    }

    // MARK: - SingleValueEncodingContainer

    internal func encodeNil() throws {
        _unreachable()
    }

    internal func encode(_ value: String) throws {
        let bytes = value.file
        let count = UInt8(truncatingIfNeeded: bytes.count)
        data.append(count)
        data.append(contentsOf: bytes)
    }

    internal func encode(_ value: CollationIndex) throws {
        var littleEndian = value.littleEndian
        let count = MemoryLayout<CollationIndex>.size
        let bytes = withUnsafePointer(to: &littleEndian) {
            $0.withMemoryRebound(to: UInt8.self, capacity: count) {
                UnsafeBufferPointer(start: $0, count: count)
            }
        }
        data.append(contentsOf: bytes)
    }

    internal func encode<T>(_ value: T) throws where T : Encodable {
        try value.encode(to: self)
    }

    // MARK: - UnkeyedEncodingContainer

    internal var count: Int {
        _unreachable()
    }

    internal func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        _unreachable()
    }

    internal func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        _unreachable()
    }

    internal func superEncoder() -> Encoder {
        _unreachable()
    }
}
