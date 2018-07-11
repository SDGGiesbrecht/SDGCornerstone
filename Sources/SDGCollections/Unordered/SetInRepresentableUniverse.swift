/*
 SetInRepresentableUniverse.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A set small enough to reasonably iterate over.
///
/// Conformance Requirements:
///
/// - `SetDefinition`
/// - `static var universe: Self { get }`
public protocol SetInRepresentableUniverse : MutableSet {

    // [_Define Documentation: SDGCornerstone.RepresentableUniverse.universe_]
    /// An instance containing all possible elements.
    static var universe: Self { get }

    // [_Define Documentation: SDGCornerstone.RepresentableUniverse.′_]
    // #documentation(SDGCornerstone.SetDefinition.′)
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    static postfix func ′(operand: Self) -> Self

    // [_Define Documentation: SDGCornerstone.RepresentableUniverse.′=_]
    /// Sets the operand to its absolute complement.
    ///
    /// - Parameters:
    ///     - operand: The set.
    static postfix func ′=(operand: inout Self)
}

extension SetInRepresentableUniverse {

    // #documentation(SDGCornerstone.RepresentableUniverse.′)
    /// Returns the absolute complement of the set.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @_inlineable public static postfix func ′(operand: Self) -> Self {
        return nonmutatingVariant(of: ′=, on: operand)
    }

    // #documentation(SDGCornerstone.RepresentableUniverse.′=)
    /// Sets the operand to its absolute complement.
    ///
    /// - Parameters:
    ///     - operand: The set.
    @_inlineable public static postfix func ′=(operand: inout Self) {
        operand = universe ∖ operand
    }
}
