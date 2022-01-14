import Debugging

import XCTest

class DebuggingTests: XCTestCase {

  func testInt() {
    let int = 0
    int.verifyCustomReflectable()
    int.verifyCVarArg()
    int.verifyCustomStringConvertible()
    int.verifyEquatable()
    int.verifyHashable()
    int.verifyAdditiveArithmetic()
    int.verifyExpressibleByIntegerLiteral()
    int.verifyNumeric()
    int.verifyComparable()
    int.verifyStrideable()
    int.verifyBinaryInteger()
    int.verifyLosslessStringConvertible()
    int.verifyFixedWidthInteger()
    int.verifyDecodable()
    int.verifyEncodable()
    int.verifyAddable()
    int.verifySubtractable()
  }
}
