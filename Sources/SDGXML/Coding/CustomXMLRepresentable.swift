/*
 CustomXMLRepresentable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type with a customized XML representation.
public protocol CustomXMLRepresentable {

  /// A DTD declaration to use when encoding the type as a root element.
  ///
  /// The property is ignored when the type is not the top‐level value.
  var dtd: XML.DTD? { get }
}
