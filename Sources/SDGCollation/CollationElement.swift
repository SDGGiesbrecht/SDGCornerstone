/*
 CollationElement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

internal struct CollationElement : Decodable, Encodable, Equatable {

    // MARK: - Initialization

    private init(indices: [[Int]]) {
        self.indices = indices
    }

    // MARK: - Properties

    private var indices: [[Int]]

    // MARK: - Encodable

    internal func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: indices)
    }

    // MARK: - Decodable

    internal init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: [[Int]].self) { CollationElement(indices: $0) }
    }
}

/*
#warning("Needs converting.")
internal struct CollationElement: Archivable, EqualityOperators, JSONConvertible {

    // MARK: - Initialization

    private static func relative(index: Int, forLevel targetLevel: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {

        var circumFix: (prefix: [[Int]], suffix: [[Int]]) = ([], [])
        for level in CollationLevel.all {
            if level < targetLevel {
                circumFix.prefix.append([])
                circumFix.suffix.append([])
            } else {
                if level.isInReverse {
                    circumFix.prefix.append([index])
                    circumFix.suffix.append([])
                } else {
                    circumFix.prefix.append([])
                    circumFix.suffix.append([index])
                }
            }
        }
        return (CollationElement(rawIndices: circumFix.prefix), CollationElement(rawIndices: circumFix.suffix))
    }

    internal static func beforeForLevel(level: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        return relative(CollationOrder.BeforeIndex, forLevel: level)
    }

    internal static func afterForLevel(level: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        return relative(CollationOrder.AfterIndex, forLevel: level)
    }

    internal init(rawIndices: [[Int]]) {
        assert(rawIndices.count == CollationLevel.all.count)
        indices = rawIndices
    }

    // MARK: - Usage

    internal func indicesForLevel(level: CollationLevel) -> [Int] {
        return indices[level.rawValue]
    }
 */
