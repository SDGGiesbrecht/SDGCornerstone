import XCTest
public protocol UmbrellaProtocol: Decodable, Encodable, Hashable {}
extension UmbrellaProtocol {
  public func exercise() {
    var hasher = Hasher()
    hash(into: &hasher)
  }
}
extension Int: UmbrellaProtocol {}
class DebuggingTests: XCTestCase {
  func testInt() {
    0.exercise()
  }
}
