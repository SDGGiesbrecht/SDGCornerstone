extension BinaryInteger {

  public func verifyBinaryInteger() {
    verifyCustomStringConvertible()
    verifyHashable()
    verifyNumeric()
    verifyStrideable()
    _ = Self(clamping: 0)
    print(#function)
  }
}
