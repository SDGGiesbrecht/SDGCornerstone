/*
 LineView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A view of a string’s contents as a collection of lines.
public struct LineView<Base : StringFamily> : BidirectionalCollection, Collection, MutableCollection, RangeReplaceableCollection, TextualPlaygroundDisplay {

    // MARK: - Initialization

    @_inlineable @_versioned internal init(_ base: Base) {
        self.base = base
        startIndex = Index(start: base.scalars.startIndex)
    }

    // MARK: - Properties

    @_versioned internal var base: Base

    // MARK: - Conversions

    @_inlineable @_versioned internal func line(for scalar: String.ScalarView.Index) -> LineViewIndex {
        if scalar == base.scalars.endIndex {
            return endIndex
        }
        guard var previousNewline = base.scalars.lastMatch(for: CharacterSet.newlinePattern, in: base.scalars.startIndex ..< scalar) else {
            return startIndex
        }

        var encounteredNewline: Range<String.ScalarView.Index>?
        if let newline = CharacterSet.newlinePattern.primaryMatch(in: base.scalars, at: previousNewline.range.lowerBound, limitedTo: base.scalars.endIndex),
            newline.contains(scalar) {
            // Between CR and LF

            guard let actualPreviousNewline = base.scalars.lastMatch(for: CharacterSet.newlinePattern, in: base.scalars.startIndex ..< newline.lowerBound) else {
                return startIndex
            }

            previousNewline = actualPreviousNewline
            encounteredNewline = newline
        }

        return Index(start: previousNewline.range.upperBound, newline: encounteredNewline)
    }

    // MARK: - BidirectionalCollection

    // [_Inherit Documentation: SDGCornerstone.BidirectionalCollection.index(before:)_]
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.
    @_specialize(exported: true, where Base == StrictString)
    @_specialize(exported: true, where Base == String)
    @_inlineable public func index(before i: LineViewIndex) -> LineViewIndex {

        let newline: Range<String.ScalarView.Index>
        if i == endIndex {
            newline = base.scalars.endIndex ..< base.scalars.endIndex
        } else {
            guard let found = base.scalars.lastMatch(for: CharacterSet.newlinePattern, in: base.scalars.startIndex ..< (i.start ?? base.scalars.endIndex))?.range else {
                _preconditionFailure({ (localization: _APILocalization) -> String in
                    switch localization {
                    case .englishCanada: // [_Exempt from Test Coverage_]
                        return "No index precedes the start index."
                    }
                })
            }
            newline = found
        }

        guard let previousNewline = base.scalars.lastMatch(for: CharacterSet.newlinePattern, in: base.scalars.startIndex ..< newline.lowerBound)?.range else {
            startIndex.cache.newline = newline
            return startIndex
        }
        return LineViewIndex(start: previousNewline.upperBound, newline: newline)
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.Indices_]
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.
    public typealias Indices = DefaultBidirectionalIndices<LineView>

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.
    public let startIndex: LineViewIndex

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.
    public let endIndex: LineViewIndex = LineViewIndex.endIndex()

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    @_specialize(exported: true, where Base == StrictString)
    @_specialize(exported: true, where Base == String)
    @_inlineable public func index(after i: LineViewIndex) -> LineViewIndex {
        guard let newline = i.newline(in: base.scalars),
            ¬newline.isEmpty else {
                return LineViewIndex.endIndex()
        }
        return LineViewIndex(start: newline.upperBound)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    /// Accesses the element at the specified position.
    @_inlineable public subscript(_ position: LineViewIndex) -> Line<Base> {
        @_specialize(exported: true, where Base == StrictString)
        @_specialize(exported: true, where Base == String)
        get {
            let newline = position.newline(in: base.scalars)!
            let line = base.scalars[position.start! ..< newline.lowerBound]
            return Line(line: line, newline: base.scalars[newline])
        }
        @_specialize(exported: true, where Base == StrictString)
        @_specialize(exported: true, where Base == String)
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

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.
    @_specialize(exported: true, where Base == StrictString)
    @_specialize(exported: true, where Base == String)
    @_inlineable public init() {
        self.init(Base())
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.
    @_specialize(exported: true, kind: partial, where Base == StrictString)
    @_specialize(exported: true, kind: partial, where Base == String)
    @_inlineable public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<Index>, with newElements: S) where S.Element == Line<Base> {
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

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return String(describing: base)
    }
}
