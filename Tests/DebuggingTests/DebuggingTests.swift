import XCTest
protocol UmbrellaProtocol: Hashable {}
extension UmbrellaProtocol {
  func exercise() {}
}
extension Int: UmbrellaProtocol {}
class DebuggingTests: XCTestCase {
  func testInt() {
    0.exercise()
  }
}
