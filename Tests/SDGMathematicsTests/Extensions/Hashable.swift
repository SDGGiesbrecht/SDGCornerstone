import SDGMathematics

extension _Hashable {

  func exerciseHashableHashing() {
    var hasher = Hasher()
    hash(into: &hasher)
  }
}
