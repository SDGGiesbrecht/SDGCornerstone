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
public struct LineView<Base : StringFamily> : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection, RangeReplaceableCollection where Base.ScalarView.Iterator.Element == UnicodeScalar /* [_Workaround: The where statement is redundant. Once the constraint can be added to the protocol, it should be removed here. (Swift 3.1.0)_] */ {

    // MARK: - Initialization

    internal init(_ base: Base) {
        self.base = base
        normalizedLines = LineView<Base>.parseLines(from: base)
    }

    // MARK: - Parsing

    private static func parseLines(from base: Base) -> [Line<Base>] {
        let newlinePattern: Pattern<UnicodeScalar> = AlternativePatterns([
            LiteralPattern("\u{D}\u{A}".scalars), // CR + LF
            ConditionalPattern(condition: { $0 ∈ CharacterSet.newlines })
            ])

        let newlines = base.scalars.matches(for: newlinePattern).map() { $0.range }
        let lines = base.scalars.ranges(separatedBy: newlines)
        var result: [Line<Base>] = []
        for index in newlines.indices {
            let line = Base(Base.ScalarView(base.scalars[lines[index]]))
            let newline = Base(Base.ScalarView(base.scalars[newlines[index]]))
            result.append(Line(line: line, newline: newline))
        }
        if newlines.last?.upperBound ≠ base.scalars.endIndex {
            guard let last = lines.last else {
                unreachable()
            }
            let line = Base(Base.ScalarView(base.scalars[last]))
            let newline = Base()
            result.append(Line(line: line, newline: newline))
        }
        return result
    }

    private static func assembleBase(from lines: [Line<Base>]) -> Base {
        var result = Base()
        for line in lines {
            result.scalars.append(contentsOf: line.line.scalars)
            result.scalars.append(contentsOf: line.newline.scalars)
        }
        return result
    }

    // MARK: - Properties

    internal var base: Base

    private var normalizedLines: [Line<Base>]
    private var lines: [Line<Base>] {
        get {
            return normalizedLines
        }
        set {
            base = LineView<Base>.assembleBase(from: newValue)
            normalizedLines = LineView<Base>.parseLines(from: base)
        }
    }

    // MARK: - BidirectionalCollection

    // [_Inherit Documentation: SDGCornerstone.Collection.index(before:)_]
    public func index(before i: Index) -> Index {
        return Index(i.value − 1)
    }

    // MARK: - Collection

    // [_Inherit Documentation: SDGCornerstone.Collection.Indices_]
    public typealias Indices = DefaultRandomAccessIndices<LineView>

    // [_Inherit Documentation: SDGCornerstone.Collection.startIndex_]
    /// The position of the first element in a non‐empty collection.
    public let startIndex = Index(0)

    // [_Inherit Documentation: SDGCornerstone.Collection.endIndex_]
    /// The position following the last valid index.
    public var endIndex: Index {
        return Index(lines.endIndex)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.index(after:)_]
    public func index(after i: Index) -> Index {
        return Index(i.value + 1)
    }

    // [_Inherit Documentation: SDGCornerstone.Collection.subscript(position:)_]
    public subscript(_ position: Index) -> Line<Base> {
        get {
            return lines[position.value]
        }
        set {
            lines[position.value] = newValue
        }
    }

    // MARK: - RangeReplaceableCollection

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init()_]
    /// Creates a new, empty collection.
    public init() {
        base = Base()
        normalizedLines = LineView<Base>.parseLines(from: base)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.init(_:)_]
    /// Creates a new instance of a collection containing the elements of a sequence.
    public init<S : Sequence>(_ elements: S) where S.Iterator.Element == Line<Base> {
        self.init()
        lines = [Line<Base>](elements)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.append(contentsOf:)_]
    /// Appends the contents of the sequence to the end of the collection.
    public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Iterator.Element == Line<Base> {
        lines.append(contentsOf: [Line<Base>](newElements))
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.insert(contentsOf:at:)_]
    /// Inserts the contents of the sequence to the specified index.
    public mutating func insert<S : Sequence>(contentsOf newElements: S, at i: Index) where S.Iterator.Element == Line<Base> {
        lines.insert(contentsOf: [Line<Base>](newElements), at: i.value)
    }

    // [_Inherit Documentation: SDGCornerstone.RangeReplaceableCollection.replaceSubrange(_:with:)_]
    /// Replaces the specified subrange of elements with the given collection.
    public mutating func replaceSubrange<S : Sequence>(_ subrange: Range<Index>, with newElements: S) where S.Iterator.Element == Line<Base> {
        lines.replaceSubrange(subrange.lowerBound.value ..< subrange.upperBound.value, with: [Line<Base>](newElements))
    }
}
