/*
 OperatorFunctions.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

private func duplicate(
  definition anchor: CollationTailoring.Anchor,
  for new: StrictString
) -> CollationTailoring.Anchor {
  return anchor.stacking(
    mutation: { collation in
      collation.rules[new] = anchor.cursor(collation)
    },
    cursor: anchor.cursor
  )
}

private func add(
  circumfix: @escaping (CollationOrder) -> (`prefix`: CollationElement, suffix: CollationElement),
  to new: StrictString,
  basedOn anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  let newElement: (CollationOrder) -> [CollationElement] = { collation in
    let resolvedCircumfix = circumfix(collation)
    return [resolvedCircumfix.prefix] + anchor.cursor(collation) + [resolvedCircumfix.suffix]
  }
  return anchor.stacking(
    mutation: { collation in
      collation.rules[new] = newElement(collation)
    },
    cursor: newElement
  )
}

/// Moves the following operand to be the same as the preceding operand up until the scalar level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←= (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return duplicate(definition: anchor, for: new)
}

/// Moves the preceding operand to be the same as the following up until the scalar level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func =→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return duplicate(definition: anchor, for: new)
}

/// Moves the following operand so that it comes after the preceding operand at the primary level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←< (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.afterIndex, at: .primary)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the preceding operand so that it comes before the following operand at the primary level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func <→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.beforeIndex, at: .primary)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the following operand so that it comes after the preceding operand at the reverse accent level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←<< (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.afterIndex, at: .accentsInReverse)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the preceding operand so that it comes before the following operand at the reverse accent level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func <<→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.beforeIndex, at: .accentsInReverse)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the following operand so that it comes after the preceding operand at the forward accent level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←<<< (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.afterIndex, at: .accentsForward)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the preceding operand so that it comes before the following operand at the forward accent level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func <<<→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.beforeIndex, at: .accentsForward)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the following operand so that it comes after the preceding operand at the case level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←<<<< (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.afterIndex, at: .case)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the preceding operand so that it comes before the following operand at the case level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func <<<<→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.beforeIndex, at: .case)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the following operand so that it comes after the preceding operand at the punctuation level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←<<<<< (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.afterIndex, at: .punctuation)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the preceding operand so that it comes before the following operand at the punctuation level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func <<<<<→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.beforeIndex, at: .punctuation)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the following operand so that it comes after the preceding operand at the script level.
///
/// - Parameters:
///   - anchor: The anchor for the rule.
///   - new: The new element.
@discardableResult public func ←<<<<<< (
  anchor: CollationTailoring.Anchor,
  new: StrictString
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.afterIndex, at: .script)
    },
    to: new,
    basedOn: anchor
  )
}

/// Moves the preceding operand so that it comes before the following operand at the script level.
///
/// - Parameters:
///   - new: The new element.
///   - anchor: The anchor for the rule.
@discardableResult public func <<<<<<→ (
  new: StrictString,
  anchor: CollationTailoring.Anchor
) -> CollationTailoring.Anchor {
  return add(
    circumfix: { collation in
      return CollationElement.relative(index: collation.beforeIndex, at: .script)
    },
    to: new,
    basedOn: anchor
  )
}
