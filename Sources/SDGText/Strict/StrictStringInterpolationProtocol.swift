/*
 StrictStringInterpolationProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public protocol _StrictStringInterpolationProtocol : StringInterpolationProtocol {
    init(_ result: StrictString)
    var result: StrictString { get set }
}

extension _StrictStringInterpolationProtocol {

    // MARK: - StringInterpolationProtocol

    @inlinable public init(literalCapacity: Int, interpolationCount: Int) {
        self = Self(StrictString())
    }

    @inlinable public mutating func appendLiteral(_ literal: String) {
        result.append(contentsOf: StrictString(literal))
    }

    @inlinable public mutating func appendInterpolation(_ string: StrictString) {
        result.append(contentsOf: string)
    }
    @inlinable public mutating func appendInterpolation(_ string: StrictString.SubSequence) {
        result.append(contentsOf: string)
    }
    @inlinable public mutating func appendInterpolation(_ clusters: StrictString.ClusterView) {
        result.append(contentsOf: StrictString(clusters))
    }
    @inlinable public mutating func appendInterpolation(_ clusters: StrictString.ClusterView.SubSequence) {
        result.append(contentsOf: StrictString(StrictString.ClusterView(clusters)))
    }

    @inlinable public mutating func appendInterpolation(_ string: String) {
        result.append(contentsOf: string.scalars)
    }

    @inlinable public mutating func appendInterpolation(_ interpolated: Any) {
        let resolved: String = "\(interpolated)"
        appendInterpolation(resolved)
    }
}
