/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String : StringFamily {

    // MARK: - Initialization

    /// Creates a string from a `StrictString`.
    @inlinable public init(_ string: StrictString) {
        self = string.string
    }

    // MARK: - StringFamily

    public typealias ScalarView = String.UnicodeScalarView

    public typealias ClusterView = String

    @inlinable public var scalars: ScalarView {
        get {
            return unicodeScalars
        }
        set {
            unicodeScalars = newValue
        }
    }

    @inlinable public var clusters: ClusterView {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
}
