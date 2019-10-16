/*
 Pattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

#warning("Remove.")
/// A pattern that can be searched for in collections with equatable elements.
///
/// Required Overrides for Subclasses:
///
/// - `func matches<C : Collection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element`
/// - `func reversed() -> Pattern<Element>`
open class Pattern<Element : Equatable> : PatternProtocol {

    /// This initializer does nothing. It only exists so that subclasses have an available parent initializer they can forward to in order to satisfy the compiler.
    @inlinable public init() {}

    @inlinable open func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        _primitiveMethod()
    }

    @inlinable open func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        return matches(in: collection, at: location).first
    }

    @inlinable open func reversed() -> Pattern<Element> {
        _primitiveMethod()
    }
}
