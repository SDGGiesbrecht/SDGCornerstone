extension AdditiveArithmetic {

  public func verifyAdditiveArithmetic() {
    verifyEquatable()
    var copy = self
    copy += self
    print(#function)
  }
}
