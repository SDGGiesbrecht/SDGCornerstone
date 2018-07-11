/*
 MarkupPlaygroundDisplay.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A type which displays its rich text description in playgrounds.
///
/// Conformance Requirements:
///
/// - `func playgroundDescriptionMarkup() -> SemanticMarkup`
public protocol MarkupPlaygroundDisplay : TextualPlaygroundDisplay {

    // @documentation(SDGCornerstone.MarkupPlaygroundDisplay.playgroundDescriptionMarkup())
    /// The markup representation of the instance.
    func playgroundDescriptionMarkup() -> SemanticMarkup
}

extension MarkupPlaygroundDisplay {

    // MARK: - CustomPlaygroundDisplayConvertible

    // #documentation(SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription)
    /// Returns the custom playground description for this instance.
    @_inlineable public var playgroundDescription: Any {
        return playgroundDescriptionMarkup()
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return String(playgroundDescriptionMarkup().rawTextApproximation())
    }
}
