extension AdditiveArithmetic {

  public func verifyAdditiveArithmetic() {
    var copy = self
    copy += self
    print(#function)
  }
}
