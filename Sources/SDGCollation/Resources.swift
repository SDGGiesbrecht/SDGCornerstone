/*
 Resources.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal enum Resources {}
internal typealias Ressourcen = Resources

extension Resources {
  #if !os(WASI)
    internal static let moduleBundle: Bundle = {
      let main = Bundle.main.executableURL?.resolvingSymlinksInPath().deletingLastPathComponent()
      let module = main?.appendingPathComponent("SDGCornerstone_SDGCollation.bundle")
      return module.flatMap({ Bundle(url: $0) }) ?? Bundle.module
    }()
  #endif

}
