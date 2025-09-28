# Copyright (c) 2025 Xavier Beheydt <xavier.beheydt@gmail.com>

# Clang TIDY
if(ENABLE_CLANG_TIDY)
    message(STATUS "Enable Clang Tidy")
    find_program(CLANGTIDY clang-tidy)
    if(CLANGTIDY)
        set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY})
    else()
        message(SEND_ERROR "clang-tidy requested but executable not found")
    endif()
endif()

# CPPCheck
if(ENABLE_CPPCHECK)
    message(STATUS "Enable CPP Check")
    find_program(CPPCHECK cppcheck)
    if(CPPCHECK)
        set(CMAKE_CXX_CPPCHECK ${CPPCHECK})
    else()
        message(SEND_ERROR "cppcheck requested but executable not found")
    endif()
endif()