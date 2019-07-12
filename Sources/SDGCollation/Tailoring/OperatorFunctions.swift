/*
 OperatorFunctions.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

/// Creates an anchor from a base string.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor string.
public postfix func *(anchor: StrictString) -> CollationTailoringAnchor { // @exempt(from: unicode)
    return CollationTailoringAnchor(tailoringRoot!.contextualMapping.map(anchor))
}

private func duplicate(definition anchor: CollationTailoringAnchor, for new: StrictString) -> CollationTailoringAnchor {
    tailoringRoot!.rules[new] = anchor.elements
    return anchor
}

private func add(
    circumfix: (prefix: CollationElement, suffix: CollationElement),
    to new: StrictString,
    basedOn anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {

    let newElement: [CollationElement] = [circumfix.prefix] + anchor.elements + [circumfix.suffix]
    tailoringRoot!.rules[new] = newElement
    return CollationTailoringAnchor(newElement)
}

/// Moves the following operand to be the same as the preceding operand up until the scalar level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←=(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return duplicate(definition: anchor, for: new)
}

/// Moves the preceding operand to be the same as the following up until the scalar level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func =→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return duplicate(definition: anchor, for: new)
}

/// Moves the following operand so that it comes after the preceding operand at the primary level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←<(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.afterIndex, at: .primary),
        to: new,
        basedOn: anchor)
}

/// Moves the preceding operand so that it comes before the following operand at the primary level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func <→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.beforeIndex, at: .primary),
        to: new,
        basedOn: anchor)
}

/// Moves the following operand so that it comes after the preceding operand at the reverse accent level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←<<(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.afterIndex, at: .accentsInReverse),
        to: new,
        basedOn: anchor)
}

/// Moves the preceding operand so that it comes before the following operand at the reverse accent level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func <<→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.beforeIndex, at: .accentsInReverse),
        to: new,
        basedOn: anchor)
}

/// Moves the following operand so that it comes after the preceding operand at the forward accent level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←<<<(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.afterIndex, at: .accentsForward),
        to: new,
        basedOn: anchor)
}

/// Moves the preceding operand so that it comes before the following operand at the forward accent level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func <<<→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.beforeIndex, at: .accentsForward),
        to: new,
        basedOn: anchor)
}

/// Moves the following operand so that it comes after the preceding operand at the case level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←<<<<(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.afterIndex, at: .case),
        to: new,
        basedOn: anchor)
}

/// Moves the preceding operand so that it comes before the following operand at the case level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func <<<<→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.beforeIndex, at: .case),
        to: new,
        basedOn: anchor)
}

/// Moves the following operand so that it comes after the preceding operand at the punctuation level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←<<<<<(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.afterIndex, at: .punctuation),
        to: new,
        basedOn: anchor)
}

/// Moves the preceding operand so that it comes before the following operand at the punctuation level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func <<<<<→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.beforeIndex, at: .punctuation),
        to: new,
        basedOn: anchor)
}

/// Moves the following operand so that it comes after the preceding operand at the script level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - anchor: The anchor for the rule.
///     - new: The new element.
@discardableResult public func ←<<<<<<(anchor: CollationTailoringAnchor, new: StrictString) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.afterIndex, at: .script),
        to: new,
        basedOn: anchor)
}

/// Moves the preceding operand so that it comes before the following operand at the script level.
///
/// - Warning: This function can only be used inside a `tailored(accordingTo:)` closure.
///
/// - Parameters:
///     - new: The new element.
///     - anchor: The anchor for the rule.
@discardableResult public func <<<<<<→(new: StrictString, anchor: CollationTailoringAnchor) -> CollationTailoringAnchor {
    return add(
        circumfix: CollationElement.relative(index: tailoringRoot!.beforeIndex, at: .script),
        to: new,
        basedOn: anchor)
}
