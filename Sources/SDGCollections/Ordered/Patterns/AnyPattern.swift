/*
 AnyPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type‐erased pattern.
///
/// - Note: The indirection used by `AnyPattern` can negatively affect performance. While use of `AnyPattern` is sometimes necessitated by the type system, it is recommended to use other strategies when possible.
public struct AnyPattern<Element> : Pattern, TransparentWrapper where Element : Equatable {

    // MARK: - Initialization

    /// Creates a type erased instance of a pattern.
    ///
    /// - Parameters:
    ///     - pattern: The pattern.
    @inlinable public init<P>(_ pattern: P) where P : Pattern, P.Element == Element {
        matches = { pattern.matches(in: $0, at: $1) }
        primaryMatch = { pattern.primaryMatch(in: $0, at: $1) }
        wrappedInstance = pattern
        reversedPattern = { AnyPattern(pattern.reversed()) }
    }

    // MARK: - Properties

    @usableFromInline internal let matches: ([Element], Int) -> [Range<Int>]
    @usableFromInline internal let primaryMatch: ([Element], Int) -> Range<Int>?
    @usableFromInline internal let reversedPattern: () -> AnyPattern<Element>

    // MARK: - Pattern

    @inlinable public func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        #warning("Can this be made more efficient?")
        let array = Array(collection)
        let offset = collection.distance(from: collection.startIndex, to: location)
        let result = matches(array, offset)
        return result.map { $0.map({ collection.index(collection.startIndex, offsetBy: $0) }) }
    }

    @inlinable public func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        let array = Array(collection)
        let offset = collection.distance(from: collection.startIndex, to: location)
        let result = primaryMatch(array, offset)
        return result.map { $0.map({ collection.index(collection.startIndex, offsetBy: $0) }) }
    }

    @inlinable public func reversed() -> AnyPattern<Element> {
        return reversedPattern()
    }

    // MARK: - TransparentWrapper

    public let wrappedInstance: Any
}
