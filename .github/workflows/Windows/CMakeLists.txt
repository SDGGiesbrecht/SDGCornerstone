

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

add_library("SDGText"
  "../../../Sources/SDGText/Array.swift"
  "../../../Sources/SDGText/CharacterSet.swift"
  "../../../Sources/SDGText/Collection.swift"
  "../../../Sources/SDGText/Compatibility/StaticString.swift"
  "../../../Sources/SDGText/Compatibility/String.swift"
  "../../../Sources/SDGText/Compatibility/StringClusterView.swift"
  "../../../Sources/SDGText/Compatibility/StringScalarView.swift"
  "../../../Sources/SDGText/ExtendedGraphemeCluster.swift"
  "../../../Sources/SDGText/Font.swift"
  "../../../Sources/SDGText/MarkupPlaygroundDisplay.swift"
  "../../../Sources/SDGText/Range.swift"
  "../../../Sources/SDGText/SemanticMarkup.swift"
  "../../../Sources/SDGText/SemanticMarkupStringInterpolation.swift"
  "../../../Sources/SDGText/Strict/StrictString.swift"
  "../../../Sources/SDGText/Strict/StrictStringClusterView.swift"
  "../../../Sources/SDGText/Strict/StrictStringInterpolationProtocol.swift"
  "../../../Sources/SDGText/Strict/StrictStringStringInterpolation.swift"
  "../../../Sources/SDGText/String Family/ExtendedGraphemeClusterView.swift"
  "../../../Sources/SDGText/String Family/Line.swift"
  "../../../Sources/SDGText/String Family/LineView.swift"
  "../../../Sources/SDGText/String Family/LineViewIndex.swift"
  "../../../Sources/SDGText/String Family/NewlinePattern.swift"
  "../../../Sources/SDGText/String Family/StringFamily.swift"
  "../../../Sources/SDGText/String Family/StringIndex.swift"
  "../../../Sources/SDGText/String Family/UnicodeScalarView.swift"
  "../../../Sources/SDGText/UnicodeScalar.swift"
)
set_target_properties("SDGText" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGText" PRIVATE -enable-testing)
target_link_libraries("SDGText" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
)

add_library("SDGPersistence"
  "../../../Sources/SDGPersistence/Data.swift"
  "../../../Sources/SDGPersistence/FileConvertible.swift"
  "../../../Sources/SDGPersistence/FileManager.swift"
  "../../../Sources/SDGPersistence/Preference.swift"
  "../../../Sources/SDGPersistence/PreferenceSet.swift"
  "../../../Sources/SDGPersistence/ProcessInfo.swift"
  "../../../Sources/SDGPersistence/StrictString.swift"
  "../../../Sources/SDGPersistence/String.swift"
  "../../../Sources/SDGPersistence/URL.swift"
)
set_target_properties("SDGPersistence" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistence" PRIVATE -enable-testing)
target_link_libraries("SDGPersistence" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
)

add_library("SDGLocalization"
  "../../../Sources/SDGLocalization/CachedLocalization.swift"
  "../../../Sources/SDGLocalization/Extensions/Bool.swift"
  "../../../Sources/SDGLocalization/Extensions/Decodable.swift"
  "../../../Sources/SDGLocalization/Extensions/LosslessStringConvertible.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/Angle.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/Float.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/Int.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/IntegerProtcool.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/IntegralArithmetic.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/RationalArithmetic.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/RationalNumberProtocol.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/UInt.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/WholeArithmetic.swift"
  "../../../Sources/SDGLocalization/Extensions/Numbers/WholeNumberProtocol.swift"
  "../../../Sources/SDGLocalization/Extensions/Precondition.swift"
  "../../../Sources/SDGLocalization/Extensions/PresentableError.swift"
  "../../../Sources/SDGLocalization/Extensions/Range.swift"
  "../../../Sources/SDGLocalization/Extensions/TextConvertibleNumber.swift"
  "../../../Sources/SDGLocalization/Extensions/TextConvertibleNumberParseError.swift"
  "../../../Sources/SDGLocalization/InputLocalization.swift"
  "../../../Sources/SDGLocalization/Interpolation/Casing.swift"
  "../../../Sources/SDGLocalization/Interpolation/EnglishCasing.swift"
  "../../../Sources/SDGLocalization/Interpolation/GenreGrammatical.swift"
  "../../../Sources/SDGLocalization/Interpolation/GrammaticalGender.swift"
  "../../../Sources/SDGLocalization/Interpolation/GrammaticalNumber.swift"
  "../../../Sources/SDGLocalization/Interpolation/GrammatikiPtosi.swift"
  "../../../Sources/SDGLocalization/Localization.swift"
  "../../../Sources/SDGLocalization/LocalizationSetting.swift"
  "../../../Sources/SDGLocalization/LocalizationSettingStabilizationMode.swift"
  "../../../Sources/SDGLocalization/Localizations/APILocalization.swift"
  "../../../Sources/SDGLocalization/Localizations/AnyLocalization.swift"
  "../../../Sources/SDGLocalization/Localizations/ContentLocalization.swift"
  "../../../Sources/SDGLocalization/Localizations/FormatLocalization.swift"
  "../../../Sources/SDGLocalization/Localizations/InterfaceLocalization.swift"
  "../../../Sources/SDGLocalization/Metadata/Language.swift"
  "../../../Sources/SDGLocalization/Metadata/LocalizationData.swift"
  "../../../Sources/SDGLocalization/Metadata/Script.swift"
  "../../../Sources/SDGLocalization/Metadata/State.swift"
  "../../../Sources/SDGLocalization/Metadata/StateData.swift"
  "../../../Sources/SDGLocalization/Metadata/TextDirection.swift"
  "../../../Sources/SDGLocalization/UserFacing.swift"
  "../../../Sources/SDGLocalization/UserFacingDynamic.swift"
)
set_target_properties("SDGLocalization" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalization" PRIVATE -enable-testing)
target_link_libraries("SDGLocalization" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
)

add_library("SDGCornerstoneLocalizations"
  "../../../Sources/SDGCornerstoneLocalizations/APILocalization.swift"
  "../../../Sources/SDGCornerstoneLocalizations/FormatLocalization.swift"
  "../../../Sources/SDGCornerstoneLocalizations/InterfaceLocalization.swift"
)
set_target_properties("SDGCornerstoneLocalizations" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCornerstoneLocalizations" PRIVATE -enable-testing)
target_link_libraries("SDGCornerstoneLocalizations" PRIVATE
  "SDGControlFlow"
  "SDGLocalization"
)

add_library("SDGTesting"
  "../../../Sources/SDGTesting/PerformanceTest.swift"
  "../../../Sources/SDGTesting/Test.swift"
)
set_target_properties("SDGTesting" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTesting" PRIVATE -enable-testing)
target_link_libraries("SDGTesting" PRIVATE
  "SDGControlFlow"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGXCTestUtilities"
  "../../../Sources/SDGXCTestUtilities/TestCase.swift"
  "../../../Sources/SDGXCTestUtilities/XCTAssert.swift"
)
set_target_properties("SDGXCTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGXCTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGXCTestUtilities" PRIVATE
  "SDGTesting"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGPersistence"
)

add_library("SDGControlFlowTests"
  "../../../Tests/SDGControlFlowTests/Examples.swift"
  "../../../Tests/SDGControlFlowTests/SDGControlFlowAPITests.swift"
)
set_target_properties("SDGControlFlowTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGControlFlowTests" PRIVATE -enable-testing)
target_link_libraries("SDGControlFlowTests" PRIVATE
  "SDGControlFlow"
  "SDGTesting"
  "SDGXCTestUtilities"
)

add_executable(WindowsMain
  WindowsMain.swift
)
target_link_libraries(WindowsMain PRIVATE
  "SDGControlFlowTests"
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
