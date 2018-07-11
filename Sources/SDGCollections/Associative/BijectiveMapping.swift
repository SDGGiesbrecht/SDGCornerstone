/*
 BijectiveMapping.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A reversible one‐to‐one mapping.
public struct BijectiveMapping<X : Hashable, Y : Hashable> : Collection, ExpressibleByDictionaryLiteral, TransparentWrapper {

    // MARK: - Properties

    @_versioned internal let xToY: [X: Y]
    @_versioned internal let yToX: [Y: X]

    // MARK: - Initialization

    /// Creates a bijective mapping from the mapping in one direction.
    ///
    /// - Parameters:
    ///     - mapping: The mapping.
    @_inlineable public init(_ mapping: [X: Y]) {

        xToY = mapping

        var reverse = [Y: X]()
        for (x, y) in mapping {
            _assert(reverse[y] == nil, { (localization: _APILocalization) -> String in
                switch localization { // [_Exempt from Test Coverage_]
                case .englishCanada:
                    return "This mapping is not bijective; it is multivalued. (\(y) ⇄ {\(reverse[y]!), \(x)})"
                }
            })
            reverse[y] = x
        }
        yToX = reverse
    }

    // MARK: - Look‐Up

    /// Returns the corresponding `Y` for a particular `X`.
    @_inlineable public func y(for x: X) -> Y? {
        return xToY[x]
    }
    /// Returns the corresponding `X` for a particular `Y`.
    @_inlineable public func x(for y: Y) -> X? {
        return yToX[y]
    }

    /// Accesses the corresponding `Y` for a particular `X`.
    @_inlineable public subscript(x: X) -> Y? {
        return xToY[x]
    }

    /// Accesses the corresponding `X` for a particular `Y`.
    @_inlineable public subscript(y: Y) -> X? {
        return yToX[y]
    }

    // MARK: - Collection

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    @_inlineable public var startIndex: Dictionary<X, Y>.Index {
        return xToY.startIndex
    }

    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    @_inlineable public var endIndex: Dictionary<X, Y>.Index {
        return xToY.endIndex
    }

    // #documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @_inlineable public func index(after i: Dictionary<X, Y>.Index) -> Dictionary<X, Y>.Index {
        return xToY.index(after: i)
    }

    // #documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.
    @_inlineable public subscript(position: Dictionary<X, Y>.Index) -> (X, Y) {
        return xToY[position]
    }

    // MARK: - ExpressibleByDictionaryLiteral

    // #documentation(SDGCornerstone.ExpressibleByDictionaryLiteral.init(dictionaryLiteral:))
    /// Creates an instance from a dictionary literal.
    @_inlineable public init(dictionaryLiteral elements: (X, Y)...) {
        self.init(Dictionary(uniqueKeysWithValues: elements))
    }

    // MARK: - TransparentWrapper

    // #documentation(SDGCornerstone.TransparentWrapper.wrapped)
    /// The wrapped instance.
    @_inlineable public var wrappedInstance: Any {
        return xToY
    }
}
