extension FixedWidthInteger {

  public func verifyFixedWidthInteger() {
    verifyBinaryInteger()
    verifyLosslessStringConvertible()
    _ = Self("", radix: 10)
    print(#function)
  }
}
