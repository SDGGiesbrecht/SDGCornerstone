extension LosslessStringConvertible {

  public func verifyLosslessStringConvertible() {
    verifyCustomStringConvertible()
    _ = Self("")
    print(#function)
  }
}
