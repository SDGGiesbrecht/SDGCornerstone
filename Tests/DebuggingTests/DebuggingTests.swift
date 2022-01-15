import XCTest
protocol UmbrellaProtocol: Hashable {}
extension UmbrellaProtocol {
  func exercise() {
    var hasher = Hasher()
    hash(into: &hasher)
  }
}
extension Int: UmbrellaProtocol {
  func exercise() {
    var hasher = Hasher()
    hash(into: &hasher)
  }
}
class DebuggingTests: XCTestCase {
  func testInt() {
    0.exercise()
  }
}
