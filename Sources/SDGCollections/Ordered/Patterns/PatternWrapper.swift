/*
 PatternWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

#warning("Not permanent.")
/*
public struct PatternWrapper<Element> : PatternProtocol, TransparentWrapper where Element : Equatable {

    // MARK: - Initialization

    @inlinable public init<P>(_ pattern: P) where P : PatternProtocol, P.Element == Element {
        matches = { pattern.matches(in: $0, at: $1) }
        primaryMatch = { pattern.primaryMatch(in: $0, at: $1) }
        wrappedInstance = pattern
        reversedPattern = { PatternWrapper(pattern.reversed()) }
    }

    // MARK: - Properties

    @usableFromInline internal let matches: ([Element], Int) -> [Range<Int>]
    @usableFromInline internal let primaryMatch: ([Element], Int) -> Range<Int>?
    @usableFromInline internal let reversedPattern: () -> PatternWrapper<Element>

    // MARK: - Pattern

    @inlinable public func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
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

    @inlinable public func reversed() -> PatternWrapper<Element> {
        return reversedPattern()
    }

    // MARK: - TransparentWrapper

    public let wrappedInstance: Any
}
*/
