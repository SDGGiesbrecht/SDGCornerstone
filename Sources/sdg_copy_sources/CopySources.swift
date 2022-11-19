/*
 CopySources.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections
import SDGText
import SDGPersistence

@main struct CopySources {
  static func main() throws {
    var arguments = ProcessInfo.processInfo.arguments.dropFirst()
    guard let originPath = arguments.popFirst() else {
      fatalError("The origin was not specified (first argument).")
    }
    guard let destinationPath = arguments.popFirst() else {
      fatalError("The destination was not specified (second argument).")
    }

    let origin = URL(fileURLWithPath: originPath)
    let destination = URL(fileURLWithPath: destinationPath)

    try? FileManager.default.removeItem(at: destination)
    try FileManager.default.copy(origin, to: destination)
  }
}
