/*
 PatternConsumption.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Pattern consumption behaviour.
public enum Consumption {
  /// Prefers longer matches.
  case greedy
  /// Prefers shorter matches.
  case lazy
}
