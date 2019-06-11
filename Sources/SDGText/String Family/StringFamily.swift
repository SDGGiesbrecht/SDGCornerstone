/*
 StringFamily.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A `String` or `StrictString`.
public protocol StringFamily : Addable, Comparable, Decodable, Encodable, ExpressibleByStringInterpolation, Hashable, LosslessStringConvertible, TextOutputStream, TextOutputStreamable {

    // MARK: - Associated Types

    // @documentation(SDGCornerstone.StringFamily.ScalarView)
    /// A view of a string’s contents as a collection of Unicode scalars.
    associatedtype ScalarView : UnicodeScalarView

    // @documentation(SDGCornerstone.StringFamily.ClusterView)
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    associatedtype ClusterView : ExtendedGraphemeClusterView

    // MARK: - Initialization

    /// Creates an empty string.
    init()

    /// Creates a string from a collection of scalars.
    init(_ scalars: ScalarView)

    /// Creates a string from a collection of clusters.
    init(_ clusters: ClusterView)

    // MARK: - Properties

    /// A view of a string’s contents as a collection of Unicode scalars.
    var scalars: ScalarView { get set }

    /// A view of a string’s contents as a collection of extended grapheme clusters.
    var clusters: ClusterView { get set }
}

extension StringFamily {

    /// Creates a string from a collection of lines.
    @inlinable public init(_ lines: LineView<Self>) {
        self = lines.base
    }

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
