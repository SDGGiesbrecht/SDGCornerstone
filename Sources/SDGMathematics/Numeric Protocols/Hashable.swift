/*
 Hashable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.5.3, Redundant, but evades SR‐15734.)
public protocol _Hashable: Hashable, __Hashable {}
public protocol __Hashable {
  func hash(into hasher: inout Hasher)
}
