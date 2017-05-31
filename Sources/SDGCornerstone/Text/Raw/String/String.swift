/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String : PropertyListValue, StringFamily {

    /// Creates a string from a `StrictString`.
    public init(_ string: StrictString) {
        self = string.string
    }

    // MARK: - StringFamily

    // [_Workaround: Compiler bugs prevent referencing the typealiases. When this is fixed, these properties should be typed as ScalarView and ClusterView. (Swift 3.1.0)_]

    // [_Inherit Documentation: SDGCornerstone.StringFamily.scalars_]
    /// A view of a string’s contents as a collection of Unicode scalars.
    public var scalars: UnicodeScalarView {
        get {
            return unicodeScalars
        }
        set {
            unicodeScalars = newValue
        }
    }

    // [_Inherit Documentation: SDGCornerstone.StringFamily.clusters_]
    /// A view of a string’s contents as a collection of extended grapheme clusters.
    public var clusters: CharacterView {
        get {
            return characters
        }
        set {
            characters = newValue
        }
    }
}
