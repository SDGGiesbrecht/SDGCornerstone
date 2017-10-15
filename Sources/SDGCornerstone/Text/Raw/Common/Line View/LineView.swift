/*
 LineView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A view of a string’s contents as a collection of lines.
public struct LineView<Base : StringFamily> : BidirectionalCollection, Collection, MutableCollection, RangeReplaceableCollection where Base.ScalarView.Index == String.UnicodeScalarView.Index /* [_Workaround: This where statement works around an abort trap. See UnicodeScalarView.swift. (Swift 4.0.0)_] */ {

    // MARK: - Initialization

    internal init(_ base: Base) {
        self.base = base
        startIndex = Index(start: base.scalars.startIndex)
    }

    // MARK: - Parsing

    /* [_Workaround: This ought to be simpler, but the generics make it incredibly slow. Once there is a stable way to @specialize the patterns, this should be re‐tried, and the replacement functions at the bottom of this file removed. (Swift 3.1.0)_]
     internal static var newlinePattern: Pattern<UnicodeScalar> {
     return AlternativePatterns([
     LiteralPattern("\u{D}\u{A}".scalars), // CR + LF
     ConditionalPattern(condition: { $0 ∈ CharacterSet.newlines })
     ])
     }*/

    // MARK: - Properties

    internal var base: Base

    // MARK: - Conversions

    internal func line(for scalar: String.ScalarView.Index) -> LineIndex {
        if scalar == base.scalars.endIndex {
            return endIndex
        }
        guard var previousNewline = base.scalars.lastMatch(for: LineView.newlinePattern, in: base.scalars.startIndex ..< scalar) else {
            return startIndex
        }

        var encounteredNewline: Range<String.ScalarView.Index>?
        if let newline = LineView.newlinePattern.primaryMatch(in: base.scalars, at: previousNewline.range.lowerBound),
            newline.contains(scalar) {
            // Between CR and LF

            guard let actualPreviousNewline = base.scalars.lastMatch(for: LineView.newlinePattern, in: base.scalars.startIndex ..< newline.lowerBound) else {
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
    public func index(before i: LineIndex) -> LineIndex {

        let newline: Range<String.ScalarView.Index>
        if i == endIndex {
            newline = base.scalars.endIndex ..< base.scalars.endIndex
        } else {
            guard let found = base.scalars.lastMatch(for: LineView.newlinePattern, in: base.scalars.startIndex ..< (i.start ?? base.scalars.endIndex))?.range else {
                preconditionFailure(UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                    switch localization {
                    case .englishCanada: // [_Exempt from Code Coverage_]
                        return "No index precedes the start index."
                    }
                }))
            }
            newline = found
        }

        guard let previousNewline = base.scalars.lastMatch(for: LineView.newlinePattern, in: base.scalars.startIndex ..< newline.lowerBound)?.range else {
            startIndex.cache.newline = newline
            return startIndex
        }
        return LineIndex(start: previousNewline.upperBound, newline: newline)
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.Indices_]
    /// The type that represents the indices that are valid for subscripting the collection, in ascending order.
    public typealias Indices = DefaultBidirectionalIndices<LineView>

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.
    public let startIndex: LineIndex

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.
    public let endIndex: LineIndex = LineIndex.endIndex()

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    /// Returns the index immediately after the specified index.
    ///
    /// - Parameters:
    ///     - i: The preceding index.
    public func index(after i: LineIndex) -> LineIndex {
        guard let newline = i.newline(in: base.scalars),
            ¬newline.isEmpty else {
                return LineIndex.endIndex()
        }
        return LineIndex(start: newline.upperBound)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    /// Accesses the element at the specified position.
    public subscript(_ position: LineIndex) -> Line<Base> {
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

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.
    public init() {
        self.init(Base())
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.
    public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<Index>, with newElements: S) where S.Element == Line<Base> {
        var replacement = Base()
        for line in newElements {
            replacement.scalars.append(contentsOf: line.line)
            replacement.scalars.append(contentsOf: line.newline)
        }
        let replacementStart = subrange.lowerBound.start ?? base.scalars.endIndex
        let replacementEnd = subrange.upperBound.start ?? base.scalars.endIndex
        base.scalars.replaceSubrange(replacementStart ..< replacementEnd, with: replacement.scalars)
    }
}

// [_Workaround: See “Parsing” above. (Swift 3.1.0)_]

extension LineView {

    internal static var newlinePattern: NewlinePattern {
        return NewlinePattern()
    }
}

internal struct NewlinePattern {

    fileprivate static let carriageReturn: UnicodeScalar = "\u{D}"
    fileprivate static let lineFeed: UnicodeScalar = "\u{A}"

    fileprivate init() {}

    fileprivate func primaryMatch<S : UnicodeScalarView>(in collection: S, at location: String.ScalarView.Index) -> Range<String.ScalarView.Index>? where S.Index == String.ScalarView.Index {
        // Replacement for Pattern.primaryMatch(in:at:)

        guard location ≠ collection.endIndex else { // [_Exempt from Code Coverage_] Internal, unused, and temporary.
            return nil
        }

        let scalar = collection[location]
        guard scalar ∈ CharacterSet.newlines else { // [_Exempt from Code Coverage_] Internal, unused, and temporary.
            return nil
        }

        if scalar == NewlinePattern.carriageReturn,
            location ≠ collection.endIndex,
            collection[collection.index(after: location)] == NewlinePattern.lineFeed {
            return location ..< collection.index(location, offsetBy: 2)
        } else {
            return location ..< collection.index(after: location)
        }
    }
}

extension UnicodeScalarView where Self.Index == String.ScalarView.Index {
    // MARK: - where Self.Index == String.ScalarView.Index

    internal func firstMatch(for pattern: NewlinePattern, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        // Replacement for Collection.firstMatch(for:in:)

        let searchRange = searchRange ?? bounds // [_Exempt from Code Coverage_] Internal, unused, and temporary.

        var index = searchRange.lowerBound
        while index ≠ searchRange.upperBound {
            let nextIndex = self.index(after: index)

            let scalar = self[index]
            if scalar ∈ CharacterSet.newlines {
                if scalar == NewlinePattern.carriageReturn,
                    nextIndex ≠ endIndex,
                    self[nextIndex] == NewlinePattern.lineFeed {
                    return PatternMatch(range: index ..< self.index(after: nextIndex), in: self)
                } else {
                    return PatternMatch(range: index ..< nextIndex, in: self)
                }
            }

            index = nextIndex
        }
        return nil
    }

    fileprivate func lastMatch(for pattern: NewlinePattern, in searchRange: Range<Index>? = nil) -> PatternMatch<Self>? {
        // Replacement for Collection.lastMatch(for:in:)

        let searchRange = searchRange ?? bounds // [_Exempt from Code Coverage_] Internal, unused, and temporary.

        guard ¬searchRange.isEmpty else {
            return nil
        }

        var nextIndex = searchRange.upperBound
        while nextIndex ≠ searchRange.lowerBound {
            let index = self.index(before: nextIndex)

            let scalar = self[index]
            if scalar ∈ CharacterSet.newlines {
                if scalar == NewlinePattern.lineFeed,
                    index ≠ searchRange.lowerBound,
                    self[self.index(before: index)] == NewlinePattern.carriageReturn {
                    return PatternMatch(range: self.index(before: index) ..< nextIndex, in: self)
                } else {
                    return PatternMatch(range: index ..< nextIndex, in: self)
                }
            }

            nextIndex = index
        }
        return nil
    }
}
