/*
 Range.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Range where Bound == LineViewIndex {

  // #warning(Temporary)
  #if false
  /// Returns the range in the given view of scalars that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func sameRange(in scalars: StrictString.ScalarView) -> Range<StrictString.Index>
  {
    return map { $0.samePosition(in: scalars) }
  }
  #endif

  /// Returns the range in the given view of scalars that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func sameRange(in scalars: String.ScalarView) -> Range<String.Index> {
    return map { $0.samePosition(in: scalars) }
  }

  // #warning(Temporary)
  #if false
  /// Returns the range in the given view of clusters that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func sameRange(in clusters: StrictString.ClusterView) -> Range<
    StrictString.Index
  > {
    return map { $0.samePosition(in: clusters) }
  }
  #endif

  /// Returns the range in the given view of clusters that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func sameRange(in clusters: String.ClusterView) -> Range<String.Index> {
    return map { $0.samePosition(in: clusters) }
  }
}

extension Range where Bound == String.Index {

  @inlinable internal func map<B>(
    convertAndRoundDown: (Bound) -> B,
    convertIfPossible: (Bound) -> B?,
    advance: (B) -> B
  ) -> Range<B> {

    let lower = convertAndRoundDown(lowerBound)
    if let upper = convertIfPossible(upperBound) {
      return lower..<upper
    } else {
      return lower..<advance(convertAndRoundDown(upperBound))
    }
  }

  // @documentation(Range.sameRange(in scalars:))
  /// Returns the range in the given view of scalars that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func sameRange(in scalars: String.ScalarView) -> Range<String.Index>? {
    return map { $0.samePosition(in: scalars) }
  }

  // #warning(Temporary)
  #if false
  // #documentation(Range.sameRange(in scalars:))
  /// Returns the range in the given view of scalars that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func sameRange(in scalars: StrictString.ScalarView) -> Range<
    StrictString.Index
  >? {
    return map { $0.samePosition(in: scalars) }
  }
  #endif

  // @documentation(Range.scalars(in:))
  /// Returns the range of scalars that contains this range.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func scalars(in scalars: String.ScalarView) -> Range<String.Index> {
    return map(
      convertAndRoundDown: { $0.scalar(in: scalars) },
      convertIfPossible: { $0.samePosition(in: scalars) },
      advance: { scalars.index(after: $0) }
    )
  }

  // #warning(Temporary)
  #if false
  // #documentation(Range.scalars(in:))
  /// Returns the range of scalars that contains this range.
  ///
  /// - Parameters:
  ///     - scalars: The scalar view of the string the range refers to.
  @inlinable public func scalars(in scalars: StrictString.ScalarView) -> Range<StrictString.Index> {
    return map(
      convertAndRoundDown: { $0.scalar(in: scalars) },
      convertIfPossible: { $0.samePosition(in: scalars) },
      advance: { scalars.index(after: $0) }
    )
  }
  #endif

  // @documentation(Range.sameRange(in clusters:))
  /// Returns the range in the given view of clusters that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func sameRange(in clusters: String.ClusterView) -> Range<String.Index>? {
    return map { $0.samePosition(in: clusters) }
  }

  // #warning(Temporary)
  #if false
  // #documentation(Range.sameRange(in clusters:))
  /// Returns the range in the given view of clusters that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func sameRange(in clusters: StrictString.ClusterView) -> Range<
    StrictString.Index
  >? {
    return map { $0.samePosition(in: clusters) }
  }
  #endif

  // @documentation(Range.clusters(in:))
  /// Returns the range of clusters that contains this range.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func clusters(in clusters: String.ClusterView) -> Range<String.Index> {
    return map(
      convertAndRoundDown: { $0.cluster(in: clusters) },
      convertIfPossible: { $0.samePosition(in: clusters) },
      advance: { clusters.index(after: $0) }
    )
  }

  // #warning(Temporary)
  #if false
  // #documentation(Range.clusters(in:))
  /// Returns the range of clusters that contains this range.
  ///
  /// - Parameters:
  ///     - clusters: The cluster view of the string the range refers to.
  @inlinable public func clusters(in clusters: StrictString.ClusterView) -> Range<
    StrictString.Index
  > {
    return map(
      convertAndRoundDown: { $0.cluster(in: clusters) },
      convertIfPossible: { $0.samePosition(in: clusters) },
      advance: { clusters.index(after: $0) }
    )
  }
  #endif

  /// Returns the range in the given view of lines that corresponds exactly to this range.
  ///
  /// - Parameters:
  ///     - lines: The line view of the string the range refers to.
  @inlinable public func sameRange<S>(in lines: LineView<S>) -> Range<LineView<S>.Index>? {
    return map { $0.samePosition(in: lines) }
  }

  /// Returns the range of lines that contains this range.
  ///
  /// - Parameters:
  ///     - lines: The line view of the string the range refers to.
  @inlinable public func lines<S>(in lines: LineView<S>) -> Range<LineView<S>.Index> {
    return map(
      convertAndRoundDown: { $0.line(in: lines) },
      convertIfPossible: { $0.samePosition(in: lines) },
      advance: { lines.index(after: $0) }
    )
  }
}
