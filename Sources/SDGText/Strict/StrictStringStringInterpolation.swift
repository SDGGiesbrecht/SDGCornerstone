/*
 StrictStringStringInterpolation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension StrictString {

  /// The type which handles interpolation of strict strings.
  public struct StringInterpolation: StrictStringInterpolationProtocol {

    // MARK: - StrictStringInterpolationProtocol

    public init(string: StrictString) {
      self.string = string
    }

    public var string: StrictString
  }
}
