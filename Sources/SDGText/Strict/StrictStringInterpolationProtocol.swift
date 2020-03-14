/*
 StrictStringInterpolationProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The protocol which handles interpolation for strict strings.
public protocol StrictStringInterpolationProtocol: StringInterpolationProtocol {

  /// Creates an interpolation starting with an initial string.
  ///
  /// - Parameters:
  ///     - string: The initial string.
  init(string: StrictString)

  /// The string described by the interpolation.
  var string: StrictString { get set }
}

extension StrictStringInterpolationProtocol {

  // MARK: - StringInterpolationProtocol

  public init(literalCapacity: Int, interpolationCount: Int) {
    self = Self(string: StrictString())
  }

  public mutating func appendLiteral(_ literal: String) {
    self.string.append(contentsOf: StrictString(literal))
  }

  // @documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: StrictString) {
    self.string.append(contentsOf: string)
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: StrictString.SubSequence) {
    self.string.append(contentsOf: string)
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: StrictString.ClusterView) {
    self.string.append(contentsOf: StrictString(string))
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: StrictString.ClusterView.SubSequence) {
    self.string.append(contentsOf: StrictString(StrictString.ClusterView(string)))
  }

  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: String) {
    self.string.append(contentsOf: string.scalars)
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: String.SubSequence) {
    self.string.append(contentsOf: string.unicodeScalars)
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: String.ScalarView) {
    self.string.append(contentsOf: string)
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: String.ScalarView.SubSequence) {
    self.string.append(contentsOf: string)
  }
  // #documentation(StrictStringInterpolationProtocol.appendInterpolation(string))
  /// Interpolates a string.
  ///
  /// - Parameters:
  ///     - string: The string.
  public mutating func appendInterpolation(_ string: StaticString) {
    self.string.append(contentsOf: StrictString(string))
  }

  /// Interpolates a Unicode scalar.
  ///
  /// - Parameters:
  ///     - scalar: The Unicode scalar.
  public mutating func appendInterpolation(_ scalar: Unicode.Scalar) {
    self.string.append(scalar)
  }
  /// Interpolates an extended grapheme cluster.
  ///
  /// - Parameters:
  ///     - cluster: The extended grapheme cluster.
  public mutating func appendInterpolation(_ cluster: ExtendedGraphemeCluster) {
    self.string.append(contentsOf: cluster.unicodeScalars)
  }

  /// Interpolates the name of the specified type.
  ///
  /// - Parameters:
  ///     - type: The type.
  public mutating func appendInterpolation(typeName type: Any.Type) {
    let typeName: String = "\(type)"
    self.string.append(contentsOf: typeName.scalars)
  }

  // @localization(🇩🇪DE)
  // @crossReference(StrictStringInterpolationProtocol.appendInterpolation(arbitraryDescriptionOf:))
  /// Interpoliert eine willkürliche Beschreibung des Werts, bereitgestellt von dem Swift‐Übersetzer.
  ///
  /// - Parameters:
  ///     - wert: Der Wert.
  @inlinable public mutating func appendInterpolation(willkürlicheBeschreibungVon wert: Any) {
    appendInterpolation(arbitraryDescriptionOf: wert)
  }
  // @localization(🇨🇦EN)
  // @crossReference(StrictStringInterpolationProtocol.appendInterpolation(arbitraryDescriptionOf:))
  /// Interpolates an arbitrary description of the value, supplied by the Swift compiler.
  ///
  /// - Parameters:
  ///     - value: The value.
  public mutating func appendInterpolation(arbitraryDescriptionOf value: Any) {
    let description: String = "\(value)"
    self.string.append(contentsOf: description.scalars)
  }
}
