/*
 CollationOrder.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCollections
import SDGText

/// A collation order for sorting strings.
public struct CollationOrder {

    // MARK: - Static Properties

    private static let fallbackAlgorithm: (StrictString.Element) -> [CollationElement] = { _ in
        #warning("Include in coding?")
        #warning("Not implemented yet.")
        fatalError()
    }

    /// The root collation order.
    public static let root: CollationOrder = {
        #warning("Not implemented yet.")
        fatalError()
        /*return CollationResource(resource: "RootCollation", fileExtension: nil, bundle: SDGCollationBundle).collationOrder*/
    }()

    // MARK: - Initialization

    private init(rules: [StrictString: [CollationElement]]) {
        self.rules = rules
    }

    // MARK: - Properties

    private var rules: [StrictString: [CollationElement]] {
        didSet {
            cache = Cache()
        }
    }

    private class Cache {
        fileprivate init() {}
        fileprivate var contextualMapping: ContextualMapping<StrictString, [CollationElement]>?
    }
    private var cache = Cache()

    private var contextualMapping: ContextualMapping<StrictString, [CollationElement]> {
        return cached(in: &cache.contextualMapping) {
            return ContextualMapping(mapping: rules, fallbackAlgorithm: CollationOrder.fallbackAlgorithm)
        }
    }

    // MARK: - Usage

    private func collationIndices(for string: StrictString) -> [Int] {
        let elements = contextualMapping.map(string)

        var indices = [Int]()
        for level in CollationLevel.allCases {
            if level.isInReverse {
                for element in elements.reversed() {
                    indices += element.indices(for: level).reversed()
                }
            } else {
                for element in elements {
                    indices += element.indices(for: level)
                }
            }
            #warning("Not available yet.")
            //indices += CollationOrder.endOfStringIndex
        }

        return indices
    }

    @inlinable internal func indenticalIndices<S>(for string: S) -> [Int] where S : Collection, S.Element == Unicode.Scalar {
        var indices = [Int]()
        for character in string {
            indices.append(Int(character.value))
        }
        return indices
    }

    /// Returns the collation indices for a particular string.
    public func indices<S>(for string: S) -> [Int] where S : StringFamily {
        let strict: StrictString
        if let already = string as? StrictString {
            strict = already
        } else {
            strict = StrictString(string.scalars)
        }
        var indices = collationIndices(for: strict)
        indices.append(contentsOf: indenticalIndices(for: string.scalars))
        return indices
    }
}
