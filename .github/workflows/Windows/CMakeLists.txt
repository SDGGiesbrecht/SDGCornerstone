

cmake_minimum_required(VERSION 3.15)

project("SDGCornerstone" LANGUAGES Swift)

include(CTest)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

option(BUILD_SHARED_LIBS "Use dynamic linking" YES)

add_library("SDGControlFlow"
  "../../../Sources/SDGControlFlow/APILocalization.swift"
  "../../../Sources/SDGControlFlow/Assert.swift"
  "../../../Sources/SDGControlFlow/AutoreleasePool.swift"
  "../../../Sources/SDGControlFlow/Caching.swift"
  "../../../Sources/SDGControlFlow/Decodable.swift"
  "../../../Sources/SDGControlFlow/DefaultAssignmentPropertyWrapper.swift"
  "../../../Sources/SDGControlFlow/Encodable.swift"
  "../../../Sources/SDGControlFlow/NonmutatingVariants.swift"
  "../../../Sources/SDGControlFlow/ProjectingPropertyWrapper.swift"
  "../../../Sources/SDGControlFlow/PropertyWrapper.swift"
  "../../../Sources/SDGControlFlow/Shared.swift"
  "../../../Sources/SDGControlFlow/SharedProperty.swift"
  "../../../Sources/SDGControlFlow/SharedValueObserver.swift"
  "../../../Sources/SDGControlFlow/TextualPlaygroundDisplay.swift"
  "../../../Sources/SDGControlFlow/TransparentWrapper.swift"
  "../../../Sources/SDGControlFlow/Weak.swift"
)
set_target_properties("SDGControlFlow" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGControlFlow" PRIVATE -enable-testing)

add_library("SDGLogic"
  "../../../Sources/SDGLogic/Any.swift"
  "../../../Sources/SDGLogic/Bool.swift"
  "../../../Sources/SDGLogic/Equatable.swift"
  "../../../Sources/SDGLogic/NilLiteral.swift"
  "../../../Sources/SDGLogic/Operators.swift"
  "../../../Sources/SDGLogic/Tuple.swift"
)
set_target_properties("SDGLogic" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogic" PRIVATE -enable-testing)

add_library("SDGMathematics"
  "../../../Sources/SDGMathematics/Angle.swift"
  "../../../Sources/SDGMathematics/BitField.swift"
  "../../../Sources/SDGMathematics/ClosedRange.swift"
  "../../../Sources/SDGMathematics/Comparable.swift"
  "../../../Sources/SDGMathematics/Data.swift"
  "../../../Sources/SDGMathematics/Float.swift"
  "../../../Sources/SDGMathematics/FunctionAnalysis.swift"
  "../../../Sources/SDGMathematics/Int.swift"
  "../../../Sources/SDGMathematics/Measurement.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/Addable.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/FixedScaleOneDimensionalPoint.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/GenericAdditiveArithmetic.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/IntegerProtocol.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/IntegralArithmetic.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/Negatable.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/NumericAdditiveArithmetic.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/OneDimensionalPoint.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/OneDimensionalVector.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/PointProtocol.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/RationalArithmetic.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/RationalNumberProtocol.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/RationalVector.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/RealArithmetic.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/RealNumberProtocol.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/Subtractable.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/VectorProtocol.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/WholeArithmetic.swift"
  "../../../Sources/SDGMathematics/Numeric Protocols/WholeNumberProtocol.swift"
  "../../../Sources/SDGMathematics/Operators.swift"
  "../../../Sources/SDGMathematics/OrderedEnumeration.swift"
  "../../../Sources/SDGMathematics/Sequence.swift"
  "../../../Sources/SDGMathematics/Tuple.swift"
  "../../../Sources/SDGMathematics/UInt.swift"
)
set_target_properties("SDGMathematics" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMathematics" PRIVATE -enable-testing)
target_link_libraries("SDGMathematics" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
)

add_library("SDGCollections"
  "../../../Sources/SDGCollections/Addable.swift"
  "../../../Sources/SDGCollections/Associative/BijectiveMapping.swift"
  "../../../Sources/SDGCollections/Associative/ContextualMapping.swift"
  "../../../Sources/SDGCollections/Associative/Dictionary.swift"
  "../../../Sources/SDGCollections/Conformances/CharacterSet.swift"
  "../../../Sources/SDGCollections/Conformances/Data.swift"
  "../../../Sources/SDGCollections/Conformances/String.swift"
  "../../../Sources/SDGCollections/LegacyMode.swift"
  "../../../Sources/SDGCollections/Operators.swift"
  "../../../Sources/SDGCollections/Ordered/AnyCollection.swift"
  "../../../Sources/SDGCollections/Ordered/Array.swift"
  "../../../Sources/SDGCollections/Ordered/BidirectionalCollection.swift"
  "../../../Sources/SDGCollections/Ordered/Collection.swift"
  "../../../Sources/SDGCollections/Ordered/CollectionDifference.swift"
  "../../../Sources/SDGCollections/Ordered/CollectionDifferenceChange.swift"
  "../../../Sources/SDGCollections/Ordered/FillDirection.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/AlternativePatterns.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/AnyPattern.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/ConcatenatedPatterns.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/ConditionalPattern.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/NaryAlternativePatterns.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/NaryConcatenatedPatterns.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/NegatedPattern.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/NestingLevel.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/Pattern.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/PatternConsumption.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/PatternMatch.swift"
  "../../../Sources/SDGCollections/Ordered/Patterns/RepetitionPattern.swift"
  "../../../Sources/SDGCollections/Ordered/Range.swift"
  "../../../Sources/SDGCollections/Ordered/RangeExpression.swift"
  "../../../Sources/SDGCollections/Ordered/RangeReplaceableCollection.swift"
  "../../../Sources/SDGCollections/Ordered/ReversedCollection.swift"
  "../../../Sources/SDGCollections/Ordered/SearchableBidirectionalCollection.swift"
  "../../../Sources/SDGCollections/Ordered/SearchableCollection.swift"
  "../../../Sources/SDGCollections/Ordered/Slice.swift"
  "../../../Sources/SDGCollections/Unordered/AbsoluteComplement.swift"
  "../../../Sources/SDGCollections/Unordered/ComparableSet.swift"
  "../../../Sources/SDGCollections/Unordered/FiniteSet.swift"
  "../../../Sources/SDGCollections/Unordered/IntensionalSet.swift"
  "../../../Sources/SDGCollections/Unordered/Intersection.swift"
  "../../../Sources/SDGCollections/Unordered/MutableSet.swift"
  "../../../Sources/SDGCollections/Unordered/Set.swift"
  "../../../Sources/SDGCollections/Unordered/SetDefinition.swift"
  "../../../Sources/SDGCollections/Unordered/SetInRepresentableUniverse.swift"
  "../../../Sources/SDGCollections/Unordered/Union.swift"
)
set_target_properties("SDGCollections" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollections" PRIVATE -enable-testing)
target_link_libraries("SDGCollections" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
)

add_library("SDGWindowsTests"
  "../../../Tests/SDGWindowsTests/SDGWindowsTests.swift"
)
set_target_properties("SDGWindowsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGWindowsTests" PRIVATE -enable-testing)
target_link_libraries("SDGWindowsTests" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
)

add_executable(WindowsMain
  WindowsMain.swift
)
target_link_libraries(WindowsMain PRIVATE
  "SDGWindowsTests"
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
