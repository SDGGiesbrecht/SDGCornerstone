/*
 LineView.Index.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension LineView {

    /// A line view index.
    public struct Index : Comparable, Equatable, Hashable, OneDimensionalPoint, PointProtocol {

        // MARK: - Initialization

        internal init(_ value: Int) {
            self.value = value
        }

        // MARK: - Properties

        internal var value: Int

        // MARK: - Comparable

        // [_Inherit Documentation: SDGCornerstone.Equatable.<_]
        public static func < (lhs: Index, rhs: Index) -> Bool {
            return lhs.value < rhs.value
        }

        // MARK: - Equatable

        // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
        public static func == (lhs: Index, rhs: Index) -> Bool {
            return lhs.value == rhs.value
        }

        // MARK: - Hashable

        // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
        public var hashValue: Int {
            return value
        }

        // MARK: - PointProtocol

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
        public typealias Vector = Int

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
        public static func += (lhs: inout Index, rhs: Int) {
            lhs.value += rhs
        }

        // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
        public static func − (lhs: Index, rhs: Index) -> Int {
            return lhs.value − rhs.value
        }
    }
}
