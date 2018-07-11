/*
 OrderedEnumeration.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

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

extension OrderedEnumeration where RawValue == Int {
    // MARK: - where RawValue == Int

    @_inlineable @_versioned internal mutating func _increment() {
        guard let result = successor() else {
            _preconditionFailure({ [instance = self] (localization: _APILocalization) -> String in
                switch localization {
                case .englishCanada: // [_Exempt from Test Coverage_]
                    return "“\(instance)” has no successor."
                }
            })
        }
        self = result
    }
    // #documentation(SDGCornerstone.OrderedEnumeration.increment())
    /// Increments to the next case.
    ///
    /// - Precondition: There is a valid next case.
    @_inlineable public mutating func increment() {
        _increment()
    }

    @_inlineable @_versioned internal func _successor() -> Self? {
        return Self(rawValue: rawValue.successor())
    }
    // #documentation(SDGCornerstone.OrderedEnumeration.successor())
    /// Returns the next case or `nil` if there are no later cases.
    @_inlineable public func successor() -> Self? {
        return _successor()
    }

    @_inlineable @_versioned internal mutating func _decrement() {
        guard let result = predecessor() else {
            _preconditionFailure({ [instance = self] (localization: _APILocalization) -> String in
                switch localization {
                case .englishCanada: // [_Exempt from Test Coverage_]
                    return "“\(instance)” has no predecessor."
                }
            })
        }
        self = result
    }
    // #documentation(SDGCornerstone.OrderedEnumeration.decrement())
    /// Decrements to the previous case.
    ///
    /// - Precondition: There is a valid previous case.
    @_inlineable public mutating func decrement() {
        _decrement()
    }

    @_inlineable @_versioned internal func _predecessor() -> Self? {
        return Self(rawValue: rawValue.predecessor())
    }
    // #documentation(SDGCornerstone.OrderedEnumeration.predecessor())
    /// Returns the previous case or `nil` if there are no earlier cases.
    @_inlineable public func predecessor() -> Self? {
        return _predecessor()
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.incrementCyclically())
    /// Increments to the next case in the cycle.
    ///
    /// - Parameters:
    ///     - wrap: A closure that will be executed if the incrementation wraps around to the beginnig of the sequence.
    @_inlineable public mutating func incrementCyclically(_ wrap: () -> Void = {}) {
        if let next = successor() {
            self = next
        } else {
            wrap()
            self = Self.cases.first!
        }
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.cyclicSuccessor())
    /// Returns the next case, wrapping around to the first case if necessary.
    @_inlineable public func cyclicSuccessor() -> Self {
        return nonmutatingVariant(of: Self.incrementCyclically, on: self, with: {})
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.decrementCyclically())
    /// Decrements to the previous case in the cycle.
    ///
    /// - Parameters:
    ///     - wrap: A closure that will be executed if the decrementation wraps around to the end of the sequence.
    @_inlineable public mutating func decrementCyclically(_ wrap: () -> Void = {}) {
        if let previous = predecessor() {
            self = previous
        } else {
            wrap()
            self = Self.cases.last!
        }
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.cyclicPredecessor())
    /// Returns the previous case, wrapping around to the last case if necessary.
    @_inlineable public func cyclicPredecessor() -> Self {
        return nonmutatingVariant(of: Self.decrementCyclically, on: self, with: {})
    }

    // MARK: - Comparable

    // #documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue < followingValue.rawValue
    }
}

// Disambiguate Strideable vs OrderedEnumeration for calendar components.
extension OrderedEnumeration where Self : Strideable, Self.RawValue == Int {
    // MARK: - where Self : Strideable, Self.RawValue == Int

    // MARK: - Comparable

    // #documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @_inlineable public static func < (precedingValue: Self, followingValue: Self) -> Bool {
        return precedingValue.rawValue < followingValue.rawValue
    }
}

// Disambiguate OneDimensionalPoint vs OrderedEnumeration for calendar components.
extension OrderedEnumeration where Self : OneDimensionalPoint, Self.Vector : IntegerProtocol, RawValue == Int {
    // MARK: - where Self : OneDimensionalPoint, Self.Vector : IntegerProtocol

    // #documentation(SDGCornerstone.OrderedEnumeration.increment())
    /// Increments to the next case.
    ///
    /// - Precondition: There is a valid next case.
    @_inlineable public mutating func increment() {
        _increment()
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.successor())
    /// Returns the next case or `nil` if there are no later cases.
    @_inlineable public func successor() -> Self? {
        return _successor()
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.decrement())
    /// Decrements to the previous case.
    ///
    /// - Precondition: There is a valid previous case.
    @_inlineable public mutating func decrement() {
        _decrement()
    }

    // #documentation(SDGCornerstone.OrderedEnumeration.predecessor())
    /// Returns the previous case or `nil` if there are no earlier cases.
    @_inlineable public func predecessor() -> Self? {
        return _predecessor()
    }
}
