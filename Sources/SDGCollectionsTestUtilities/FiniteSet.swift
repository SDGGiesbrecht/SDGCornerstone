/*
 FiniteSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGTesting

/// Tests a type’s conformance to FiniteSet.
///
/// - Parameters:
///     - set: A set.
///     - member: A member of the set.
///     - nonmember: A nonmember of the set.
///     - superset: Another set which is a superset of `set`.
///     - overlapping: Another set which overlaps `set`.
///     - disjoint: Another set which is disjoint with `set`.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testFiniteSetConformance<T>(
  of set: T,
  member: T.Element,
  nonmember: T.Element,
  superset: T,
  overlapping: T,
  disjoint: T,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: FiniteSet, T.Element: Hashable {

  testComparableSetConformance(
    of: set,
    member: member,
    nonmember: nonmember,
    superset: superset,
    overlapping: overlapping,
    disjoint: disjoint,
    file: file,
    line: line
  )

  test(operator: (⊆, "⊆"), on: (set, set ∪ Set([nonmember])), returns: true, file: file, line: line)
  test(operator: (⊆, "⊆"), on: (set, set ∖ Set([member])), returns: false, file: file, line: line)
  test(operator: (⊆, "⊆"), on: (set, set ∖ Set([nonmember])), returns: true, file: file, line: line)

  test(
    operator: (⊈, "⊈"),
    on: (set, set ∪ Set([nonmember])),
    returns: false,
    file: file,
    line: line
  )
  test(operator: (⊈, "⊈"), on: (set, set ∖ Set([member])), returns: true, file: file, line: line)
  test(
    operator: (⊈, "⊈"),
    on: (set, set ∖ Set([nonmember])),
    returns: false,
    file: file,
    line: line
  )

  test(
    method: (T.overlaps, "overlaps"),
    of: set,
    with: set ∪ Set([nonmember]),
    returns: true,
    file: file,
    line: line
  )
  test(
    method: (T.overlaps, "overlaps"),
    of: set,
    with: set ∖ set,
    returns: false,
    file: file,
    line: line
  )
  test(
    method: (T.overlaps, "overlaps"),
    of: set,
    with: set ∪ Set([]),
    returns: true,
    file: file,
    line: line
  )

  func testGeneric<S>(set genericSet: S, superset genericSuperset: S, disjoint genericDisjoint: S)
  where S: FiniteSet, S.Element == T.Element {
    test(operator: (⊊, "⊊"), on: (set, genericSuperset), returns: true, file: file, line: line)
    test(operator: (⊊, "⊊"), on: (superset, genericSet), returns: false, file: file, line: line)
    test(operator: (⊊, "⊊"), on: (set, genericSet), returns: false, file: file, line: line)

    test(operator: (⊋, "⊋"), on: (genericSet, superset), returns: false, file: file, line: line)
    test(operator: (⊋, "⊋"), on: (genericSuperset, set), returns: true, file: file, line: line)
    test(operator: (⊋, "⊋"), on: (genericSet, set), returns: false, file: file, line: line)

    test(operator: (==, "=="), on: (set, genericSet), returns: true, file: file, line: line)
    test(operator: (==, "=="), on: (set, genericSuperset), returns: false, file: file, line: line)

    test(operator: (≠, "≠"), on: (set, genericSet), returns: false, file: file, line: line)
    test(operator: (≠, "≠"), on: (set, genericSuperset), returns: true, file: file, line: line)

    test(
      method: (T.isDisjoint, "isDisjoint"),
      of: set,
      with: genericDisjoint,
      returns: true,
      file: file,
      line: line
    )
    test(
      method: (T.isDisjoint, "isDisjoint"),
      of: set,
      with: genericSuperset,
      returns: false,
      file: file,
      line: line
    )
    test(
      method: (T.isDisjoint, "isDisjoint"),
      of: set,
      with: genericSet,
      returns: false,
      file: file,
      line: line
    )
  }
  testGeneric(set: set, superset: superset, disjoint: disjoint)
}
