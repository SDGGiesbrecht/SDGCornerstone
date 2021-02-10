/*
 CustomXMLRepresentable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

/// A type with a customized XML representation.
public protocol CustomXMLRepresentable {

  /// A DTD declaration to use when encoding the type as a root element.
  ///
  /// The property is ignored when the type is not the top‐level value.
  var dtd: XML.DTD? { get }

  /// An name to be used when the encoding the type in situations where the element name is not already dictated by an encoding key.
  ///
  /// This property takes effect when the type is encoded...
  ///
  /// - as a root element, or
  /// - in an unkeyed container.
  ///
  /// This property is ignored when the type is encoded under a particular coding key.
  var defaultElementName: StrictString? { get }
}

extension CustomXMLRepresentable {

  public var dtd: XML.DTD? {
    return nil
  }

  public var defaultElementName: StrictString? {
    return nil
  }
}
