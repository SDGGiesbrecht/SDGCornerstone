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
import SDGLogic
import SDGMathematics

/// A pattern that matches against repetitions of another pattern.
public struct RepetitionPattern<Base> : PatternProtocol where Base : PatternProtocol {

    // MARK: - Initialization

    // @documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public init(
        _ pattern: Base,
        count: CountableRange<Int>? = nil,
        consumption: Consumption = .greedy) {
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

    // #documentation(SDGCornerstone.Repetition.init(of:count:consumption))
    /// Creates a repetition pattern from another pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern to repeat.
    ///     - count: A range representing the allowed number of repetitions.
    ///     - consumption: The desired consumption behaviour.
    @inlinable public init(
        _ pattern: Base,
        count: CountableClosedRange<Int>?,
        consumption: Consumption = .greedy) {
        let converted = count.map { $0.lowerBound ..< $0.upperBound + 1 }
        self.init(pattern, count: converted, consumption: consumption)
    }

    // MARK: - Properties

    @usableFromInline internal var pattern: Base
    @usableFromInline internal var count: CountableRange<Int>
    @usableFromInline internal var consumption: Consumption

    // MARK: - Pattern

    public typealias Element = Base.Element

    @inlinable internal func checkNext<C : SearchableCollection>(in collection: C, at locations: inout [C.Index])  where C.Element == Element {
        locations = Array(locations.map({ (location: C.Index) -> [Range<C.Index>] in
            if location ≠ collection.endIndex {
                return pattern.matches(in: collection, at: location)
            } else {
                return []
            }
        }).joined().map({ $0.upperBound }))
    }

    @inlinable public func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {

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

    @inlinable public func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {

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

    @inlinable public func reversed() -> RepetitionPattern<Base.Reversed> {
        return RepetitionPattern<Base.Reversed>(pattern.reversed(), count: count, consumption: consumption)
    }
}
