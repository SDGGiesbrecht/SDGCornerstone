/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Range where Bound == LineViewIndex {

    #warning("Move these?")
    @inlinable internal func map<B>(_ convert: (Bound) -> B) -> Range<B> {
        return convert(lowerBound) ..< convert(upperBound)
    }

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - scalars: The scalar view of the string the range refers to.
    @inlinable public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.Index> {
        return map { $0.samePosition(in: scalars) }
    }

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - scalars: The scalar view of the string the range refers to.
    @inlinable public func sameRange(in scalars: String.ScalarView) -> Range<String.Index> {
        return map { $0.samePosition(in: scalars) }
    }

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func sameRange(in clusters: StrictString.ClusterView) -> Range<StrictString.Index> {
        return map { $0.samePosition(in: clusters) }
    }

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func sameRange(in clusters: String.ClusterView) -> Range<String.Index> {
        return map { $0.samePosition(in: clusters) }
    }
}

extension Range where Bound == String.Index {

    #warning("Move these?")
    @inlinable internal func map<B>(_ convert: (Bound) -> B?) -> Range<B>? {
        guard let lower = convert(lowerBound),
            let upper = convert(upperBound) else {
                return nil
        }
        return lower ..< upper
    }

    @inlinable internal func map<B>(
        convertAndRoundDown: (Bound) -> B,
        convertIfPossible: (Bound) -> B?,
        advance: (B) -> B) -> Range<B> {

        let lower = convertAndRoundDown(lowerBound)
        if let upper = convertIfPossible(upperBound) {
            return lower ..< upper
        } else {
            return lower ..< advance(convertAndRoundDown(upperBound))
        }
    }

    // @documentation(Range.sameRange(in:))
    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - scalars: The scalar view of the string the range refers to.
    @inlinable public func sameRange(in scalars: String.ScalarView) -> Range<String.Index>? {
        return map { $0.samePosition(in: scalars) }
    }

    // #documentation(Range.sameRange(in:))
    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - scalars: The scalar view of the string the range refers to.
    @inlinable public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.Index>? {
        return map { $0.samePosition(in: scalars) }
    }

    #warning("scalars(in:).")

    // @documentation(Range.sameRange(in:))
    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func sameRange(in clusters: String.ClusterView) -> Range<String.Index>? {
        return map { $0.samePosition(in: clusters) }
    }

    // #documentation(Range.sameRange(in:))
    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func sameRange(in clusters: StrictString.ClusterView) -> Range<StrictString.Index>? {
        return map { $0.samePosition(in: clusters) }
    }

    // @documentation(Range.clusters(in:))
    /// Returns the range of clusters that contains this range.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func clusters(in clusters: String.ClusterView) -> Range<String.Index> {
        return map(
            convertAndRoundDown: { $0.cluster(in: clusters) },
            convertIfPossible: { $0.cluster(in: clusters) },
            advance: { clusters.index(after: $0) })
    }

    // #documentation(Range.clusters(in:))
    /// Returns the range of clusters that contains this range.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func clusters(in clusters: StrictString.ClusterView) -> Range<StrictString.Index> {
        return map(
            convertAndRoundDown: { $0.cluster(in: clusters) },
            convertIfPossible: { $0.cluster(in: clusters) },
            advance: { clusters.index(after: $0) })
    }

    #warning("Genericize?")
    /// Returns the range in the given view of lines that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func sameRange(in lines: LineView<String>) -> Range<LineView<String>.Index>? {
        if let lower = lowerBound.samePosition(in: lines),
            let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range in the given view of lines that corresponds exactly to this range.
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func sameRange(in lines: LineView<StrictString>) -> Range<LineView<StrictString>.Index>? {
        return map { $0.samePosition(in: lines) }
    }

    /// Returns the range of lines that contains this range.
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func lines(in lines: LineView<String>) -> Range<LineView<String>.Index> {
        let lower = lowerBound.line(in: lines)
        if let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return lower ..< lines.index(after: upperBound.line(in: lines))
        }
    }

    /// Returns the range of lines that contains this range.
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func lines(in lines: LineView<StrictString>) -> Range<LineView<StrictString>.Index> {
        let lower = lowerBound.line(in: lines)
        if let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return lower ..< lines.index(after: upperBound.line(in: lines))
        }
    }
}
