
// #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
public protocol _Hashable: Hashable {
  func hash(into hasher: inout Hasher)
}
