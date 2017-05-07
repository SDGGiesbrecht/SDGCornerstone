/*
 Repetition.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A pattern that matches against repetitions of another pattern.
public final class Repetition<Element : Equatable> : Pattern<Element> {

    // MARK: - Initialization

    private init(ofAbstractPattern pattern: Pattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        assert(count == nil ∨ count!.lowerBound.isNonNegative, "Cannot check for a negative number of instances of a pattern. Requested count: \(count!).")

        self.pattern = pattern
        self.count = count ?? 0 ..< Int.max
        self.consumption = consumption
    }

    // [_Define Documentation: SDGCornerstone.Repetition.init(of:count:consumption)_]
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    public convenience init(of pattern: Pattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        self.init(ofAbstractPattern: pattern, count: count, consumption: consumption)
    }

    // [_Inherit Documentation: SDGCornerstone.Repetition.init(of:count:consumption)_]
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    public convenience init(of pattern: Literal<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        self.init(ofAbstractPattern: pattern, count: count, consumption: consumption)
    }

    // [_Inherit Documentation: SDGCornerstone.Repetition.init(of:count:consumption)_]
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    public convenience init(of pattern: CompositePattern<Element>, count: CountableRange<Int>? = nil, consumption: Consumption = .greedy) {
        self.init(ofAbstractPattern: pattern, count: count, consumption: consumption)
    }

    // MARK: - Properties

    private var pattern: Pattern<Element>
    private var count: CountableRange<Int>
    private var consumption: Consumption

    // MARK: - Pattern

    // [_Inherit Documentation: SDGCornerstone.Pattern.match(in:at:)_]
    /// Returns the ranges of possible matches beginning at the specified index in the collection.
    ///
    /// The ranges are sorted in order of preference. Ranges can be tried one after another down through the list in the event that some should be disqualified for some external reason, such as being part of a larger composite pattern.
    ///
    /// - Parameters:
    ///     - collection: The collection in which to search.
    ///     - location: The index at which to check for the beginning of a match.
    public override func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Iterator.Element == Element {

        var locations: [C.Index] = [location]
        func checkNext() {
            locations = Array(locations.map({ pattern.matches(in: collection, at: $0) }).joined().map({ $0.upperBound }))
        }

        for _ in 0 ..< count.lowerBound {
            if locations.isEmpty {
                // Finished (not a complete match yet)
                return []
            } else {
                // Continue
                checkNext()
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
            return valid.joined().map() { location ..< $0 }
        }

        for _ in count {
            if locations.isEmpty {
                // Finished (nothing longer)
                return cleanUp()
            } else {
                // Continue
                valid.append(locations)
                checkNext()
            }
        }

        // Finished (hit cap)
        return cleanUp()
    }
}
