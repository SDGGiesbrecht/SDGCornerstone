/*
 String.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if canImport(Foundation)
  import Foundation
#endif

import SDGControlFlow

extension String: FileConvertible {

  // MARK: - FileConvertible

  public init(file: Data, origin: URL?) throws {

    // Let Foundation try...
    if let url = origin {
      var encoding: String.Encoding = .utf8
      if let string = try? String(contentsOf: url, usedEncoding: &encoding) {
        if string.data(using: encoding, allowLossyConversion: false) == file {
          // Only initialize from the underlying file if it matches the data provided.
          self = string
        }
      }
    }

    // Guess blindly...

    if let string = String(data: file, encoding: .utf8) {
      self = string
    } else if let string = String(data: file, encoding: .utf16) {
      self = string
    } else if let string = String(data: file, encoding: .utf32) {  // @exempt(from: tests)
      // macOS does not fail UTF‐16 on invalid surrogate use, so this is unreachable.
      self = string
    } else if let string = String(data: file, encoding: .isoLatin1) {  // @exempt(from: tests)
      // macOS does not fail UTF‐16 on invalid surrogate use, so this is unreachable.
      self = string  // @exempt(from: tests)
    } else {
      _unreachable()
    }
  }

  public var file: Data {
    guard let result = data(using: .utf8) else {
      _unreachable()
    }
    return result
  }
}
