/*
 Data.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Data {

    // MARK: - Properties

    /// The data represented as a collection of bits.
    @inlinable public var binary: BinaryView {
        get {
            return BinaryView(self)
        }
        set {
            self = newValue.data
        }
    }
}
