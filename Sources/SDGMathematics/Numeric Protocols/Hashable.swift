
// #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
public protocol _Hashable: Hashable, __Hashable {}
public protocol __Hashable {
  func hash(into hasher: inout Hasher)
}
public struct _HashableWrapper<T>: _Hashable where T: _Hashable {
  public init(_ wrapped: T) {
    self.wrapped = wrapped
  }
  let wrapped: T
  public func hash(into hasher: inout Hasher) {
    wrapped.hash(into: &hasher)
  }
}
