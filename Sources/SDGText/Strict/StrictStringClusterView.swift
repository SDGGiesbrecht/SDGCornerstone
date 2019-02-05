/*
 StrictStringClusterView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

        @inlinable internal init(_ string: StrictString) {
            self.string = string
        }

        // MARK: - Properties

        @usableFromInline internal var string: StrictString

        // MARK: - Normalization

        @inlinable internal static func normalize(_ string: String) -> StrictString.ClusterView {
            return StrictString(string).clusters
        }

        @inlinable internal static func normalize<S : Sequence>(_ sequence: S) -> StrictString.ClusterView where S.Element == ExtendedGraphemeCluster {
            switch sequence {

            // Already normalized.
            case let strict as StrictString.ClusterView:
                return strict
            case let strictSlice as Slice<StrictString.ClusterView>:
                return StrictString(unsafeString: String(strictSlice.base.string.clusters[strictSlice.bounds])).clusters

            // Need normalization.
            case let nonStrictClusters as String.ClusterView:
                return normalize(nonStrictClusters)
            default:
                return normalize(String.ClusterView(sequence))
            }
        }

        // MARK: - BidirectionalCollection

        @inlinable public func index(before i: String.ClusterView.Index) -> String.ClusterView.Index {
            return string.string.clusters.index(before: i)
        }

        // MARK: - Collection

        @inlinable public var startIndex: String.ClusterView.Index {
            return string.string.clusters.startIndex
        }

        @inlinable public var endIndex: String.ClusterView.Index {
            return string.string.clusters.endIndex
        }

        @inlinable public func index(after i: String.ClusterView.Index) -> String.ClusterView.Index {
            return string.string.clusters.index(after: i)
        }

        @inlinable public subscript(position: String.ClusterView.Index) -> ExtendedGraphemeCluster {
            return string.string.clusters[position]
        }

        // MARK: - RangeReplaceableCollection

        @inlinable public init() {
            string = StrictString()
        }

        @inlinable public init<S : Sequence>(_ elements: S) where S.Element == Element {
            self = ClusterView.normalize(elements)
        }

        @inlinable public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Element == ExtendedGraphemeCluster {
            self = (StrictString(self) + StrictString(ClusterView.normalize(newElements))).clusters
        }

        @inlinable public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: String.ClusterView.Index) where S.Element == ExtendedGraphemeCluster {
            replaceSubrange(i ..< i, with: newElements)
        }

        @inlinable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<String.ClusterView.Index>, with newElements: S) where S.Element == ExtendedGraphemeCluster {

            let preceding = StrictString(ClusterView(self[..<subrange.lowerBound]))
            let succeeding = StrictString(ClusterView(self[subrange.upperBound...]))
            let replacement = StrictString(ClusterView.normalize(newElements))

            self = (preceding + replacement + succeeding).clusters
        }

        // MARK: - TransparentWrapper

        public var wrappedInstance: Any {
            return string
        }
    }
}
