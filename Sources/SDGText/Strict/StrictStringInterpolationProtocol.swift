/*
 StrictStringInterpolationProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The protocol which handles interpolation for strict strings.
public protocol StrictStringInterpolationProtocol : StringInterpolationProtocol {
    init(_result result: StrictString)
    var _result: StrictString { get set }
}

extension StrictStringInterpolationProtocol {

    @inlinable internal init(result: StrictString) {
        self.init(_result: result)
    }
    @inlinable internal var result: StrictString {
        get {
            return _result
        }
        set {
            _result = newValue
        }
    }

    // MARK: - StringInterpolationProtocol

    @inlinable public init(literalCapacity: Int, interpolationCount: Int) {
        self = Self(result: StrictString())
    }

    @inlinable public mutating func appendLiteral(_ literal: String) {
        result.append(contentsOf: StrictString(literal))
    }

    // @documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ string: StrictString) {
        result.append(contentsOf: string)
    }
    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ string: StrictString.SubSequence) {
        result.append(contentsOf: string)
    }
    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ clusters: StrictString.ClusterView) {
        result.append(contentsOf: StrictString(clusters))
    }
    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ clusters: StrictString.ClusterView.SubSequence) {
        result.append(contentsOf: StrictString(StrictString.ClusterView(clusters)))
    }

    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ string: String) {
        result.append(contentsOf: string.scalars)
    }
    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ string: String.SubSequence) {
        result.append(contentsOf: string.unicodeScalars)
    }
    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ scalars: String.ScalarView) {
        result.append(contentsOf: scalars)
    }
    // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
    /// Interpolates a string.
    ///
    /// - Parameters:
    ///     - string: The string.
    @inlinable public mutating func appendInterpolation(_ scalars: String.ScalarView.SubSequence) {
        result.append(contentsOf: scalars)
    }

    /// Interpolates a static string.
    ///
    /// - Parameters:
    ///     - string: The static string.
    @inlinable public mutating func appendInterpolation(_ string: StaticString) {
        result.append(contentsOf: StrictString(string))
    }

    /// Interpolates a Unicode scalar.
    ///
    /// - Parameters:
    ///     - scalar: The Unicode scalar.
    @inlinable public mutating func appendInterpolation(_ scalar: Unicode.Scalar) {
        result.append(scalar)
    }
    /// Interpolates an extended grapheme cluster.
    ///
    /// - Parameters:
    ///     - cluster: The extended grapheme cluster.
    @inlinable public mutating func appendInterpolation(_ cluster: ExtendedGraphemeCluster) {
        result.append(contentsOf: cluster.unicodeScalars)
    }

    /// Interpolates the name of the specified type.
    ///
    /// - Parameters:
    ///     - type: The type.
    @inlinable public mutating func appendInterpolation(typeName type: Any.Type) {
        let typeName: String = "\(type)"
        result.append(contentsOf: typeName.scalars)
    }

    /// Interpolates an arbitrary description of the value, supplied by the Swift compiler.
    ///
    /// - Parameters:
    ///     - value: The value.
    @inlinable public mutating func appendInterpolation(arbitraryDescriptionOf value: Any) {
        let description: String = "\(value)"
        result.append(contentsOf: description.scalars)
    }
}
