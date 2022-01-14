extension Equatable {

  public func verifyEquatable() {
    _ = self != self
    print(#function)
  }
}
