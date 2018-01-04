/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A member of the `Range` family: `Range`, `ClosedRange`, `CountableRange` or `CountableClosedRange`.
public protocol RangeFamily : ComparableSet, CustomDebugStringConvertible, CustomReflectable, CustomStringConvertible {

    // [_Define Documentation: SDGCornerstone.RangeFamily.Bound_]
    /// The bound type.
    associatedtype Bound : Comparable

    // [_Define Documentation: SDGCornerstone.RangeFamily.lowerBound_]
    /// The lower bound.
    var lowerBound: Bound { get }

    // [_Define Documentation: SDGCornerstone.RangeFamily.upperBound_]
    /// The upper bound.
    var upperBound: Bound { get }

    // [_Define Documentation: SDGCornerstone.RangeFamily.contains(_:)._]
    /// Returns `true` if `element` is within the range.
    ///
    /// - Parameters:
    ///     - element: The element.
    func contains(_ element: Bound) -> Bool

    // [_Define Documentation: SDGCornerstone.RangeFamily.overlaps(_:)._]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps(_ other: Self) -> Bool

    // [_Define Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    static var hasClosedUpperBound: Bool { get }
}

extension Range : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    public static var hasClosedUpperBound: Bool {
        return false
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Bound
}

extension ClosedRange : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    public static var hasClosedUpperBound: Bool {
        return true
    }

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Bound
}

extension CountableRange : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    public static var hasClosedUpperBound: Bool {
        return false
    }
}
extension CountableClosedRange : RangeFamily {

    // MARK: - RangeFamily

    // [_Inherit Documentation: SDGCornerstone.RangeFamily.hasClosedUpperBound_]
    /// `true` if the type has a closed upper bound.
    public static var hasClosedUpperBound: Bool {
        return true
    }
}

extension RangeFamily {

    /// Returns the range in inequality notation. (eg. “1 ≤ x ≤ 10”)
    public func inInequalityNotation(_ describe: (_ bound: Bound) -> StrictString) -> StrictString {
        return StrictString("\(describe(lowerBound)) ≤ x \(Self.hasClosedUpperBound ? "≤" : "<") \(describe(upperBound))")
    }
}

extension Range where Bound == LineIndex {
    // MARK: - where Bound == LineIndex

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.ScalarView.Index>? {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    public func sameRange(in scalars: String.ScalarView) -> Range<String.ScalarView.Index>? {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    public func sameRange(in clusters: StrictString.ClusterView) -> Range<StrictString.ClusterView.Index>? {
        return lowerBound.samePosition(in: clusters) ..< upperBound.samePosition(in: clusters)
    }

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    public func sameRange(in clusters: String.ClusterView) -> Range<String.ClusterView.Index>? {
        return lowerBound.samePosition(in: clusters) ..< upperBound.samePosition(in: clusters)
    }
}

extension Range where Bound == StrictString.ClusterView.Index {
    // MARK: - where Bound == StrictString.ClusterView.Index

    /// Returns the range in the given view of scalars that corresponds exactly to this range.
    public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.ScalarView.Index>? {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }
}

extension Range where Bound == StrictString.ScalarView.Index {
    // MARK: - where Bound == StrictString.ScalarView.Index

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    public func sameRange(in clusters: StrictString.ClusterView) -> Range<StrictString.ClusterView.Index>? {
        if let lower = lowerBound.samePosition(in: clusters),
            let upper = upperBound.samePosition(in: clusters) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of clusters that contains this range.
    public func clusters(in clusters: StrictString.ClusterView) -> Range<StrictString.ClusterView.Index> {
        let lower = lowerBound.cluster(in: clusters)
        if let upper = upperBound.samePosition(in: clusters) {
            return lower ..< upper
        } else {
            return lower ..< clusters.index(after: upperBound.cluster(in: clusters))
        }
    }

    /// Returns the range in the given view of lines that corresponds exactly to this range.
    public func sameRange(in lines: LineView<StrictString>) -> Range<LineView<StrictString>.Index>? {
        if let lower = lowerBound.samePosition(in: lines),
            let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of lines that contains this range.
    public func lines(in lines: LineView<StrictString>) -> Range<LineView<StrictString>.Index> {
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
    public func sameRange(in scalars: String.ScalarView) -> Range<String.ScalarView.Index>? {
        return lowerBound.samePosition(in: scalars) ..< upperBound.samePosition(in: scalars)
    }
}

extension Range where Bound == String.UnicodeScalarView.Index {
    // MARK: - where Bound == String.ScalarView.Index

    /// Returns the range in the given view of clusters that corresponds exactly to this range.
    public func sameRange(in clusters: String.ClusterView) -> Range<String.ClusterView.Index>? {
        if let lower = lowerBound.samePosition(in: String(clusters)),
            let upper = upperBound.samePosition(in: String(clusters)) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of clusters that contains this range.
    public func clusters(in clusters: String.ClusterView) -> Range<String.ClusterView.Index> {
        let lower = lowerBound.cluster(in: clusters)
        if let upper = upperBound.samePosition(in: String(clusters)) {
            return lower ..< upper
        } else {
            return lower ..< clusters.index(after: upperBound.cluster(in: clusters))
        }
    }

    /// Returns the range in the given view of lines that corresponds exactly to this range.
    public func sameRange(in lines: LineView<String>) -> Range<LineView<String>.Index>? {
        if let lower = lowerBound.samePosition(in: lines),
            let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return nil
        }
    }

    /// Returns the range of lines that contains this range.
    public func lines(in lines: LineView<String>) -> Range<LineView<String>.Index> {
        let lower = lowerBound.line(in: lines)
        if let upper = upperBound.samePosition(in: lines) {
            return lower ..< upper
        } else {
            return lower ..< lines.index(after: upperBound.line(in: lines))
        }
    }
}
