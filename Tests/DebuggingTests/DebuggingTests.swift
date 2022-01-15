import Debugging

import XCTest

class DebuggingTests: XCTestCase {

  func testInt() {
    let int = 0
    int.verifyEquatable()
    int.verifyHashable()
    int.verifyAddable()
    int.verifySubtractable()
    int.verifyGenericAdditiveArithmetic()
  }
}
