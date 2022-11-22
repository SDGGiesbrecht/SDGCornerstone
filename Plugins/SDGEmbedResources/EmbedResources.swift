/*
 EmbedResources.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import PackagePlugin

@main struct EmbedResources: BuildToolPlugin {

  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    let executable = try context.tool(named: "sdg_embed_resource").path
    let plugInWork = context.pluginWorkDirectory
    let targetRoot = target.directory

    let manifestPath = targetRoot.appending("Embed Resources.txt")
    let manifestURL = URL(fileURLWithPath: manifestPath.string)
    let manifestData = try Data(contentsOf: manifestURL, options: [.mappedIfSafe])
    guard let manifest = String(data: manifestData, encoding: .utf8) else {
      fatalError("Unable to load manifest; invalid UTF‐8.")
    }

    let namespace = plugInWork.appending([disambiguate(fileName: "Resources")])

    var commands: [Command] = []
    commands.append(
      .buildCommand(
        displayName: "Generate Resources Namespace",
        executable: executable,
        arguments: [namespace],
        inputFiles: [manifestPath],
        outputFiles: [namespace]
      )
    )
    for (index, line) in manifest.components(separatedBy: CharacterSet.newlines).enumerated() {
      if line.isEmpty { continue }

      var halves = line.components(separatedBy: " → ")[...]
      guard let resourcePath = halves.popFirst(),
        let details = halves.popFirst()
      else {
        fatalError("Unable to parse manifest entry; missing “ → ”: “\(line)”")
      }
      guard halves.isEmpty else {
        fatalError("Unable to parse manifest entry; extraneous “ → ”: “\(line)”")
      }

      halves = details.components(separatedBy: ": ")[...]
      guard let identifier = halves.popFirst(),
        let type = halves.popFirst()
      else {
        fatalError("Unable to parse manifest entry; missing “: ”: “\(line)”")
      }
      guard halves.isEmpty else {
        fatalError("Unable to parse manifest entry; extraneous “: ”: “\(line)”")
      }

      let origin = targetRoot.appending(subpath: resourcePath)
      let outputSource = plugInWork.appending([disambiguate(fileName: "Resource \(index + 1)")])

      commands.append(
        .buildCommand(
          displayName: "Embed Resource (\(identifier))",
          executable: executable,
          arguments: [origin, outputSource, identifier, type],
          inputFiles: [manifestPath, origin],
          outputFiles: [outputSource]
        )
      )
    }
    return commands
  }

  func disambiguate(fileName: String) -> String {
    return "\(fileName) (SDGEmbedResources).swift"
  }
}
