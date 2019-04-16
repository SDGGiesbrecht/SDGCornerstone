/*
 SemanticMarkupInterpolation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SemanticMarkup {

    public struct _Interpolation : StrictStringInterpolationProtocol {

        // MARK: - StrictStringInterpolationProtocol

        @inlinable public init(_result result: StrictString) {
            _result = result
        }

        public var _result: StrictString

        // MARK: - StringInterpolationProtocol

        @inlinable public mutating func appendInterpolation(_ markup: SemanticMarkup) {
            appendInterpolation(markup.source)
        }

        @inlinable public mutating func appendInterpolation(_ markup: SemanticMarkup.SubSequence) {
            appendInterpolation(SemanticMarkup(markup).source)
        }
    }
}
