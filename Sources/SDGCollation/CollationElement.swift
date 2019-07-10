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

    // MARK: - Constructors

    private static func relative(index: Int, at targetLevel: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {

        var circumfix: (prefix: [[Int]], suffix: [[Int]]) = ([], [])
        for level in CollationLevel.allCases {
            if level < targetLevel {
                circumfix.prefix.append([])
                circumfix.suffix.append([])
            } else {
                if level.isInReverse {
                    circumfix.prefix.append([index])
                    circumfix.suffix.append([])
                } else {
                    circumfix.prefix.append([])
                    circumfix.suffix.append([index])
                }
            }
        }
        return (CollationElement(rawIndices: circumfix.prefix), CollationElement(rawIndices: circumfix.suffix))
    }

    internal static func before(for level: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        #warning("Missing information.")
        return relative(index: /* CollationOrder.beforeIndex */ 0, at: level)
    }

    internal static func after(for level: CollationLevel) -> (prefix: CollationElement, suffix: CollationElement) {
        #warning("Missing information.")
        return relative(index: /* CollationOrder.afterIndex */ 0, at: level)
    }

    // MARK: - Initialization

    private init(rawIndices: [[Int]]) {
        self.indices = rawIndices
    }

    // MARK: - Properties

    private var indices: [[Int]]

    // MARK: - Usage

    internal func indices(for level: CollationLevel) -> [Int] {
        return indices[level.rawValue]
    }

    // MARK: - Encodable

    internal func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: indices)
    }

    // MARK: - Decodable

    internal init(from decoder: Decoder) throws {
        try self.init(from: decoder, via: [[Int]].self) { CollationElement(rawIndices: $0) }
    }
}
