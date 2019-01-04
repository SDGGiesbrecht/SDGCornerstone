/*
 LineView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A view of a string’s contents as a collection of lines.
public struct LineView<Base : StringFamily> : BidirectionalCollection, Collection, MutableCollection, RangeReplaceableCollection, TextualPlaygroundDisplay {

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
        guard var previousNewline = base.scalars[..<scalar].lastMatch(for: CharacterSet.newlinePattern) else {
            return startIndex
        }

        var encounteredNewline: Range<String.ScalarView.Index>?
        if let newline = CharacterSet.newlinePattern.primaryMatch(in: base.scalars, at: previousNewline.range.lowerBound),
            newline.contains(scalar) {
            // Between CR and LF

            guard let actualPreviousNewline = base.scalars[..<newline.lowerBound].lastMatch(for: CharacterSet.newlinePattern) else {
                return startIndex
            }

            previousNewline = actualPreviousNewline
            encounteredNewline = newline
        }

        return Index(start: previousNewline.range.upperBound, newline: encounteredNewline)
    }

    // MARK: - BidirectionalCollection

    // #documentation(SDGCornerstone.BidirectionalCollection.index(before:))
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    @inlinable public func index(before i: LineViewIndex) -> LineViewIndex {

        let newline: Range<String.ScalarView.Index>
        if i == endIndex {
            newline = base.scalars.endIndex ..< base.scalars.endIndex
        } else {
            guard let found = base.scalars[..<(i.start ?? base.scalars.endIndex)].lastMatch(for: CharacterSet.newlinePattern)?.range else {
                _preconditionFailure({ (localization: _APILocalization) -> String in
                    switch localization {
                    case .englishCanada: // @exempt(from: tests)
                        return "No index precedes the start index."
                    }
                })
            }
            newline = found
        }

        guard let previousNewline = base.scalars[..<newline.lowerBound].lastMatch(for: CharacterSet.newlinePattern)?.range else {
            startIndex.cache.newline = newline
            return startIndex
        }
        return LineViewIndex(start: previousNewline.upperBound, newline: newline)
    }

    // MARK: - Collection

    // #documentation(SDGCornerstone.Collection.Indices)
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.
    public typealias Indices = DefaultIndices<LineView>

    // #documentation(SDGCornerstone.Collection.startIndex)
    /// The position of the first element in a non‐empty collection.
    public let startIndex: LineViewIndex

    // #documentation(SDGCornerstone.Collection.endIndex)
    /// The position following the last valid index.
    public let endIndex: LineViewIndex = LineViewIndex.endIndex()

    // #documentation(SDGCornerstone.Collection.index(after:))
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @inlinable public func index(after i: LineViewIndex) -> LineViewIndex {
        guard let newline = i.newline(in: base.scalars),
            ¬newline.isEmpty else {
                return LineViewIndex.endIndex()
        }
        return LineViewIndex(start: newline.upperBound)
    }

    // #documentation(SDGCornerstone.Collection.subscript(position:))
    /// Accesses the element at the specified position.
    @inlinable public subscript(_ position: LineViewIndex) -> Line<Base> {
        get {
            let newline = position.newline(in: base.scalars)!
            let line = base.scalars[position.start! ..< newline.lowerBound]
            return Line(line: line, newline: base.scalars[newline])
        }
        set {
            let replacement = Base.ScalarView(newValue.line) + Base.ScalarView(newValue.newline)
            if let replacementStart = position.start {
                base.scalars.replaceSubrange(replacementStart ..< position.newline(in: base.scalars)!.upperBound, with: replacement)
            } else {
                base.scalars.append(contentsOf: replacement)
            }
        }
    }

    // MARK: - RangeReplaceableCollection

    // #documentation(SDGCornerstone.RangeReplaceableCollection.init())
    /// Creates a new, empty collection.
    @inlinable public init() {
        self.init(Base())
    }

    // #documentation(SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:))
    /// Replaces the specified subrange of elements with the given collection.
    @inlinable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<Index>, with newElements: S) where S.Element == Line<Base> {
        var replacement = Base()
        for line in newElements {
            replacement.scalars.append(contentsOf: line.line)
            replacement.scalars.append(contentsOf: line.newline)
        }
        let replacementStart = subrange.lowerBound.start ?? base.scalars.endIndex
        let replacementEnd = subrange.upperBound.start ?? base.scalars.endIndex
        base.scalars.replaceSubrange(replacementStart ..< replacementEnd, with: replacement.scalars)
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @inlinable public var description: String {
        return String(describing: base)
    }
}
