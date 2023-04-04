/*
 CopySources.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import PackagePlugin

@main struct CopySources: BuildToolPlugin {

  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    let package = context.package.directory
    let executable = try context.tool(named: "sdg_copy_source").path
    let plugInWork = context.pluginWorkDirectory

    let manifestPath = target.directory.appending("Copy Sources.txt")
    let manifestURL = URL(fileURLWithPath: manifestPath.string)
    let manifestData = try Data(contentsOf: manifestURL, options: [.mappedIfSafe])
    guard let manifest = String(data: manifestData, encoding: .utf8) else {
      fatalError("Unable to load manifest; invalid UTF‐8.")
    }

    var commands: [Command] = []
    for line in manifest.components(separatedBy: CharacterSet.newlines) {
      if line.isEmpty { continue }

      var halves = line.components(separatedBy: " → ")[...]
      guard let relativeOrigin = halves.popFirst(),
        let relativeDestination = halves.popFirst()
      else {
        fatalError("Unable to parse manifest entry; missing “ → ”: “\(line)”")
      }
      guard halves.isEmpty else {
        fatalError("Unable to parse manifest entry; extraneous “ → ”: “\(line)”")
      }

      let origin = package.appending(subpath: relativeOrigin)
      let destination = plugInWork.appending(subpath: relativeDestination)

      commands.append(
        .buildCommand(
          displayName: "Copy Source (\(destination.lastComponent))",
          executable: executable,
          arguments: [origin, destination],
          inputFiles: [manifestPath, origin],
          outputFiles: [destination]
        )
      )
    }
    return commands
  }
}
