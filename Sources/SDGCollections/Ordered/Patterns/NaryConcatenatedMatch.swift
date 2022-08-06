
/// A match for n‐ary concatenated patterns.
public struct NaryConcatenatedMatch<Individual>: PatternMatch
where Individual: PatternMatch {

  // MARK: - Initialization

  /// Creates an n‐ary concatenated match.
  ///
  /// - Parameters:
  ///   - elements: The individual matches.
  ///   - contents: The contents of all the matches together.
  @inlinable public init(elements: [Individual], contents: Searched.SubSequence) {
    self.elements = elements
    self.contents = contents
  }

  // MARK: - Properties

  /// The individual elements.
  public let elements: [Individual]

  // MARK: - PatternMatch

  public typealias Searched = Individual.Searched
  public let contents: Individual.Searched.SubSequence
}
