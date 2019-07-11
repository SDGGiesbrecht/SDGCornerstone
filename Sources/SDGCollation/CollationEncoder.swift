
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
        data.append(contentsOf: bytes)
        data.append(count)
    }

    internal func encode(_ value: UInt8) throws {
        data.append(value)
    }

    internal func encode(_ value: CollationIndex) throws {
        let littleEndian = value.littleEndian
        let count = MemoryLayout<CollationIndex>.size
        let bytes: [UInt8] = (0 ..< UInt32(truncatingIfNeeded: count)).map { index in
            let offset: UInt32 = index × 8
            return UInt8(truncatingIfNeeded: littleEndian >> offset)
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
