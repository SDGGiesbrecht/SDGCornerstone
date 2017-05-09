/*
 BijectiveMapping.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A reversible one‐to‐one mapping.
public struct BijectiveMapping<X : Hashable, Y : Hashable>: Collection, ExpressibleByDictionaryLiteral {

    // MARK: - Properties

    private let xToY: [X: Y]
    private let yToX: [Y: X]

    // MARK: - Initialization

    /// Creates a bijective mapping from the mapping in one direction.
    ///
    /// - Parameters:
    ///     - mapping: The mapping.
    public init(_ mapping: [X: Y]) {

        xToY = mapping

        var reverse = [Y: X]()
        for (x, y) in mapping {
            assert(reverse[y] == nil, "This mapping is not bijective! Repeated value: \(y)")
            reverse[y] = x
        }
        yToX = reverse
    }

    // MARK: - Look‐Up

    /// Returns the corresponding `Y` for a particular `X`.
    public func yForX(x: X) -> Y? {
        return xToY[x]
    }
    /// Returns the corresponding `X` for a particular `Y`.
    public func xForY(y: Y) -> X? {
        return yToX[y]
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    public var startIndex: Dictionary<X, Y>.Index {
        return xToY.startIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    public var endIndex: Dictionary<X, Y>.Index {
        return xToY.endIndex
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    public func index(after i: Dictionary<X, Y>.Index) -> Dictionary<X, Y>.Index {
        return xToY.index(after: i)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    public subscript(position: Dictionary<X, Y>.Index) -> (X, Y) {
        return xToY[position]
    }

    // MARK: - ExpressibleByDictionaryLiteral

    // [_Inherit Documentation: SDGCornerstone.ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)_]
    public init(dictionaryLiteral elements: (X, Y)...) {
        self.init(Dictionary(elements))
    }
}
