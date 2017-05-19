/*
 String.ClusterView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String {

    // [_Workaround: Compiler bugs prevent referencing this typealias. When this is fixed, all references to String.CharacterView should be switched to String.ClusterView. (Swift 3.1.0)_]

    /// A view of a string's contents as a collection of extended grapheme clusters.
    public typealias ClusterView = CharacterView
}

extension String.CharacterView : ExtendedGraphemeClusterView {

}
