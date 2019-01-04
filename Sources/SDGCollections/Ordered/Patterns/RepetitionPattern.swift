/*
 RepetitionPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

/// A pattern that matches against repetitions of another pattern.
public final class RepetitionPattern<Element : Equatable> : Pattern<Element> {

    // MARK: - Initialization

    @inlinable internal init(abstractPattern pattern: Pattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        _assert(count == nil ∨ count!.lowerBound.isNonNegative, { (localization: _APILocalization) -> String in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "Matching a negative number of instances of a pattern is undefined. (\(count!.lowerBound))"
            }
        })

        self.pattern = pattern
        self.count = count ?? 0 ..< Int.max
        self.consumption = consumption
    }

    @usableFromInline internal static func convert(_ range: CountableClosedRange<Int>?) -> CountableRange<Int>? {
        if let result = range {
            return result.lowerBound ..< result.upperBound + 1
        } else {
            return nil
        }
    }

    // @documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init(_ pattern: Pattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        self.init(abstractPattern: pattern, count: count, consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init(_ pattern: Pattern<Element>, count: CountableClosedRange<Int>?, consumption: Consumption = .greedy) {
        self.init(abstractPattern: pattern, count: RepetitionPattern.convert(count), consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init(_ pattern: LiteralPattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        self.init(abstractPattern: pattern, count: count, consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init(_ pattern: LiteralPattern<Element>, count: CountableClosedRange<Int>?, consumption: Consumption = .greedy) {
        self.init(abstractPattern: pattern, count: RepetitionPattern.convert(count), consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init(_ pattern: CompositePattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        self.init(abstractPattern: pattern, count: count, consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init(_ pattern: CompositePattern<Element>, count: CountableClosedRange<Int>?, consumption: Consumption = .greedy) {
        self.init(abstractPattern: pattern, count: RepetitionPattern.convert(count), consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init<C : SearchableCollection>(_ pattern: C, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) where C.Element == Element {
        self.init(abstractPattern: LiteralPattern(pattern), count: count, consumption: consumption)
    }

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public convenience init<C : SearchableCollection>(_ pattern: C, count: CountableClosedRange<Int>?, consumption: Consumption = .greedy) where C.Element == Element {
        self.init(abstractPattern: LiteralPattern(pattern), count: RepetitionPattern.convert(count), consumption: consumption)
    }

    // MARK: - Properties

    @usableFromInline internal var pattern: Pattern<Element>
    @usableFromInline internal var count: CountableRange<Int>
    @usableFromInline internal var consumption: Consumption

    // MARK: - Pattern

    @inlinable internal func checkNext<C : SearchableCollection>(in collection: C, at locations: inout [C.Index])  where C.Element == Element {
        locations = Array(locations.map({ (location: C.Index) -> [Range<C.Index>] in
            if location ≠ collection.endIndex {
                return pattern.matches(in: collection, at: location)
            } else {
                return []
            }
        }).joined().map({ $0.upperBound }))
    }

    // #documentation(SDGCornerstone.Pattern.match(in:at:))
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

        var locations: [C.Index] = [location]

        for _ in 0 ..< count.lowerBound {
            if locations.isEmpty {
                // Finished (not a complete match yet)
                return []
            } else {
                // Continue
                checkNext(in: collection, at: &locations)
            }
        }

        var valid: [[C.Index]] = []
        func cleanUp() -> [Range<C.Index>] {
            switch consumption {
            case .greedy:
                valid.reverse()
            case .lazy:
                break
            }
            return valid.joined().map { location ..< $0 }
        }

        for _ in count {
            if locations.isEmpty {
                // Finished (nothing longer)
                return cleanUp()
            } else {
                // Continue
                valid.append(locations)
                checkNext(in: collection, at: &locations)
            }
        }

        // Finished (hit cap)
        return cleanUp()
    }

    // #documentation(SDGCornerstone.Pattern.primaryMatch(in:at:))
    /// Returns the primary match beginning at the specified index in the collection.
    ///
    /// This may be optimized, but the result must be the same as `matches(in: collection at: location).first`.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

        switch consumption {
        case .greedy:
            return matches(in: collection, at: location).first
        case .lazy:

            var locations: [C.Index] = [location]

            for _ in 0 ..< count.lowerBound {
                if locations.isEmpty {
                    // Finished (not a complete match yet)
                    return nil
                } else {
                    // Continue
                    checkNext(in: collection, at: &locations)
                }
            }

            if let matchEnd = locations.first {
                return location ..< matchEnd
            } else {
                return nil
            }
        }
    }

    // #documentation(SDGCornerstone.Pattern.reverse())
    /// A pattern that checks for the reverse pattern.
    ///
    /// This is suitable for performing backward searches by applying it to the reversed collection.
    @inlinable public override func reversed() -> RepetitionPattern<Element> {
        return RepetitionPattern(pattern.reversed(), count: count, consumption: consumption)
    }
}
