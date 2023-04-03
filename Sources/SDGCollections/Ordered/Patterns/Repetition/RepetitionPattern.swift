/*
 RepetitionPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics

/// A pattern that matches against repetitions of another pattern.
public struct RepetitionPattern<Base>: Pattern where Base: Pattern {

  // MARK: - Initialization

  // @documentation(SDGCornerstone.Repetition.init(of:count:consumption))
  /// Creates a repetition pattern from another pattern.
  ///
  /// - Precondition: `count` must not involve a negative bound.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to repeat.
  ///     - count: A range representing the allowed number of repetitions.
  ///     - consumption: The desired consumption behaviour.
  @inlinable public init(
    _ pattern: Base,
    count: CountableRange<Int>? = nil,
    consumption: Consumption = .greedy
  ) {
    _assert(
      count == nil ∨ count!.lowerBound.isNonNegative,
      { (localization: _APILocalization) -> String in  // @exempt(from: tests)
        switch localization {  // @exempt(from: tests)
        case .englishCanada:
          return
            "Matching a negative number of instances of a pattern is undefined. (\(count!.lowerBound))"
        }
      }
    )

    self.pattern = pattern
    self.count = count ?? 0..<Int.max
    self.consumption = consumption
  }

  // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
  /// Creates a repetition pattern from another pattern.
  ///
  /// - Precondition: `count` must not involve a negative bound.
  ///
  /// - Parameters:
  ///     - pattern: The pattern to repeat.
  ///     - count: A range representing the allowed number of repetitions.
  ///     - consumption: The desired consumption behaviour.
  @inlinable public init(
    _ pattern: Base,
    count: CountableClosedRange<Int>?,
    consumption: Consumption = .greedy
  ) {
    let converted = count.map { $0.lowerBound..<$0.upperBound + 1 }
    self.init(pattern, count: converted, consumption: consumption)
  }

  // MARK: - Properties

  @usableFromInline internal var pattern: Base
  @usableFromInline internal var count: CountableRange<Int>
  @usableFromInline internal var consumption: Consumption

  // MARK: - Pattern

  public typealias Match = RepetitionMatch<Base.Match>

  @inlinable internal func checkNext(
    in collection: Searchable,
    after preceding: inout [[Base.Match]],
    whichStartAt location: Searchable.Index
  ) {
    preceding =
      preceding
      .flatMap { (predecessors: [Base.Match]) -> [[Base.Match]] in
        let cursor =
          predecessors.last?.range.upperBound
          ?? location
        if cursor == collection.endIndex {
          return []
        } else {
          return pattern.matches(in: collection, at: cursor)
            .map { (next: Base.Match) -> [Base.Match] in
              return predecessors.appending(next)
            }
        }
      }
  }

  @inlinable public func matches(
    in collection: Match.Searched,
    at location: Match.Searched.Index
  ) -> [RepetitionMatch<Base.Match>] {

    var accumulator: [[Base.Match]] = [[]]

    for _ in 0..<count.lowerBound {
      if accumulator.isEmpty {
        // Finished (not a complete match yet)
        return []
      } else {
        // Continue
        checkNext(in: collection, after: &accumulator, whichStartAt: location)
      }
    }

    var valid: [[Base.Match]] = []
    func cleanUp() -> [RepetitionMatch<Base.Match>] {
      switch consumption {
      case .greedy:
        valid.reverse()
      case .lazy:
        break
      }
      return valid.map { (repetition: [Base.Match]) -> RepetitionMatch<Base.Match> in
        if let start = repetition.first?.range.lowerBound,
          let end = repetition.last?.range.upperBound
        {
          return RepetitionMatch(components: repetition, contents: collection[start..<end])
        } else {
          return RepetitionMatch(components: repetition, contents: collection[location..<location])
        }
      }
    }

    for _ in count {
      if accumulator.isEmpty {
        // Finished (nothing longer)
        return cleanUp()
      } else {
        // Continue
        valid.append(contentsOf: accumulator)
        checkNext(in: collection, after: &accumulator, whichStartAt: location)
      }
    }

    // Finished (hit cap)
    return cleanUp()
  }

  @inlinable public func primaryMatch(
    in collection: Searchable,
    at location: Searchable.Index
  ) -> RepetitionMatch<Base.Match>? {

    switch consumption {
    case .greedy:
      return matches(in: collection, at: location).first
    case .lazy:

      var accumulator: [[Base.Match]] = [[]]

      for _ in 0..<count.lowerBound {
        if accumulator.isEmpty {
          // Finished (not a complete match yet)
          return nil
        } else {
          // Continue
          checkNext(in: collection, after: &accumulator, whichStartAt: location)
        }
      }

      return accumulator.first.map { repetition in
        if let start = repetition.first?.range.lowerBound,
          let end = repetition.last?.range.upperBound
        {
          return RepetitionMatch(components: repetition, contents: collection[start..<end])
        } else {
          return RepetitionMatch(components: repetition, contents: collection[location..<location])
        }
      }
    }
  }

  @inlinable public func forSubSequence() -> RepetitionPattern<
    Base.SubSequencePattern
  > {
    return RepetitionPattern<Base.SubSequencePattern>(
      pattern.forSubSequence(),
      count: count,
      consumption: consumption
    )
  }

  @inlinable public func convertMatch(
    from subSequenceMatch: RepetitionMatch<Base.SubSequencePattern.Match>,
    in collection: Searchable
  ) -> RepetitionMatch<Base.Match> {
    return RepetitionMatch(
      components: subSequenceMatch.components.map({ match in
        return pattern.convertMatch(from: match, in: collection)
      }),
      contents: collection[subSequenceMatch.range]
    )
  }
}

extension RepetitionPattern: BidirectionalPattern where Base: BidirectionalPattern {

  // MARK: - BidirectionalPattern

  @inlinable public func reversed() -> RepetitionPattern<Base.Reversed> {
    return RepetitionPattern<Base.Reversed>(
      pattern.reversed(),
      count: count,
      consumption: consumption
    )
  }

  @inlinable public func forward(
    match reversedMatch: RepetitionMatch<Base.Reversed.Match>,
    in forwardCollection: Searchable
  ) -> RepetitionMatch<Base.Match> {
    let forwardRange = reversedMatch.range
    return RepetitionMatch(
      components: reversedMatch.components.reversed()
        .map { match in
          return pattern.forward(match: match, in: forwardCollection)
        },
      contents: forwardCollection[forwardRange.upperBound.base..<forwardRange.lowerBound.base]
    )
  }
}

extension RepetitionPattern: Sendable where Base: Sendable {}
