/*
 TextDirection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A direction in which natural text is written.
public enum TextDirection : Int, CaseIterable {

    /// Written right‐to‐left, top‐to‐bottom, such as Hebrew, Arabic or Persian.
    case rightToLeftTopToBottom

    /// Written left‐to‐right, top‐to‐bottom, such as Spanish, English or Russian.
    case leftToRightTopToBottom

    /// Written top‐to‐bottom, right‐to‐left, such as Chinese, Japanese or Korean.
    ///
    /// Languages written this way can alternatively be written left‐to‐right, top‐to‐bottom.
    case topToBottomRightToLeft
}
