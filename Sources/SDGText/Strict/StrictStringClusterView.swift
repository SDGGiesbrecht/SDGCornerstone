/*
 StrictStringClusterView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension StrictString {

    // #documentation(SDGCornerstone.StringFamily.ClusterView)
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    public struct ClusterView : BidirectionalCollection, Collection, ExtendedGraphemeClusterView, RangeReplaceableCollection, TransparentWrapper {

        // MARK: - Initialization

        @_inlineable @_versioned internal init(_ string: StrictString) {
            self.string = string
        }

        // MARK: - Properties

        @_versioned internal var string: StrictString

        // MARK: - Normalization

        @_inlineable @_versioned internal static func normalize(_ string: String) -> StrictString.ClusterView {
            return StrictString(string).clusters
        }

        @_inlineable @_versioned internal static func normalize<S : Sequence>(_ sequence: S) -> StrictString.ClusterView where S.Element == ExtendedGraphemeCluster {
            switch sequence {

            // Already normalized.
            case let strict as StrictString.ClusterView :
                return strict
            case let strictSlice as Slice<StrictString.ClusterView> :
                return StrictString(unsafeString: String(strictSlice.base.string.clusters[strictSlice.bounds])).clusters

            // Need normalization.
            case let nonStrictClusters as String.ClusterView :
                return normalize(nonStrictClusters)
            default:
                return normalize(String.ClusterView(sequence))
            }
        }

        // MARK: - BidirectionalCollection

        // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
        /// Returns the index immediately before the specified index.
        ///
        /// - Parameters:
        ///     - i: The following index.
        @_inlineable public func index(before i: String.ClusterView.Index) -> String.ClusterView.Index {
            return string.string.clusters.index(before: i)
        }

        // MARK: - Collection

        // #documentation(SDGCornerstone.Collection.startIndex)
        /// The position of the first element in a non‐empty collection.
        @_inlineable public var startIndex: String.ClusterView.Index {
            return string.string.clusters.startIndex
        }

        // #documentation(SDGCornerstone.Collection.endIndex)
        /// The position following the last valid index.
        @_inlineable public var endIndex: String.ClusterView.Index {
            return string.string.clusters.endIndex
        }

        // #documentation(SDGCornerstone.Collection.index(after:))
        /// Returns the index immediately after the specified index.
        ///
        /// - Parameters:
        ///     - i: The preceding index.
        @_inlineable public func index(after i: String.ClusterView.Index) -> String.ClusterView.Index {
            return string.string.clusters.index(after: i)
        }

        // #documentation(SDGCornerstone.Collection.subscript(position:))
        /// Accesses the element at the specified position.
        @_inlineable public subscript(position: String.ClusterView.Index) -> ExtendedGraphemeCluster {
            return string.string.clusters[position]
        }

        // MARK: - RangeReplaceableCollection

        // #documentation(SDGCornerstone.RangeReplaceableCollection.init())
        /// Creates a new, empty collection.
        @_inlineable public init() {
            string = StrictString()
        }

        // #documentation(SDGCornerstone.RangeReplaceableCollection.init(_:))
        /// Creates a new instance of a collection containing the elements of a sequence.
        @_inlineable public init<S : Sequence>(_ elements: S) where S.Element == Element {
            self = ClusterView.normalize(elements)
        }

        // #documentation(SDGCornerstone.RangeReplaceableCollection.append(contentsOf:))
        /// Appends the contents of the sequence to the end of the collection.
        @_inlineable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == ExtendedGraphemeCluster {
            self = (StrictString(self) + StrictString(ClusterView.normalize(newElements))).clusters
        }

        // #documentation(SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:))
        /// Inserts the contents of the sequence to the specified index.
        @_inlineable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ClusterView.Index) where S.Element == ExtendedGraphemeCluster {
            replaceSubrange(i ..< i, with: newElements)
        }

        // #documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
        /// Replaces the specified subrange of elements with the given collection.
        @_inlineable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ClusterView.Index>, with newElements: S) where S.Element == ExtendedGraphemeCluster {

            let preceding = StrictString(ClusterView(self[startIndex ..< subrange.lowerBound]))
            let succeeding = StrictString(ClusterView(self[subrange.upperBound...]))
            let replacement = StrictString(ClusterView.normalize(newElements))

            self = (preceding + replacement + succeeding).clusters
        }

        // MARK: - TransparentWrapper

        // #documentation(SDGCornerstone.TransparentWrapper.wrapped)
        /// The wrapped instance.
        public var wrappedInstance: Any {
            return string
        }
    }
}
