# Copyright (c) 2025 Xavier Beheydt <xavier.beheydt@gmail.com>

# Project settings for CMake
message(STATUS "Load Project settings")

# C++ Settings
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to use")
set(CMAKE_CXX_STANDARD_REQUIRED ON CACHE BOOL "Require C++ standard")
set(CMAKE_CXX_EXTENSIONS OFF CACHE BOOL "Disable compiler-specific extensions")

# Clang Settings
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    message(STATUS "Clang settings")
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # clang compiler database
    if(WIN32)
        # Add MS support compatibility for Clang
        add_compile_options(-fms-compatibility)
    endif()
endif()

# Options
option(ENABLE_ASAN "Enable address sanitizer" FALSE)
option(ENABLE_COVERAGE "Enable coverage reporting for gcc/clang" FALSE)
option(BUILD_SHARED_LIBS "Enable compilation of shared libraries" FALSE)
option(ENABLE_TESTING "Enable the building of the test" FALSE)
option(ENABLE_CLANG_TIDY "Enable testing with clang-tidy" FALSE)
option(ENABLE_CPPCHECK "Enable testing with cppcheck" FALSE)
option(BUILD_DOC "Build the project's documentation" OFF)
option(FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." TRUE)


# Asan
if(ENABLE_ASAN)
    message(STATUS "Enable Address Sanitizer")
    if (WIN32)
        add_compile_options(-Db_sanitize=address)
        link_libraries(-Db_sanitize=address)
    else ()
        add_compile_options(-fsanitize=address)
        link_libraries(-fsanitize=address)
    endif()
endif()

# CTest
if(ENABLE_TESTING)
    include(CTest)
    enable_testing()

    # Coverage
    if(ENABLE_COVERAGE)
        message(STATUS "Enable Coverage")
        add_compile_options(--coverage)
        link_libraries(--coverage)
    endif()
endif()

# Colorize Output
if(FORCE_COLORED_OUTPUT AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    add_compile_options(-fcolor-diagnostics)
endif(FORCE_COLORED_OUTPUT)
