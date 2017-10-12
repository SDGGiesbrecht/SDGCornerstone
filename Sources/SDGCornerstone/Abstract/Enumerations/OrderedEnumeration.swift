/*
 OrderedEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An enumeration whose cases have a defined order.
///
/// Conformance Requirements:
///
/// - `IterableEnumeration`
public protocol OrderedEnumeration : Comparable, IterableEnumeration {

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.increment()_]
    /// Increments to the next case.
    ///
    /// - Precondition: There is a valid next case.
    mutating func increment()

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.successor()_]
    /// Returns the next case or `nil` if there are no later cases.
    func successor() -> Self?

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.decrement()_]
    /// Decrements to the previous case.
    ///
    /// - Precondition: There is a valid previous case.
    mutating func decrement()

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.predecessor()_]
    /// Returns the previous case or `nil` if there are no earlier cases.
    func predecessor() -> Self?

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.incrementCyclically()_]
    /// Increments to the next case in the cycle.
    ///
    /// - Parameters:
    ///     - wrap: A closure that will be executed if the incrementation wraps around to the beginnig of the sequence.
    mutating func incrementCyclically(_ wrap: () -> Void)

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.cyclicSuccessor()_]
    /// Returns the next case, wrapping around to the first case if necessary.
    func cyclicSuccessor() -> Self

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.decrementCyclically()_]
    /// Decrements to the previous case in the cycle.
    ///
    /// - Parameters:
    ///     - wrap: A closure that will be executed if the decrementation wraps around to the end of the sequence.
    mutating func decrementCyclically(_ wrap: () -> Void)

    // [_Define Documentation: SDGCornerstone.OrderedEnumeration.cyclicPredecessor()_]
    /// Returns the previous case, wrapping around to the last case if necessary.
    func cyclicPredecessor() -> Self
}

extension OrderedEnumeration {

    fileprivate mutating func incrementAsOrderedEnumeration() {
        guard let result = successor() else {
            preconditionFailure(UserFacingText({ [instance = self] (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada: // [_Exempt from Code Coverage_]
                    return StrictString("\(instance) has no successor.")
                }
            }))
        }
        self = result
    }
    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.increment()_]
    /// Increments to the next case.
    ///
    /// - Precondition: There is a valid next case.
    public mutating func increment() {
        incrementAsOrderedEnumeration()
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.successor()_]
    /// Returns the next case or `nil` if there are no later cases.
    public func successor() -> Self? {
        return successorAsIterableEnumeration()
    }

    fileprivate mutating func decrementAsOrderedEnumeration() {
        guard let result = predecessor() else {
            preconditionFailure(UserFacingText({ [instance = self] (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada: // [_Exempt from Code Coverage_]
                    return StrictString("\(instance) has no predecessor.")
                }
            }))
        }
        self = result
    }
    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.decrement()_]
    /// Decrements to the previous case.
    ///
    /// - Precondition: There is a valid previous case.
    public mutating func decrement() {
        decrementAsOrderedEnumeration()
    }

    fileprivate func predecessorAsOrderedEnumeration() -> Self? {
        return Self(rawValue: rawValue.predecessor())
    }
    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.predecessor()_]
    /// Returns the previous case or `nil` if there are no earlier cases.
    public func predecessor() -> Self? {
        return predecessorAsOrderedEnumeration()
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.incrementCyclically()_]
    /// Increments to the next case in the cycle.
    ///
    /// - Parameters:
    ///     - wrap: A closure that will be executed if the incrementation wraps around to the beginnig of the sequence.
    public mutating func incrementCyclically(_ wrap: () -> Void = {}) {
        if let next = successor() {
            self = next
        } else {
            wrap()
            self = Self.first
        }
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.cyclicSuccessor()_]
    /// Returns the next case, wrapping around to the first case if necessary.
    public func cyclicSuccessor() -> Self {
        var result = self
        result.incrementCyclically()
        return result
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.decrementCyclically()_]
    /// Decrements to the previous case in the cycle.
    ///
    /// - Parameters:
    ///     - wrap: A closure that will be executed if the decrementation wraps around to the end of the sequence.
    public mutating func decrementCyclically(_ wrap: () -> Void = {}) {
        if let previous = predecessor() {
            self = previous
        } else {
            wrap()
            self = Self.last
        }
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.cyclicPredecessor()_]
    /// Returns the previous case, wrapping around to the last case if necessary.
    public func cyclicPredecessor() -> Self {
        var result = self
        result.decrementCyclically()
        return result
    }
}

// Disambiguate OneDimensionalPoint vs OrderedEnumeration for calendar components.
extension OrderedEnumeration where Self : OneDimensionalPoint, Self.Vector : IntegerProtocol {
    // MARK: - where where Self : OneDimensionalPoint, Self.Vector : IntegerProtocol

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.increment()_]
    /// Increments to the next case.
    ///
    /// - Precondition: There is a valid next case.
    public mutating func increment() {
        incrementAsOrderedEnumeration()
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.successor()_]
    /// Returns the next case or `nil` if there are no later cases.
    public func successor() -> Self? {
        return successorAsIterableEnumeration()
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.decrement()_]
    /// Decrements to the previous case.
    ///
    /// - Precondition: There is a valid previous case.
    public mutating func decrement() {
        decrementAsOrderedEnumeration()
    }

    // [_Inherit Documentation: SDGCornerstone.OrderedEnumeration.predecessor()_]
    /// Returns the previous case or `nil` if there are no earlier cases.
    public func predecessor() -> Self? {
        return predecessorAsOrderedEnumeration()
    }
}
