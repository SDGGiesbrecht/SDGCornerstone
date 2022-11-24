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

import SDGLogic
import SDGMathematics
import SDGPersistence

@main struct EmbedResource {

  static func main() throws {
    var arguments = ProcessInfo.processInfo.arguments.dropFirst()
    guard let resourceOrNamespaceSourcePath = arguments.popFirst() else {
      fatalError("No resource path or namespace source path specified (first argument).")
    }
    guard let outputSourcePathOrPackageName = arguments.popFirst() else {
      fatalError("No output source path or package name specified (second argument).")
    }
    guard let identifierOrTargetName = arguments.popFirst() else {
      fatalError("No identifier or target name specified (third argument).")
    }
    guard let type = arguments.popFirst() else {
      try produceMainFile(
        destination: URL(fileURLWithPath: resourceOrNamespaceSourcePath),
        packageName: outputSourcePathOrPackageName,
        targetName: identifierOrTargetName
      )
      return
    }

    try produceAccessor(
      resource: URL(fileURLWithPath: resourceOrNamespaceSourcePath),
      outputSource: URL(fileURLWithPath: outputSourcePathOrPackageName),
      identifier: identifierOrTargetName,
      type: type
    )
  }

  static var imports: String {
    return "import Foundation"
  }

  static func produceMainFile(destination: URL, packageName: String, targetName: String) throws {
    let source = [
      imports,
      "",
      "internal enum Resources {",
      // #workaround(Swift 5.7.1, Standard accessor tripped by symlinks.)
      "  #if !os(WASI)",
      "    internal static let moduleBundle: Bundle = {",
      "      let main = Bundle.main.executableURL?.resolvingSymlinksInPath().deletingLastPathComponent()",
      "      let module = main?.appendingPathComponent(\u{22}\(packageName)_\(targetName).bundle\u{22})",
      "      return module.flatMap({ Bundle(url: $0) }) ?? Bundle.module",
      "    }()",
      "  #endif",
      "}",
    ].joined(separator: "\n")
    try? FileManager.default.removeItem(at: destination)
    try source.save(to: destination)
  }

  static func produceAccessor(
    resource: URL,
    outputSource: URL,
    identifier: String,
    type: String
  ) throws {
    let initializer: String
    switch type {
    case "Data":
      initializer = "data"
    case "String":
      initializer = "String(data: data, encoding: String.Encoding.utf8)!"
    default:
      fatalError("An unsupported type was specified: \(type)")
    }

    let name = resource.deletingPathExtension().lastPathComponent
    let possibleExtension = resource.pathExtension
    let `extension` = possibleExtension == "" ? "nil" : "\u{22}\(possibleExtension)\u{22}"

    let data = try Data(from: resource)
    // #workaround(Swift 5.7.1, The compiler hangs for some platforms if long literals are used.
    let problematicLength: Int = 2 ↑ 15
    var unprocessed: Data.SubSequence = data[...]
    var sections: [Data.SubSequence] = []
    while ¬unprocessed.isEmpty {
      let prefix = unprocessed.prefix(problematicLength)
      sections.append(prefix)
      unprocessed.removeFirst(prefix.count)
    }
    let sectionVariables: [String] = sections.enumerated().lazy.map({ index, section in
      let byteArray = section.lazy
        .map({ byte in
          return "0x\(String(byte, radix: 16, uppercase: true))"
        })
        .joined(separator: ", ")
      let variable = "\(identifier)\(index)"
      return "private static let \(variable): [UInt8] = [\(byteArray)]"
    })

    let variableList: String = (0..<sectionVariables.count).lazy.map({ index in
      return "\(identifier)\(index)"
    }).joined(separator: ", ")

    let source = [
      imports,
      "",
      "extension Resources {",
      // #workaround(Swift 5.7, Some platforms do not support bundled resources yet.)
      "  #if os(WASI)",
      "    \(sectionVariables.joined(separator: "\n    "))",
      "    internal static var \(identifier): \(type) {",
      "      let data = Data(([\(variableList)] as [[UInt8]]).lazy.joined())",
      "      return \(initializer)",
      "    }",
      "  #else",
      "    internal static var \(identifier): \(type) {",
      "      let url = moduleBundle.url(forResource: \u{22}\(name)\u{22}, withExtension: \(`extension`))!",
      "      let data = try! Data(contentsOf: url, options: [.mappedIfSafe])",
      "      return \(initializer)",
      "    }",
      "  #endif",
      "}"
    ].joined(separator: "\n")
    try? FileManager.default.removeItem(at: outputSource)
    try source.save(to: outputSource)
  }
}
