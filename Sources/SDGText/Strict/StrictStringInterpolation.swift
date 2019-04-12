/*
 StrictStringInterpolation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension StrictString {

    public struct _Interpolation : StringInterpolationProtocol {

        @usableFromInline internal var result: StrictString

        // MARK: - StringInterpolationProtocol

        @inlinable public init(literalCapacity: Int, interpolationCount: Int) {
            result = StrictString()
        }

        @inlinable public mutating func appendLiteral(_ literal: String) {
            result.append(contentsOf: StrictString(literal))
        }

        @inlinable public mutating func appendInterpolation<S>(_ scalars: S) where S : Sequence, S.Element == Unicode.Scalar {
            result.append(contentsOf: scalars)
        }
        @inlinable public mutating func appendInterpolation(_ string: String) {
            appendInterpolation(string.scalars)
        }
        @inlinable public mutating func appendInterpolation<S>(_ clusters: S) where S : Sequence, S.Element == ExtendedGraphemeCluster {
            appendInterpolation(String(clusters))
        }

        @inlinable public mutating func appendInterpolation(_ scalar: Unicode.Scalar) {
            result.append(scalar)
        }
        @inlinable public mutating func appendInterpolation(_ cluster: ExtendedGraphemeCluster) {
            result.append(contentsOf: cluster.unicodeScalars)
        }
    }
}
