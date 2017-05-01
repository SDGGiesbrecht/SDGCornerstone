/*
 FiniteSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A set small enough to reasonably iterate over.
///
/// Conformance Requirements:
///     - `SetDefinition`
///     - `Collection`
///     - `Iterator.Element == Element`
public protocol FiniteSet : Collection, SetDefinition {

    /// :nodoc:
    static func toIteratorElement(_ element: Self.Element) -> Self.Iterator.Element

    /// :nodoc:
    static func toElement(_ iteratorElement: Self.Iterator.Element) -> Self.Element
}

extension FiniteSet where Iterator.Element == Element {
    // MARK: - where Iterator.Element == Element

    /// :nodoc:
    public static func toIteratorElement(_ element: Self.Element) -> Self.Iterator.Element {
        return element
    }

    /// :nodoc:
    public static func toElement(_ element: Self.Iterator.Element) -> Self.Element {
        return element
    }
}
