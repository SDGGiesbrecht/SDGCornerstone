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
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText

/// A collation order for sorting strings.
public struct CollationOrder {

    // MARK: - Static Properties

    #warning("Are these up to date?")
    private static let beforeIndex: Int = 0
    private static let endOfStringIndex: Int = beforeIndex.successor()
    private static let offsetFromDUCET: Int = endOfStringIndex − beforeIndex

    private static let placeholderIndex: Int = endOfStringIndex.successor()

    private static let ducetDefaultAccent: Int = 0x20
    private static let defaultAccent: Int = ducetDefaultAccent + offsetFromDUCET
    private static let ducetDefaultCase: Int = 0x2
    private static let defaultCase: Int = ducetDefaultCase + offsetFromDUCET

    private static let ducetMaxIndex: Int = 65533
    private static let unifiedIdeographs: Int = ducetMaxIndex.successor() + offsetFromDUCET
    private static let otherUnifiedIdeographs: Int = unifiedIdeographs.successor()
    private static let unassignedCodePoints: Int = otherUnifiedIdeographs.successor()
    private static let finalIndex: Int = unassignedCodePoints.successor()
    private static let afterIndex: Int = finalIndex.successor()

    private static func elements(for category: Int, codepoint: Int) -> [CollationElement] {
        return [CollationElement(rawIndices: [
            [category, codepoint],
            [CollationOrder.placeholderIndex],
            [CollationOrder.defaultAccent],
            [CollationOrder.defaultCase],
            [category, codepoint],
            [CollationOrder.placeholderIndex],
            ])]
    }

    private static let fallbackAlgorithm: (StrictString.Element) -> [CollationElement] = { character in
        #warning("Include in coding?")

        let codepoint = Int(character.value)

        // Ideographs, Compatibility
        if (0x4E00 ... 0x9FFF).contains(codepoint) ∨ (0xF900 ... 0xFAFF).contains(codepoint) {
            // Ideographs, Compatibility
            return elements(for: unifiedIdeographs, codepoint: codepoint)
        } else if (0x3400 ... 0x4DBF).contains(codepoint) ∨ (0x20000 ... 0x2A6DF).contains(codepoint) ∨ (0x2A700 ... 0x2B73F).contains(codepoint) ∨ (0x2B740 ... 0x2B81F).contains(codepoint) ∨ (0x2B820 ... 0x2CEAF).contains(codepoint) {
            // Extensions A, B, C, D, E
            return elements(for: otherUnifiedIdeographs, codepoint: codepoint)
        } else {
            return elements(for: unassignedCodePoints, codepoint: codepoint)
        }
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

    @usableFromInline internal func collationIndices(for string: StrictString) -> [Int] {
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
    @inlinable public func indices<S>(for string: S) -> [Int] where S : StringFamily {
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

    /// Returns whether or not the strings are sorted in ascending order.
    @inlinable public func stringsAreSortedAscending<S>(
        _ preceding: S,
        _ following: S) -> Bool where S : StringFamily {
        return indices(for: preceding).lexicographicallyPrecedes(indices(for: following))
    }

    /// Returns whether or not the strings are sorted equal.
    @inlinable public func stringsAreSortedEqual<S>(
        _ preceding: S,
        _ following: S) -> Bool where S : StringFamily {
        return indices(for: preceding).elementsEqual(indices(for: following))
    }

    /// Sorts an array of strings.
    @inlinable public func collate<C, S>(strings: C) -> [S] where C : Sequence, S : StringFamily, C.Element == S {
        var cache: [CollationCacheEntry<S>] = strings.map { string in
            return CollationCacheEntry(string: string, indices: self.indices(for: string))
        }
        cache.sort() { $0.indices.lexicographicallyPrecedes($1.indices) }
        return cache.map { $0.string }
    }
}
