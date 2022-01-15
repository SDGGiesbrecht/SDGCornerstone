import XCTest
public protocol GenericAdditiveArithmetic: AdditiveArithmetic, Decodable, Encodable, Hashable
{}
extension GenericAdditiveArithmetic {
  public func verifyGenericAdditiveArithmetic() {
    var hasher = Hasher()
    hash(into: &hasher)
    print(#function)
  }
}
extension Int: GenericAdditiveArithmetic {}
class DebuggingTests: XCTestCase {
  func testInt() {
    let int = 0
    int.verifyGenericAdditiveArithmetic()
  }
}
