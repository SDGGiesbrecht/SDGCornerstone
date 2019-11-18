/*
 ContextualMapping.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

/// A mapping where the surrounding elements affect the output, and the output can be a different length than the original.
///
/// An example would be spelling to pronounciation: “c” → “k”, but “ce” → “sɛ” and “ch” → “t͡ʃ”. The most specific (longest) match determines the output. Matches cannot overlap.
public struct ContextualMapping<Input, Output>
where Input: Hashable,
  Input: RangeReplaceableCollection,
  Input.Element: Hashable,
  Output: RangeReplaceableCollection
{

  // MARK: - Static Methods

  @inlinable internal static var defaultFallbackAlgorithm: (Input.Element) -> Output {
    return { (input: Input.Element) -> Output in
      _preconditionFailure({ localization in
        switch localization {  // @exempt(from: tests)
        case .englishCanada:
          return "Undefined element: \(String(describing: input))"
        }
      })
    }
  }

  @inlinable internal static func generate(
    mapping rules: [Input: Output],
    fallbackAlgorithm: @escaping (Input.Element) -> Output
  ) -> [Input.Element: ContextualMapping<Input, Output>] {

    var ruleGroups: [Input.Element: (simple: Output?, complex: [Input: Output])] = [:]
    for (input, output) in rules {

      guard let first = input.first else {
        _preconditionFailure({ localization in
          switch localization {
          case .englishCanada:
            return
              "Empty rule input: “\(String(describing: input))” → “\(String(describing: output))”"
          }
        })
      }

      ruleGroups.mutateValue(for: first) { value in
        var ruleGroup = value ?? (simple: nil, complex: [:])
        if input.count == 1 {
          ruleGroup.simple = output
        } else {
          let key = Input(input.dropFirst())
          ruleGroup.complex[key] = output
        }
        return ruleGroup
      }
    }

    var complexMapping: [Input.Element: ContextualMapping<Input, Output>] = [:]
    for (input, outputGroup) in ruleGroups {
      let mapping = ContextualMapping(
        input: input,
        simpleOutput: outputGroup.simple,
        complexMapping: outputGroup.complex,
        fallbackAlgorithm: fallbackAlgorithm
      )
      complexMapping[input] = mapping
    }

    return complexMapping
  }

  /// Creates a contextual mapping from a simple dictionary mapping.
  ///
  /// - Parameters:
  ///     - exhaustiveMapping: A dictionary representing the mapping. Keys are input, values are corresponding output. The mapping must contain every input element that the contextual mapping will encounter; A precondition will fire if such an undefined element is encountered.
  @inlinable public init(exhaustiveMapping: [Input: Output]) {
    self.init(
      mapping: exhaustiveMapping,
      fallbackAlgorithm: ContextualMapping.defaultFallbackAlgorithm
    )
  }

  /// Creates a contextual mapping from a simple dictionary mapping and a fallback algorithm.
  ///
  /// - Parameters:
  ///     - mapping: A dictionary representing the mapping. Keys are input, values are corresponding output.
  ///     - fallbackAlgorithm: An algorithm to use for any single elements not defined in the mapping.
  ///     - element: The element to use the fallback algorithm on.
  @inlinable public init(
    mapping: [Input: Output],
    fallbackAlgorithm: @escaping (_ element: Input.Element) -> Output
  ) {
    self.simpleOutput = nil
    self.complexMapping = ContextualMapping.generate(
      mapping: mapping,
      fallbackAlgorithm: fallbackAlgorithm
    )
    self.fallbackAlgorithm = fallbackAlgorithm
  }

  @inlinable internal init(
    input: Input.Element,
    simpleOutput: Output?,
    complexMapping: [Input: Output],
    fallbackAlgorithm: @escaping (Input.Element) -> Output
  ) {

    self.simpleOutput = simpleOutput
    self.complexMapping = ContextualMapping.generate(
      mapping: complexMapping,
      fallbackAlgorithm: fallbackAlgorithm
    )
    self.fallbackAlgorithm = fallbackAlgorithm
  }

  // MARK: - Properties

  @usableFromInline internal let simpleOutput: Output?
  @usableFromInline internal let complexMapping: [Input.Element: ContextualMapping<Input, Output>]
  @usableFromInline internal let fallbackAlgorithm: (Input.Element) -> Output

  // MARK: - Usage

  /// Maps the input.
  ///
  /// - Parameters:
  ///     - input: The input.
  @inlinable public func map(_ input: Input) -> Output {
    var remainder = input[input.bounds]
    var output = Output()
    while ¬remainder.isEmpty {
      mapNext(&remainder, output: &output)
    }
    return output
  }

  @inlinable internal func mapNext(_ remainder: inout Input.SubSequence, output: inout Output) {
    guard let first = remainder.first else {
      // End

      // Only sub‐mappings (with simple output) reach this code. See “map” above.
      output += simpleOutput!
      return
    }

    if let rule = complexMapping[first] {
      remainder = remainder.dropFirst()
      rule.mapNext(&remainder, output: &output)
    } else if let simple = simpleOutput {
      output += simple
    } else {
      let outputElements = fallbackAlgorithm(first)
      remainder = remainder.dropFirst()
      output += outputElements
    }
  }
}
