extension Comparable {

  public func verifyComparable() {
    verifyEquatable()
    _ = self > self
    print(#function)
  }
}
