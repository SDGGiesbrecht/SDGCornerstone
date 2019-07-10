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

}
