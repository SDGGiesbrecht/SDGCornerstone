import XCTest
public protocol UmbrellaProtocol: AdditiveArithmetic, Decodable, Encodable, Hashable
{}
extension UmbrellaProtocol {
  public func exercise() {
    var hasher = Hasher()
    hash(into: &hasher)
  }
}
extension Int: UmbrellaProtocol {}
class DebuggingTests: XCTestCase {
  func testInt() {
    let int = 0
    int.exercise()
  }
}
