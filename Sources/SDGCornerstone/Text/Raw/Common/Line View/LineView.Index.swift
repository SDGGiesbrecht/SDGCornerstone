/*
 LineView.Index.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line view index.
public struct LineIndex : Comparable, Equatable {

    // MARK: - Initialization

    internal init(start: String.ScalarView.Index, newline: Range<String.ScalarView.Index>? = nil) {
        self.start = start
        cache.newline = newline
    }

    private init() {
        start = nil
    }
    internal static func endIndex() -> LineIndex {
        return LineIndex()
    }

    // MARK: - Properties

    internal class Cache {
        fileprivate init() {}
        internal var newline: Range<String.ScalarView.Index>?
    }
    internal var cache = Cache()

    internal let start: String.ScalarView.Index? // nil indicates the end index

    internal func newline<S : UnicodeScalarView>(in scalars: S) -> Range<String.ScalarView.Index>? where S.Index == String.ScalarView.Index {
        guard let startIndex = start else {
            return nil
        }
        return cached(in: &cache.newline) {
            return scalars.firstMatch(for: LineView<String>.newlinePattern, in: startIndex ..< scalars.endIndex)?.range ?? scalars.endIndex ..< scalars.endIndex
        }
    }

    // MARK: - Conversions

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    public func samePosition(in scalars: StrictString) -> StrictString.Index {
        return start ?? scalars.endIndex
    }

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    public func samePosition(in scalars: String.ScalarView) -> String.ScalarView.Index {
        return start ?? scalars.endIndex
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
    public static func < (lhs: LineIndex, rhs: LineIndex) -> Bool {
        if let lhsStart = lhs.start {
            if let rhsStart = rhs.start {
                return lhsStart < rhsStart
            } else {
                // lhs is valid, but rhs is the end index.
                return true
            }
        } else {
            // lhs is the end index.
            return false
        }
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    public static func == (lhs: LineIndex, rhs: LineIndex) -> Bool {
        return lhs.start == rhs.start
    }
}
