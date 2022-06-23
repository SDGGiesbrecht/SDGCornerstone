#warning("Delete this file.")

func exercise() {
  let string = "Hello!"

  // Pattern
  _ = string.matches(in: string, at: string.startIndex)

  // SearchableCollection
  _ = string.firstMatch(for: "!")
}
