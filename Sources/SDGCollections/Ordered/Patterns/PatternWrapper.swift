/*
 PatternWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Not permanent.")
public final class PatternWrapper<Element> : Pattern<Element> where Element : Equatable {

    // MARK: - Initialization

    public init<P>(_ pattern: P) where P : PatternProtocol, P.Element == Element {
        matches = { pattern.matches(in: $0, at: $1) }
        primaryMatch = { pattern.primaryMatch(in: $0, at: $1) }
        reversedPattern = Pattern<Element>()
        super.init()
        reversedPattern = PatternWrapper(pattern.reversed(), reversed: self)
    }

    public init<P>(_ pattern: P, reversed: Pattern<Element>) where P : PatternProtocol, P.Element == Element {
        matches = { pattern.matches(in: $0, at: $1) }
        primaryMatch = { pattern.primaryMatch(in: $0, at: $1) }
        reversedPattern = reversed
    }

    // MARK: - Properties

    @usableFromInline internal let matches: ([Element], Int) -> [Range<Int>]
    @usableFromInline internal let primaryMatch: ([Element], Int) -> Range<Int>?
    @usableFromInline internal var reversedPattern: Pattern<Element>

    // MARK: - Pattern

    @inlinable public override func matches<C : SearchableCollection>(in collection: C, at location: C.Index) -> [Range<C.Index>] where C.Element == Element {
        let array = Array(collection)
        let offset = collection.distance(from: collection.startIndex, to: location)
        let result = matches(array, offset)
        return result.map { $0.map({ collection.index(collection.startIndex, offsetBy: $0) }) }
    }

    @inlinable public override func primaryMatch<C : SearchableCollection>(in collection: C, at location: C.Index) -> Range<C.Index>? where C.Element == Element {
        let array = Array(collection)
        let offset = collection.distance(from: collection.startIndex, to: location)
        let result = primaryMatch(array, offset)
        return result.map { $0.map({ collection.index(collection.startIndex, offsetBy: $0) }) }
    }

    @inlinable public override func reversed() -> Pattern<Element> {
        return reversedPattern
    }
}
