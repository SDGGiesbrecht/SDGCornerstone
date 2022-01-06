/*
 LineView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections

/// A view of a string’s contents as a collection of lines.
public struct LineView<Base: StringFamily>: BidirectionalCollection, Collection, MutableCollection,
  RangeReplaceableCollection, TextualPlaygroundDisplay
{

  // MARK: - Initialization

  @inlinable internal init(_ base: Base) {
    self.base = base
    startIndex = Index(start: base.scalars.startIndex)
  }

  // MARK: - Properties

  @usableFromInline internal var base: Base

  // MARK: - Conversions

  @inlinable internal func line(for scalar: String.ScalarView.Index) -> LineViewIndex {
    if scalar == base.scalars.endIndex {
      return endIndex
    }
    guard var previousNewline = base.scalars[..<scalar].lastMatch(for: NewlinePattern.newline)
    else {
      return startIndex
    }

    var encounteredNewline: Range<String.ScalarView.Index>?
    if let newline = NewlinePattern.newline.primaryMatch(
      in: base.scalars,
      at: previousNewline.range.lowerBound
    ),
      newline.contains(scalar)
    {
      // Between CR and LF

      guard
        let actualPreviousNewline = base.scalars[..<newline.lowerBound].lastMatch(
          for: NewlinePattern.newline
        )
      else {
        return startIndex
      }

      previousNewline = actualPreviousNewline
      encounteredNewline = newline
    }

    return Index(start: previousNewline.range.upperBound, newline: encounteredNewline)
  }

  // MARK: - BidirectionalCollection

  @inlinable public func index(before i: LineViewIndex) -> LineViewIndex {

    let newline: Range<String.ScalarView.Index>
    if i == endIndex {
      newline = base.scalars.endIndex..<base.scalars.endIndex
    } else {
      let searchEnd = i.start ?? base.scalars.endIndex  // @exempt(from: tests)
      // `nil` ought to have been handled by “if i == endIndex” above.
      guard
        let found = base.scalars[..<searchEnd].lastMatch(
          for: NewlinePattern.newline
        )?.range
      else {
        _preconditionFailure({ (localization: _APILocalization) -> String in
          switch localization {
          case .englishCanada:  // @exempt(from: tests)
            return "No index precedes the start index."
          }
        })
      }
      newline = found
    }

    guard
      let previousNewline = base.scalars[..<newline.lowerBound].lastMatch(
        for: NewlinePattern.newline
      )?.range
    else {
      startIndex.cache.newline = newline
      return startIndex
    }
    return LineViewIndex(start: previousNewline.upperBound, newline: newline)
  }

  // MARK: - Collection

  public typealias Indices = DefaultIndices<LineView>

  public let startIndex: LineViewIndex

  public let endIndex: LineViewIndex = LineViewIndex.endIndex()

  @inlinable public func index(after i: LineViewIndex) -> LineViewIndex {
    guard let newline = i.newline(in: base.scalars),
      ¬newline.isEmpty
    else {
      return LineViewIndex.endIndex()
    }
    return LineViewIndex(start: newline.upperBound)
  }

  @inlinable public subscript(_ position: LineViewIndex) -> Line<Base> {
    get {
      let newline = position.newline(in: base.scalars)!
      let line = base.scalars[position.start!..<newline.lowerBound]
      return Line(line: line, newline: base.scalars[newline])
    }
    set {
      let replacement = Base.ScalarView(newValue.line) + Base.ScalarView(newValue.newline)
      if let replacementStart = position.start {
        base.scalars.replaceSubrange(
          replacementStart..<position.newline(in: base.scalars)!.upperBound,
          with: replacement
        )
      } else {
        base.scalars.append(contentsOf: replacement)
      }
    }
  }

  // MARK: - RangeReplaceableCollection

  @inlinable public init() {
    self.init(Base())
  }

  @inlinable public mutating func replaceSubrange<S: Sequence>(
    _ subrange: Range<Index>,
    with newElements: S
  ) where S.Element == Line<Base> {
    var replacement = Base()
    for line in newElements {
      replacement.scalars.append(contentsOf: line.line)
      replacement.scalars.append(contentsOf: line.newline)
    }
    let replacementStart = subrange.lowerBound.start ?? base.scalars.endIndex
    let replacementEnd = subrange.upperBound.start ?? base.scalars.endIndex
    base.scalars.replaceSubrange(replacementStart..<replacementEnd, with: replacement.scalars)
  }

  // MARK: - CustomStringConvertible

  @inlinable public var description: String {
    return String(describing: base)
  }
}
