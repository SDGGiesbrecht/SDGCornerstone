/*
 StrictStringClusterView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension StrictString {

    // [_Inherit Documentation: SDGCornerstone.StringFamily.ClusterView_]
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    public struct ClusterView : BidirectionalCollection, Collection, ExtendedGraphemeClusterView, RangeReplaceableCollection {

        // MARK: - Initialization

        internal init(_ string: StrictString) {
            self.string = string
        }

        // MARK: - Properties

        @_versioned internal var string: StrictString

        // MARK: - Normalization

        @_versioned internal static func normalize(_ string: String) -> StrictString.ClusterView {
            return StrictString(string).clusters
        }

        @_inlineable @_versioned internal static func normalize<S : Sequence>(_ sequence: S) -> StrictString.ClusterView where S.Element == ExtendedGraphemeCluster {
            switch sequence {

            // Already normalized.
            case let strict as StrictString.ClusterView :
                return strict
            case let strictSlice as RangeReplaceableBidirectionalSlice<StrictString.ClusterView> :
                return StrictString(unsafeString: String(strictSlice.base.string.clusters[strictSlice.startIndex ..< strictSlice.endIndex])).clusters

            // Need normalization.
            case let nonStrictClusters as String.ClusterView :
                return normalize(nonStrictClusters)
            default:
                return normalize(String.ClusterView(sequence))
            }
        }

        // MARK: - BidirectionalCollection

        // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
        /// Returns the index immediately before the specified index.
        ///
        /// - Parameters:
        ///     - i: The following index.
        public func index(before i: String.ClusterView.Index) -> String.ClusterView.Index {
            return string.string.clusters.index(before: i)
        }

        // MARK: - Collection

        // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
        /// The position of the first element in a non‐empty collection.
        public var startIndex: String.ClusterView.Index {
            return string.string.clusters.startIndex
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
        /// The position following the last valid index.
        public var endIndex: String.ClusterView.Index {
            return string.string.clusters.endIndex
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
        /// Returns the index immediately after the specified index.
        ///
        /// - Parameters:
        ///     - i: The preceding index.
        public func index(after i: String.ClusterView.Index) -> String.ClusterView.Index {
            return string.string.clusters.index(after: i)
        }

        // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
        /// Accesses the element at the specified position.
        public subscript(position: String.ClusterView.Index) -> ExtendedGraphemeCluster {
            return string.string.clusters[position]
        }

        // MARK: - RangeReplaceableCollection

        // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
        /// Creates a new, empty collection.
        public init() {
            string = StrictString()
        }

        // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init(_:)_]
        /// Creates a new instance of a collection containing the elements of a sequence.
        @_inlineable public init<S : Sequence>(_ elements: S) where S.Element == Element {
            self = ClusterView.normalize(elements)
        }

        // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
        /// Appends the contents of the sequence to the end of the collection.
        @_inlineable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == ExtendedGraphemeCluster {
            self = (StrictString(self) + StrictString(ClusterView.normalize(newElements))).clusters
        }

        // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
        /// Inserts the contents of the sequence to the specified index.
        @_inlineable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ClusterView.Index) where S.Element == ExtendedGraphemeCluster {
            replaceSubrange(i ..< i, with: newElements)
        }

        // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
        /// Replaces the specified subrange of elements with the given collection.
        @_inlineable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ClusterView.Index>, with newElements: S) where S.Element == ExtendedGraphemeCluster {

            let preceding = StrictString(ClusterView(self[startIndex ..< subrange.lowerBound]))
            let succeeding = StrictString(ClusterView(self[subrange.upperBound ..< endIndex]))
            let replacement = StrictString(ClusterView.normalize(newElements))

            self = (preceding + replacement + succeeding).clusters
        }
    }
}
