extension Decodable {

  public func verifyDecodable() {
    _ = try? Self(from: MockDecoder())
    print(#function)
  }
}

private struct MockError: Error {}
private struct MockDecoder: Decoder {
  var codingPath: [CodingKey] { return [] }
  var userInfo: [CodingUserInfoKey: Any] { [:] }
  func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
    throw MockError()
  }
  func unkeyedContainer() throws -> UnkeyedDecodingContainer {
    throw MockError()
  }
  func singleValueContainer() throws -> SingleValueDecodingContainer {
    throw MockError()
  }
}
