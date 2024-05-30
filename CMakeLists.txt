cmake_minimum_required(VERSION 3.16.5)
project(size)

set(CMAKE_CXX_STANDARD 11)
set(SIZE_SOURCES main.cpp)
add_executable(size)

        IF(APPLE)
    set(SIZE_SOURCES ${SIZE_SOURCES} apple.mm)
    find_library(COCOA Cocoa REQUIRED)
    target_link_libraries(size "-framework Cocoa")
endif ()

target_sources(size PRIVATE ${SIZE_SOURCES})