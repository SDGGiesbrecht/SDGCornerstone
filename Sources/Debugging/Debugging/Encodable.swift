extension Encodable {

  public func verifyEncodable() {
    try? encode(to: MockEncoder())
    print(#function)
  }
}

private struct MockEncoder: Encoder {
  var codingPath: [CodingKey] { return [] }
  var userInfo: [CodingUserInfoKey : Any] { return [:] }
  func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
    return KeyedEncodingContainer(MockKeyedEncodingContainer())
  }
  func unkeyedContainer() -> UnkeyedEncodingContainer {
    return MockUnkeyedEncodingContainer()
  }
  func singleValueContainer() -> SingleValueEncodingContainer {
    return MockSingleValueEncodingContainer()
  }
}
private struct MockKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
  var codingPath: [CodingKey] { return [] }
  mutating func encodeNil(forKey key: Key) throws {}
  mutating func encode(_ value: Bool, forKey key: Key) throws {}
  mutating func encode(_ value: String, forKey key: Key) throws {}
  mutating func encode(_ value: Double, forKey key: Key) throws {}
  mutating func encode(_ value: Float, forKey key: Key) throws {}
  mutating func encode(_ value: Int, forKey key: Key) throws {}
  mutating func encode(_ value: Int8, forKey key: Key) throws {}
  mutating func encode(_ value: Int16, forKey key: Key) throws {}
  mutating func encode(_ value: Int32, forKey key: Key) throws {}
  mutating func encode(_ value: Int64, forKey key: Key) throws {}
  mutating func encode(_ value: UInt, forKey key: Key) throws {}
  mutating func encode(_ value: UInt8, forKey key: Key) throws {}
  mutating func encode(_ value: UInt16, forKey key: Key) throws {}
  mutating func encode(_ value: UInt32, forKey key: Key) throws {}
  mutating func encode(_ value: UInt64, forKey key: Key) throws {}
  mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {}
  mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
    return KeyedEncodingContainer(MockKeyedEncodingContainer<NestedKey>())
  }
  mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
    return MockUnkeyedEncodingContainer()
  }
  mutating func superEncoder() -> Encoder {
    return MockEncoder()
  }
  mutating func superEncoder(forKey key: Key) -> Encoder {
    return MockEncoder()
  }
}
private struct MockUnkeyedEncodingContainer: UnkeyedEncodingContainer {
  var codingPath: [CodingKey] { return [] }
  var count: Int { return 0 }
  mutating func encodeNil() throws {}
  mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
    return KeyedEncodingContainer(MockKeyedEncodingContainer<NestedKey>())
  }
  mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
    return MockUnkeyedEncodingContainer()
  }
  mutating func superEncoder() -> Encoder {
    return MockEncoder()
  }
  mutating func encode(_ value: Bool) throws {}
  mutating func encode(_ value: String) throws {}
  mutating func encode(_ value: Double) throws {}
  mutating func encode(_ value: Float) throws {}
  mutating func encode(_ value: Int) throws {}
  mutating func encode(_ value: Int8) throws {}
  mutating func encode(_ value: Int16) throws {}
  mutating func encode(_ value: Int32) throws {}
  mutating func encode(_ value: Int64) throws {}
  mutating func encode(_ value: UInt) throws {}
  mutating func encode(_ value: UInt8) throws {}
  mutating func encode(_ value: UInt16) throws {}
  mutating func encode(_ value: UInt32) throws {}
  mutating func encode(_ value: UInt64) throws {}
  mutating func encode<T>(_ value: T) throws where T : Encodable {}
}
private struct MockSingleValueEncodingContainer: SingleValueEncodingContainer {
  var codingPath: [CodingKey] { return [] }
  mutating func encodeNil() throws {}
  mutating func encode(_ value: Bool) throws {}
  mutating func encode(_ value: String) throws {}
  mutating func encode(_ value: Double) throws {}
  mutating func encode(_ value: Float) throws {}
  mutating func encode(_ value: Int) throws {}
  mutating func encode(_ value: Int8) throws {}
  mutating func encode(_ value: Int16) throws {}
  mutating func encode(_ value: Int32) throws {}
  mutating func encode(_ value: Int64) throws {}
  mutating func encode(_ value: UInt) throws {}
  mutating func encode(_ value: UInt8) throws {}
  mutating func encode(_ value: UInt16) throws {}
  mutating func encode(_ value: UInt32) throws {}
  mutating func encode(_ value: UInt64) throws {}
  mutating func encode<T>(_ value: T) throws where T : Encodable {}
}
