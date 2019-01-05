/*
 StringFamily.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A `String` or `StrictString`.
public protocol StringFamily : Addable, Codable, Comparable, ExpressibleByStringLiteral, Hashable, LosslessStringConvertible, TextOutputStream, TextOutputStreamable {

    // MARK: - Associated Types

    // @documentation(SDGCornerstone.StringFamily.ScalarView)
    /// A view of a string’s contents as a collection of Unicode scalars.
    associatedtype ScalarView : UnicodeScalarView

    // @documentation(SDGCornerstone.StringFamily.ClusterView)
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    associatedtype ClusterView : ExtendedGraphemeClusterView

    // MARK: - Initialization

    // @documentation(SDGCornerstone.StringFamily.init(scalars:))
    /// Creates an empty string.
    init()

    // @documentation(SDGCornerstone.StringFamily.init(scalars:))
    /// Creates a string from a collection of scalars.
    init(_ scalars: ScalarView)

    // @documentation(SDGCornerstone.StringFamily.init(clusters:))
    /// Creates a string from a collection of clusters.
    init(_ clusters: ClusterView)

    // MARK: - Properties

    // @documentation(SDGCornerstone.StringFamily.scalars)
    /// A view of a string’s contents as a collection of Unicode scalars.
    var scalars: ScalarView { get set }

    // @documentation(SDGCornerstone.StringFamily.clusters)
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    var clusters: ClusterView { get set }
}

extension StringFamily {

    // @documentation(SDGCornerstone.StringFamily.init(lines:))
    /// Creates a string from a collection of lines.
    @inlinable public init(_ lines: LineView<Self>) {
        self = lines.base
    }

    // @documentation(SDGCornerstone.StringFamily.lines)
    /// A view of a string’s contents as a collection of lines.
    @inlinable public var lines: LineView<Self> {
        get {
            return LineView(self)
        }
        set {
            self = newValue.base
        }
    }

    // @documentation(SDGCornerstone.String.isMultiline)
    /// Whether or not the string contains multiple lines.
    @inlinable public var isMultiline: Bool {
        return scalars.isMultiline
    }
}
