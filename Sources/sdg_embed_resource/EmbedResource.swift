/*
 EmbedResource.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence

@main struct EmbedResource {

  static func main() throws {
    var arguments = ProcessInfo.processInfo.arguments.dropFirst()
    guard let resourceOrNamespaceSourcePath = arguments.popFirst() else {
      fatalError("No resource path or namespace source path specified (first argument).")
    }
    guard let outputSourcePath = arguments.popFirst() else {
      let namespaceSource = URL(fileURLWithPath: resourceOrNamespaceSourcePath)
      try produceMainFile(destination: namespaceSource)
      return
    }
    guard let identifier = arguments.popFirst() else {
      fatalError("No identifier specified (third argument).")
    }
    guard let type = arguments.popFirst() else {
      fatalError("No type specified (fourth argument).")
    }

    let resource = URL(fileURLWithPath: resourceOrNamespaceSourcePath)
    let outputSource = URL(fileURLWithPath: outputSourcePath)

    try produceAccessor(
      resource: resource,
      outputSource: outputSource,
      identifier: identifier,
      type: type
    )
  }

  static func produceMainFile(destination: URL) throws {
    fatalError("Not implemented yet.")
  }

  static func produceAccessor(
    resource: URL,
    outputSource: URL,
    identifier: String,
    type: String
  ) throws {
    fatalError("Not implemented yet.")
  }
}
