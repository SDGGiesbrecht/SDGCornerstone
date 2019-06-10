/*
 SemanticMarkupStringInterpolation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SemanticMarkup {

    /// The type which handles interpolation of semantic markup.
    public struct StringInterpolation : StrictStringInterpolationProtocol {

        /// The semantic markup.
        public var semanticMarkup: SemanticMarkup {
            return SemanticMarkup.init(string)
        }

        // MARK: - StrictStringInterpolationProtocol

        public init(string: StrictString) {
            self.string = string
        }

        public var string: StrictString

        // MARK: - StringInterpolationProtocol

        public mutating func appendInterpolation(_ markup: SemanticMarkup) {
            appendInterpolation(markup.source)
        }

        public mutating func appendInterpolation(_ markup: SemanticMarkup.SubSequence) {
            appendInterpolation(SemanticMarkup(markup).source)
        }
    }
}
