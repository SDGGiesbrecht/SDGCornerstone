/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String : StringFamily {

    // MARK: - Initialization

    /// Creates a string from a `StrictString`.
    public init(_ string: StrictString) {
        self = string.string
    }

    // MARK: - StringFamily

    /// A view of a string’s contents as a collection of Unicode scalars.
    public typealias ScalarView = String.UnicodeScalarView

    /// A view of a string’s contents as a collection of extended grapheme clusters.
    public typealias ClusterView = String

    // [_Inherit Documentation: SDGCornerstone.StringFamily.scalars_]
    /// A view of a string’s contents as a collection of Unicode scalars.
    @_transparent public var scalars: ScalarView {
        get {
            return unicodeScalars
        }
        set {
            unicodeScalars = newValue
        }
    }

    // [_Inherit Documentation: SDGCornerstone.StringFamily.clusters_]
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    @_transparent public var clusters: ClusterView {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
}
