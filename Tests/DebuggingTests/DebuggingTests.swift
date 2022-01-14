import Debugging

import XCTest

class DebuggingTests: XCTestCase {

  func testInt() {
    let int = 0
    int.verifyCustomReflectable()
    int.verifyCVarArg()
    int.verifyCustomStringConvertible()
  }
}
