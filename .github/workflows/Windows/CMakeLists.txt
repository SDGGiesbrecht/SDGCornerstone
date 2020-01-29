

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

add_executable(WindowsMain
  WindowsMain.swift
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
