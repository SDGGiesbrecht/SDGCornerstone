/*
 CharacterSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, Web doesn’t have foundation yet.)
#if !os(WASI)
  import Foundation

  extension CharacterSet {

    /// A pattern representing any newline variant.
    public static var newlinePattern: NewlinePattern { .newline }
  }
#endif
