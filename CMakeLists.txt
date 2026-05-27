cmake_minimum_required(VERSION 3.10)
project(print)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(print STATIC sources/print.cpp)

target_include_directories(print PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable(example main.cpp)
target_link_libraries(example print)

install(TARGETS print
    ARCHIVE DESTINATION lib
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION include)


if(BUILD_TESTS)
  enable_testing()
  add_subdirectory(third-party/gtest)
  file(GLOB ${PROJECT_NAME}_TEST_SOURCES tests/*.cpp)
  add_executable(check ${${PROJECT_NAME}_TEST_SOURCES})
  target_link_libraries(check ${PROJECT_NAME} gtest_main)
  add_test(NAME check COMMAND check)
endif()
