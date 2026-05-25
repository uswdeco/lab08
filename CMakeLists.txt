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
