extension Numeric {

  public func verifyNumeric() {
    verifyAdditiveArithmetic()
    verifyExpressibleByIntegerLiteral()
    _ = Self(exactly: 0)
    print(#function)
  }
}
