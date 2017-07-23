/*
 LineView.Index.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension LineView {

    /// A line view index.
    public struct Index : Comparable, Equatable, Hashable, FixedScaleOneDimensionalPoint, PointProtocol {

        // MARK: - Initialization

        internal init(_ value: Int) {
            self.value = value
        }

        // MARK: - Properties

        internal var value: Int

        // MARK: - Conversions

        /// Returns the position in the given view of scalars that corresponds exactly to this index.
        public func samePosition(in scalars: StrictString) -> StrictString.Index {
            return samePosition(in: String(StrictString(scalars)).scalars)
        }

        /// Returns the position in the given view of scalars that corresponds exactly to this index.
        public func samePosition(in scalars: String.ScalarView) -> String.ScalarView.Index {
            if value == 0 {
                return scalars.startIndex
            } else {
                return scalars.matches(for: LineView<String>.newlinePattern)[value − 1].range.upperBound
            }
        }

        /// Returns the position in the given view of clusters that corresponds exactly to this index.
        public func samePosition(in clusters: StrictString.ClusterView) -> StrictString.ClusterView.Index {
            return samePosition(in: String(StrictString(clusters)).clusters)
        }

        /// Returns the position in the given view of clusters that corresponds exactly to this index.
        public func samePosition(in clusters: String.ClusterView) -> String.ClusterView.Index {
            let string = String(clusters)
            return samePosition(in: string.scalars).cluster(in: string.clusters)
        }

        // MARK: - Comparable

        // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
        /// Returns `true` if the left value is less than the right.
        ///
        /// - Parameters:
        ///     - lhs: A value.
        ///     - rhs: Another value.
        public static func < (lhs: Index, rhs: Index) -> Bool {
            return lhs.value < rhs.value
        }

        // MARK: - Equatable

        // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
        /// Returns `true` if the two values are equal.
        ///
        /// - Parameters:
        ///     - lhs: A value to compare.
        ///     - rhs: Another value to compare.
        public static func == (lhs: Index, rhs: Index) -> Bool {
            return lhs.value == rhs.value
        }

        // MARK: - Hashable

        // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
        /// The hash value.
        public var hashValue: Int {
            return value
        }

        // MARK: - PointProtocol

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
        /// The type to be used as a vector.
        public typealias Vector = Int

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
        /// Moves the point on the left by the vector on the right.
        ///
        /// - Parameters:
        ///     - lhs: The point to modify.
        ///     - rhs: The vector to add.
        ///
        /// - NonmutatingVariant: +
        public static func += (lhs: inout Index, rhs: Int) {
            lhs.value += rhs
        }

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
        /// Returns the vector that leads from the point on the left to the point on the right.
        ///
        /// - Parameters:
        ///     - lhs: The endpoint.
        ///     - rhs: The startpoint.
        public static func − (lhs: Index, rhs: Index) -> Int {
            return lhs.value − rhs.value
        }
    }
}
