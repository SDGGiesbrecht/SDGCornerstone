

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
  "../../../Sources/SDGControlFlow/Caching.swift"
  "../../../Sources/SDGControlFlow/Decodable.swift"
  "../../../Sources/SDGControlFlow/DefaultAssignmentPropertyWrapper.swift"
  "../../../Sources/SDGControlFlow/Encodable.swift"
  "../../../Sources/SDGControlFlow/Memory.swift"
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

add_library("SDGConcurrency"
  "../../../Sources/SDGConcurrency/RunLoop.swift"
)
set_target_properties("SDGConcurrency" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGConcurrency" PRIVATE -enable-testing)
target_link_libraries("SDGConcurrency" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
)

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

add_library("SDGBinaryData"
  "../../../Sources/SDGBinaryData/Data.swift"
  "../../../Sources/SDGBinaryData/DataBinaryView.swift"
  "../../../Sources/SDGBinaryData/DataStream.swift"
  "../../../Sources/SDGBinaryData/UInt.swift"
  "../../../Sources/SDGBinaryData/UIntBinaryView.swift"
)
set_target_properties("SDGBinaryData" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGBinaryData" PRIVATE -enable-testing)
target_link_libraries("SDGBinaryData" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
)

add_library("SDGGeometry"
  "../../../Sources/SDGGeometry/Angle.swift"
  "../../../Sources/SDGGeometry/BezierPath.swift"
  "../../../Sources/SDGGeometry/CGPoint.swift"
  "../../../Sources/SDGGeometry/CGVector.swift"
  "../../../Sources/SDGGeometry/TwoDimensionalPoint.swift"
  "../../../Sources/SDGGeometry/TwoDimensionalPointProtocol.swift"
  "../../../Sources/SDGGeometry/TwoDimensionalVector.swift"
  "../../../Sources/SDGGeometry/TwoDimensionalVectorProtocol.swift"
)
set_target_properties("SDGGeometry" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGGeometry" PRIVATE -enable-testing)
target_link_libraries("SDGGeometry" PRIVATE
  "SDGControlFlow"
  "SDGMathematics"
)

add_library("SDGRandomization"
  "../../../Sources/SDGRandomization/Bool.swift"
  "../../../Sources/SDGRandomization/CyclicalNumberGenerator.swift"
  "../../../Sources/SDGRandomization/PseudorandomNumberGenerator.swift"
)
set_target_properties("SDGRandomization" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGRandomization" PRIVATE -enable-testing)
target_link_libraries("SDGRandomization" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
)

add_library("SDGText"
  "../../../Sources/SDGText/CharacterSet.swift"
  "../../../Sources/SDGText/CollectionStringFamily.swift"
  "../../../Sources/SDGText/CollectionUnicodeScalar.swift"
  "../../../Sources/SDGText/Compatibility/StaticString.swift"
  "../../../Sources/SDGText/Compatibility/String.swift"
  "../../../Sources/SDGText/Compatibility/StringClusterView.swift"
  "../../../Sources/SDGText/Compatibility/StringScalarView.swift"
  "../../../Sources/SDGText/ExtendedGraphemeCluster.swift"
  "../../../Sources/SDGText/Font/Font.Definition.swift"
  "../../../Sources/SDGText/Font/Font.swift"
  "../../../Sources/SDGText/Font/NSFont.swift"
  "../../../Sources/SDGText/Font/SwiftUI.Font.swift"
  "../../../Sources/SDGText/Font/UIFont.swift"
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

add_library("SDGCollation"
  "../../../Sources/SDGCollation/CollationCacheEntry.swift"
  "../../../Sources/SDGCollation/CollationElement.swift"
  "../../../Sources/SDGCollation/CollationIndex.swift"
  "../../../Sources/SDGCollation/CollationLevel.swift"
  "../../../Sources/SDGCollation/CollationOrder.swift"
  "../../../Sources/SDGCollation/Resources.swift"
  "../../../Sources/SDGCollation/Tailoring/CollationTailoringAnchor.swift"
  "../../../Sources/SDGCollation/Tailoring/OperatorFunctions.swift"
  "../../../Sources/SDGCollation/Tailoring/Operators.swift"
)
set_target_properties("SDGCollation" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollation" PRIVATE -enable-testing)
target_link_libraries("SDGCollation" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
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
  "../../../Sources/SDGLocalization/Interpolation/GrammaticalGender.swift"
  "../../../Sources/SDGLocalization/Interpolation/GrammaticalNumber.swift"
  "../../../Sources/SDGLocalization/Interpolation/GrammatikiPtosi.swift"
  "../../../Sources/SDGLocalization/Interpolation/MinDikduki.swift"
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

add_library("SDGCalendar"
  "../../../Sources/SDGCalendar/Abstract Components/CalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/CardinalCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/ConsistentDurationCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/ConsistentlyOrderedCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/Day.swift"
  "../../../Sources/SDGCalendar/Abstract Components/EnumerationCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/ICalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/ISOCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/Month.swift"
  "../../../Sources/SDGCalendar/Abstract Components/NumericCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/OrdinalCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/RawRepresentableCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/SmallestCalendarComponent.swift"
  "../../../Sources/SDGCalendar/Abstract Components/Weekday.swift"
  "../../../Sources/SDGCalendar/Abstract Components/Year.swift"
  "../../../Sources/SDGCalendar/AnyDescribableDate.swift"
  "../../../Sources/SDGCalendar/CalendarDate.swift"
  "../../../Sources/SDGCalendar/CalendarInterval.swift"
  "../../../Sources/SDGCalendar/Date.swift"
  "../../../Sources/SDGCalendar/DateDefinition.swift"
  "../../../Sources/SDGCalendar/DescribableDate.swift"
  "../../../Sources/SDGCalendar/FoundationDate.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianDate.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianDay.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianHour.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianMinute.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianMonth.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianSecond.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianWeekday.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianWeekdayDate.swift"
  "../../../Sources/SDGCalendar/Gregorian/GregorianYear.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewDate.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewDay.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewHour.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewMonth.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewMonthAndYear.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewPart.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewWeekday.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewWeekdayDate.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewYear.swift"
  "../../../Sources/SDGCalendar/Hebrew/HebrewYearLength.swift"
  "../../../Sources/SDGCalendar/RationalArithmetic.swift"
  "../../../Sources/SDGCalendar/RelativeDate.swift"
  "../../../Sources/SDGCalendar/UnknownDate.swift"
)
set_target_properties("SDGCalendar" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCalendar" PRIVATE -enable-testing)
target_link_libraries("SDGCalendar" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGExternalProcess"
  "../../../Sources/SDGExternalProcess/ExternalProcess.swift"
  "../../../Sources/SDGExternalProcess/ExternalProcessError.swift"
  "../../../Sources/SDGExternalProcess/LegacyMode.swift"
  "../../../Sources/SDGExternalProcess/Shell.swift"
)
set_target_properties("SDGExternalProcess" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGExternalProcess" PRIVATE -enable-testing)
target_link_libraries("SDGExternalProcess" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGText"
  "SDGPersistence"
  "SDGLocalization"
)

add_library("SDGPrecisionMathematics"
  "../../../Sources/SDGPrecisionMathematics/HalvesView.swift"
  "../../../Sources/SDGPrecisionMathematics/Integer.swift"
  "../../../Sources/SDGPrecisionMathematics/RationalNumber.swift"
  "../../../Sources/SDGPrecisionMathematics/UInt.swift"
  "../../../Sources/SDGPrecisionMathematics/WholeNumber.swift"
  "../../../Sources/SDGPrecisionMathematics/WholeNumberBinaryView.swift"
  "../../../Sources/SDGPrecisionMathematics/WholeNumberBinaryViewIndex.swift"
  "../../../Sources/SDGPrecisionMathematics/WholeNumberBinaryViewIndexDistance.swift"
)
set_target_properties("SDGPrecisionMathematics" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPrecisionMathematics" PRIVATE -enable-testing)
target_link_libraries("SDGPrecisionMathematics" PRIVATE
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGBinaryData"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
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

add_library("SDGLogicTestUtilities"
  "../../../Sources/SDGLogicTestUtilities/Equatable.swift"
)
set_target_properties("SDGLogicTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogicTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGLogicTestUtilities" PRIVATE
  "SDGLogic"
  "SDGTesting"
)

add_library("SDGCollectionsTestUtilities"
  "../../../Sources/SDGCollectionsTestUtilities/BidirectionalCollection.swift"
  "../../../Sources/SDGCollectionsTestUtilities/Collection.swift"
  "../../../Sources/SDGCollectionsTestUtilities/ComparableSet.swift"
  "../../../Sources/SDGCollectionsTestUtilities/FiniteSet.swift"
  "../../../Sources/SDGCollectionsTestUtilities/Hashable.swift"
  "../../../Sources/SDGCollectionsTestUtilities/MutableSet.swift"
  "../../../Sources/SDGCollectionsTestUtilities/Pattern.swift"
  "../../../Sources/SDGCollectionsTestUtilities/RandomAccessCollection.swift"
  "../../../Sources/SDGCollectionsTestUtilities/RangeReplaceableCollection.swift"
  "../../../Sources/SDGCollectionsTestUtilities/SetDefinition.swift"
  "../../../Sources/SDGCollectionsTestUtilities/SetInRepresentableUniverse.swift"
)
set_target_properties("SDGCollectionsTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollectionsTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGCollectionsTestUtilities" PRIVATE
  "SDGCollections"
  "SDGTesting"
  "SDGLogicTestUtilities"
)

add_library("SDGPersistenceTestUtilities"
  "../../../Sources/SDGPersistenceTestUtilities/Codable.swift"
  "../../../Sources/SDGPersistenceTestUtilities/FileConvertible.swift"
  "../../../Sources/SDGPersistenceTestUtilities/Specification.swift"
)
set_target_properties("SDGPersistenceTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistenceTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGPersistenceTestUtilities" PRIVATE
  "SDGPersistence"
  "SDGTesting"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCalendar"
  "SDGCornerstoneLocalizations"
)

add_library("SDGLocalizationTestUtilities"
  "../../../Sources/SDGLocalizationTestUtilities/CustomStringConvertible.swift"
)
set_target_properties("SDGLocalizationTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalizationTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGLocalizationTestUtilities" PRIVATE
  "SDGLocalization"
  "SDGTesting"
  "SDGText"
  "SDGPersistence"
  "SDGPersistenceTestUtilities"
)

add_library("SDGMathematicsTestUtilities"
  "../../../Sources/SDGMathematicsTestUtilities/Addable.swift"
  "../../../Sources/SDGMathematicsTestUtilities/BitField.swift"
  "../../../Sources/SDGMathematicsTestUtilities/Comparable.swift"
  "../../../Sources/SDGMathematicsTestUtilities/FixedScaleOneDimensionalPoint.swift"
  "../../../Sources/SDGMathematicsTestUtilities/Float.swift"
  "../../../Sources/SDGMathematicsTestUtilities/GenericAdditiveArithmetic.swift"
  "../../../Sources/SDGMathematicsTestUtilities/IntegralArithmetic.swift"
  "../../../Sources/SDGMathematicsTestUtilities/Measurement.swift"
  "../../../Sources/SDGMathematicsTestUtilities/Negatable.swift"
  "../../../Sources/SDGMathematicsTestUtilities/NumericAdditiveArithmetic.swift"
  "../../../Sources/SDGMathematicsTestUtilities/OneDimensionalPoint.swift"
  "../../../Sources/SDGMathematicsTestUtilities/PointProtocol.swift"
  "../../../Sources/SDGMathematicsTestUtilities/RationalArithmetic.swift"
  "../../../Sources/SDGMathematicsTestUtilities/RationalVector.swift"
  "../../../Sources/SDGMathematicsTestUtilities/RealArithmetic.swift"
  "../../../Sources/SDGMathematicsTestUtilities/Subtractable.swift"
  "../../../Sources/SDGMathematicsTestUtilities/VectorProtocol.swift"
  "../../../Sources/SDGMathematicsTestUtilities/WholeArithmetic.swift"
)
set_target_properties("SDGMathematicsTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMathematicsTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGMathematicsTestUtilities" PRIVATE
  "SDGMathematics"
  "SDGTesting"
  "SDGCollections"
  "SDGLogicTestUtilities"
  "SDGCollectionsTestUtilities"
  "SDGPersistenceTestUtilities"
)

add_library("SDGGeometryTestUtilities"
  "../../../Sources/SDGGeometryTestUtilities/TwoDimensionalPointProtocol.swift"
  "../../../Sources/SDGGeometryTestUtilities/TwoDimensionalVectorProtocol.swift"
)
set_target_properties("SDGGeometryTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGGeometryTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGGeometryTestUtilities" PRIVATE
  "SDGGeometry"
  "SDGTesting"
  "SDGMathematicsTestUtilities"
)

add_library("SDGRandomizationTestUtilities"
  "../../../Sources/SDGRandomizationTestUtilities/Randomizer.swift"
)
set_target_properties("SDGRandomizationTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGRandomizationTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGRandomizationTestUtilities" PRIVATE
  "SDGRandomization"
  "SDGTesting"
)

add_library("SDGVersioning"
  "../../../Sources/SDGVersioning/Version.swift"
)
set_target_properties("SDGVersioning" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGVersioning" PRIVATE -enable-testing)
target_link_libraries("SDGVersioning" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
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

add_library("SDGBinaryDataTests"
  "../../../Tests/SDGBinaryDataTests/APITests.swift"
)
set_target_properties("SDGBinaryDataTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGBinaryDataTests" PRIVATE -enable-testing)
target_link_libraries("SDGBinaryDataTests" PRIVATE
  "SDGBinaryData"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
  "SDGCornerstoneLocalizations"
  "SDGMathematicsTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGCalendarTests"
  "../../../Tests/SDGCalendarTests/APITests.swift"
  "../../../Tests/SDGCalendarTests/InternalTests.swift"
  "../../../Tests/SDGCalendarTests/RegressionTests.swift"
)
set_target_properties("SDGCalendarTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCalendarTests" PRIVATE -enable-testing)
target_link_libraries("SDGCalendarTests" PRIVATE
  "SDGCalendar"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGMathematics"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
  "SDGMathematicsTestUtilities"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGCollationTests"
  "../../../Tests/SDGCollationTests/APITests.swift"
  "../../../Tests/SDGCollationTests/LanguageTests.swift"
)
set_target_properties("SDGCollationTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollationTests" PRIVATE -enable-testing)
target_link_libraries("SDGCollationTests" PRIVATE
  "SDGText"
  "SDGCollation"
  "SDGXCTestUtilities"
)

add_library("SDGCollectionsTests"
  "../../../Tests/SDGCollectionsTests/APITests.swift"
  "../../../Tests/SDGCollectionsTests/AnyForwardCollection.swift"
  "../../../Tests/SDGCollectionsTests/LegacyMode.swift"
  "../../../Tests/SDGCollectionsTests/RegressionTests.swift"
)
set_target_properties("SDGCollectionsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollectionsTests" PRIVATE -enable-testing)
target_link_libraries("SDGCollectionsTests" PRIVATE
  "SDGCollections"
  "SDGCollectionsTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
  "SDGMathematics"
  "SDGCornerstoneLocalizations"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGConcurrencyTests"
  "../../../Tests/SDGConcurrencyTests/APITests.swift"
)
set_target_properties("SDGConcurrencyTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGConcurrencyTests" PRIVATE -enable-testing)
target_link_libraries("SDGConcurrencyTests" PRIVATE
  "SDGConcurrency"
  "SDGTesting"
  "SDGXCTestUtilities"
)

add_library("SDGControlFlowTests"
  "../../../Tests/SDGControlFlowTests/APITests.swift"
  "../../../Tests/SDGControlFlowTests/Examples.swift"
)
set_target_properties("SDGControlFlowTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGControlFlowTests" PRIVATE -enable-testing)
target_link_libraries("SDGControlFlowTests" PRIVATE
  "SDGControlFlow"
  "SDGTesting"
  "SDGXCTestUtilities"
)

add_library("SDGCornerstoneDocumentationExampleTests"
  "../../../Tests/SDGCornerstoneDocumentationExampleTests/DateExampleTests.swift"
  "../../../Tests/SDGCornerstoneDocumentationExampleTests/FunctionAnalysisExampleTests.swift"
  "../../../Tests/SDGCornerstoneDocumentationExampleTests/MiscellaneousExampleTests.swift"
  "../../../Tests/SDGCornerstoneDocumentationExampleTests/ReadMeExampleTests.swift"
  "../../../Tests/SDGCornerstoneDocumentationExampleTests/StrictInterpolationExampleTests.swift"
)
set_target_properties("SDGCornerstoneDocumentationExampleTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCornerstoneDocumentationExampleTests" PRIVATE -enable-testing)
target_link_libraries("SDGCornerstoneDocumentationExampleTests" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
  "SDGRandomization"
  "SDGLocalization"
  "SDGCalendar"
  "SDGConcurrency"
  "SDGPrecisionMathematics"
  "SDGExternalProcess"
  "SDGPersistenceTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SDGExternalProcessTests"
  "../../../Tests/SDGExternalProcessTests/APITests.swift"
  "../../../Tests/SDGExternalProcessTests/LegacyMode.swift"
  "../../../Tests/SDGExternalProcessTests/RegressionTests.swift"
)
set_target_properties("SDGExternalProcessTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGExternalProcessTests" PRIVATE -enable-testing)
target_link_libraries("SDGExternalProcessTests" PRIVATE
  "SDGExternalProcess"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
)

add_library("SDGGeometryTests"
  "../../../Tests/SDGGeometryTests/APITests.swift"
)
set_target_properties("SDGGeometryTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGGeometryTests" PRIVATE -enable-testing)
target_link_libraries("SDGGeometryTests" PRIVATE
  "SDGGeometry"
  "SDGGeometryTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGMathematics"
  "SDGMathematicsTestUtilities"
)

add_library("SDGLocalizationTests"
  "../../../Tests/SDGLocalizationTests/APITests.swift"
  "../../../Tests/SDGLocalizationTests/InternalTests.swift"
)
set_target_properties("SDGLocalizationTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalizationTests" PRIVATE -enable-testing)
target_link_libraries("SDGLocalizationTests" PRIVATE
  "SDGLocalization"
  "SDGLocalizationTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
  "SDGPrecisionMathematics"
  "SDGCornerstoneLocalizations"
  "SDGPersistenceTestUtilities"
)

add_library("SDGLogicTests"
  "../../../Tests/SDGLogicTests/APITests.swift"
)
set_target_properties("SDGLogicTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogicTests" PRIVATE -enable-testing)
target_link_libraries("SDGLogicTests" PRIVATE
  "SDGLogic"
  "SDGLogicTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGMathematicsTestUtilities"
)

add_library("SDGMathematicsTests"
  "../../../Tests/SDGMathematicsTests/APITests.swift"
  "../../../Tests/SDGMathematicsTests/RegressionTests.swift"
)
set_target_properties("SDGMathematicsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMathematicsTests" PRIVATE -enable-testing)
target_link_libraries("SDGMathematicsTests" PRIVATE
  "SDGMathematics"
  "SDGMathematicsTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
)

add_library("SDGPersistenceTests"
  "../../../Tests/SDGPersistenceTests/APITests.swift"
  "../../../Tests/SDGPersistenceTests/RegressionTests.swift"
)
set_target_properties("SDGPersistenceTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistenceTests" PRIVATE -enable-testing)
target_link_libraries("SDGPersistenceTests" PRIVATE
  "SDGPersistence"
  "SDGPersistenceTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGExternalProcess"
  "SDGCornerstoneLocalizations"
  "SDGLocalizationTestUtilities"
)

add_library("SDGPrecisionMathematicsTests"
  "../../../Tests/SDGPrecisionMathematicsTests/APITests.swift"
  "../../../Tests/SDGPrecisionMathematicsTests/InternalTests.swift"
)
set_target_properties("SDGPrecisionMathematicsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPrecisionMathematicsTests" PRIVATE -enable-testing)
target_link_libraries("SDGPrecisionMathematicsTests" PRIVATE
  "SDGPrecisionMathematics"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGMathematics"
  "SDGBinaryData"
  "SDGCornerstoneLocalizations"
  "SDGMathematicsTestUtilities"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGRandomizationTests"
  "../../../Tests/SDGRandomizationTests/APITests.swift"
)
set_target_properties("SDGRandomizationTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGRandomizationTests" PRIVATE -enable-testing)
target_link_libraries("SDGRandomizationTests" PRIVATE
  "SDGRandomization"
  "SDGRandomizationTestUtilities"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
  "SDGMathematics"
)

add_library("SDGTextTests"
  "../../../Tests/SDGTextTests/APITests.swift"
  "../../../Tests/SDGTextTests/InternalTests.swift"
  "../../../Tests/SDGTextTests/RegressionTests.swift"
)
set_target_properties("SDGTextTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTextTests" PRIVATE -enable-testing)
target_link_libraries("SDGTextTests" PRIVATE
  "SDGText"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGCornerstoneLocalizations"
  "SDGMathematicsTestUtilities"
  "SDGCollectionsTestUtilities"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
)

add_library("SDGVersioningTests"
  "../../../Tests/SDGVersioningTests/APITests.swift"
  "../../../Tests/SDGVersioningTests/RegressionTests.swift"
)
set_target_properties("SDGVersioningTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGVersioningTests" PRIVATE -enable-testing)
target_link_libraries("SDGVersioningTests" PRIVATE
  "SDGVersioning"
  "SDGTesting"
  "SDGXCTestUtilities"
  "SDGCornerstoneLocalizations"
  "SDGLocalizationTestUtilities"
)

add_executable(WindowsMain
  WindowsMain.swift
)
target_link_libraries(WindowsMain PRIVATE
  "SDGBinaryDataTests"
  "SDGCalendarTests"
  "SDGCollationTests"
  "SDGCollectionsTests"
  "SDGConcurrencyTests"
  "SDGControlFlowTests"
  "SDGCornerstoneDocumentationExampleTests"
  "SDGExternalProcessTests"
  "SDGGeometryTests"
  "SDGLocalizationTests"
  "SDGLogicTests"
  "SDGMathematicsTests"
  "SDGPersistenceTests"
  "SDGPrecisionMathematicsTests"
  "SDGRandomizationTests"
  "SDGTextTests"
  "SDGVersioningTests"
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
