/*
 StringFamily.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// `String` or `StrictString`
public protocol StringFamily : Addable, Comparable, CustomStringConvertible, Equatable, ExpressibleByTextLiterals, Hashable, LosslessStringConvertible, TextOutputStream, TextOutputStreamable {

    // MARK: - Associated Types

    // [_Define Documentation: SDGCornerstone.StringFamily.ScalarView_]
    /// A view of a string’s contents as a collection of Unicode scalars.
    associatedtype ScalarView : UnicodeScalarView

    // [_Define Documentation: SDGCornerstone.StringFamily.ClusterView_]
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    associatedtype ClusterView : ExtendedGraphemeClusterView

    // MARK: - Initialization

    // [_Define Documentation: SDGCornerstone.StringFamily.init(scalars:)_]
    /// Creates an empty string.
    init()

    // [_Define Documentation: SDGCornerstone.StringFamily.init(scalars:)_]
    /// Creates a string from a collection of scalars.
    init(_ scalars: ScalarView)

    // [_Define Documentation: SDGCornerstone.StringFamily.init(clusters:)_]
    /// Creates a string from a collection of clusters.
    init(_ clusters: ClusterView)

    // MARK: - Properties

    // [_Define Documentation: SDGCornerstone.StringFamily.scalars_]
    /// A view of a string’s contents as a collection of Unicode scalars.
    var scalars: ScalarView { get set }

    // [_Define Documentation: SDGCornerstone.StringFamily.clusters_]
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    var clusters: ClusterView { get set }
}

extension StringFamily where ScalarView.Iterator.Element == UnicodeScalar /* [_Workaround: The where statement is redundant. Once the constraint can be added to the protocol, it should be removed here. (Swift 3.1.0)_] */ {
    // MARK: - where ScalarView.Iterator.Element == UnicodeScalar

    // [_Define Documentation: SDGCornerstone.StringFamily.init(lines:)_]
    /// Creates a string from a collection of lines.
    public init(_ lines: LineView<Self>) {
        self = lines.base
    }

    // [_Define Documentation: SDGCornerstone.StringFamily.lines_]
    /// A view of a string’s contents as a collection of lines.
    public var lines: LineView<Self> {
        get {
            return LineView(self)
        }
        set {
            self = newValue.base
        }
    }
}
