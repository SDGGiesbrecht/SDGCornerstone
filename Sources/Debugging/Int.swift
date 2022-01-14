extension Int: Addable, Subtractable {
  public static func − (precedingValue: Int, followingValue: Int) -> Int { return 0 }
  public static func −= (precedingValue: inout Int, followingValue: Int) {}
  public static func ± (precedingValue: Int, followingValue: Int) -> (sum: Int, difference: Int) { return (0, 0) }
}
