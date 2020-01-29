

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

add_library("SDGWindowsTests"
  "../../../Tests/SDGWindowsTests/SDGWindowsTests.swift"
)
set_target_properties("SDGWindowsTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGWindowsTests" PRIVATE -enable-testing)
target_link_libraries("SDGWindowsTests" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
)

add_executable(WindowsMain
  WindowsMain.swift
)
target_link_libraries(WindowsMain PRIVATE
  "SDGWindowsTests"
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
