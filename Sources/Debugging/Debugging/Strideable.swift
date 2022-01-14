extension Strideable {

  public func verifyStrideable() {
    verifyComparable()
    _ = advanced(by: Stride.zero)
    print(#function)
  }
}
