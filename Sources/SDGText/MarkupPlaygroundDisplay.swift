/*
 MarkupPlaygroundDisplay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type which displays its rich text description in playgrounds.
public protocol MarkupPlaygroundDisplay: TextualPlaygroundDisplay {

  /// The markup representation of the instance.
  func playgroundDescriptionMarkup() -> SemanticMarkup
}

extension MarkupPlaygroundDisplay {

  // MARK: - CustomPlaygroundDisplayConvertible

  public var playgroundDescription: Any {
    return playgroundDescriptionMarkup()
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(playgroundDescriptionMarkup().rawTextApproximation())
  }
}
