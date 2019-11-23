
@testable import SDGCollections

func forAllLegacyModes(_ closure: () throws -> Void) rethrows {
  for mode in [false, true] {
    let previous = legacyMode
    legacyMode = mode
    defer { legacyMode = previous }
    
    try closure()
  }
}
