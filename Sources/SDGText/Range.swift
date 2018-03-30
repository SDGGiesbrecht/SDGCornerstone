/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Range where Bound == LineIndex {
    // MARK: - where Bound == LineIndex

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    @_inlineable public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.ScalarView.Index> {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    @_inlineable public func sameRange(in scalars: String.ScalarView) -> Range<String.ScalarView.Index> {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    @_inlineable public func sameRange(in clusters: StrictString.ClusterView) -> Range<StrictString.ClusterView.Index> {
        return lowerBound.samePosition(in: clusters) ..< upperBound.samePosition(in: clusters)
    }

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    @_inlineable public func sameRange(in clusters: String.ClusterView) -> Range<String.ClusterView.Index> {
        return lowerBound.samePosition(in: clusters) ..< upperBound.samePosition(in: clusters)
    }
}

extension Range where Bound == StrictString.ClusterView.Index {
    // MARK: - where Bound == StrictString.ClusterView.Index

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    @_inlineable public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.ScalarView.Index> {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }
}

extension Range where Bound == StrictString.ScalarView.Index {
    // MARK: - where Bound == StrictString.ScalarView.Index

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    @_inlineable public func sameRange(in clusters: StrictString.ClusterView) -> Range<StrictString.ClusterView.Index>? {
        if let lower = lowerBound.samePosition(in: clusters),
            let upper = upperBound.samePosition(in: clusters) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of clusters that contains this range.
    @_inlineable public func clusters(in clusters: StrictString.ClusterView) -> Range<StrictString.ClusterView.Index> {
        let lower = lowerBound.cluster(in: clusters)
        if let upper = upperBound.samePosition(in: clusters) {
            return lower ..< upper
        } else {
            return lower ..< clusters.index(after: upperBound.cluster(in: clusters))
        }
    }

    /// Returns the range in the given view of lines that corresponds exactly to this range.
    @_inlineable public func sameRange(in lines: LineView<StrictString>) -> Range<LineView<StrictString>.Index>? {
        if let lower = lowerBound.samePosition(in: lines),
            let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of lines that contains this range.
    @_inlineable public func lines(in lines: LineView<StrictString>) -> Range<LineView<StrictString>.Index> {
        let lower = lowerBound.line(in: lines)
        if let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return lower ..< lines.index(after: upperBound.line(in: lines))
        }
    }
}

extension Range where Bound == String.ClusterView.Index {
    // MARK: - where Bound == String.ClusterView.Index

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    @_inlineable public func sameRange(in scalars: String.ScalarView) -> Range<String.ScalarView.Index> {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }
}

extension Range where Bound == String.ScalarView.Index {
    // MARK: - where Bound == String.ScalarView.Index

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    @_inlineable public func sameRange(in clusters: String.ClusterView) -> Range<String.ClusterView.Index>? {
        if let lower = lowerBound.samePosition(in: String(clusters)),
            let upper = upperBound.samePosition(in: String(clusters)) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of clusters that contains this range.
    @_inlineable public func clusters(in clusters: String.ClusterView) -> Range<String.ClusterView.Index> {
        let lower = lowerBound.cluster(in: clusters)
        if let upper = upperBound.samePosition(in: String(clusters)) {
            return lower ..< upper
        } else {
            return lower ..< clusters.index(after: upperBound.cluster(in: clusters))
        }
    }

    /// Returns the range in the given view of lines that corresponds exactly to this range.
    @_inlineable public func sameRange(in lines: LineView<String>) -> Range<LineView<String>.Index>? {
        if let lower = lowerBound.samePosition(in: lines),
            let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of lines that contains this range.
    @_inlineable public func lines(in lines: LineView<String>) -> Range<LineView<String>.Index> {
        let lower = lowerBound.line(in: lines)
        if let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return lower ..< lines.index(after: upperBound.line(in: lines))
        }
    }
}
