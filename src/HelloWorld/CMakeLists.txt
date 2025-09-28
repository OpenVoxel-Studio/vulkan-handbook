# Copyright (c) 2025 Xavier Beheydt <xavier.beheydt@gmail.com>

add_executable(helloworld helloworld.cpp)

# Register the HelloWorld executable as a CTest test
if (ENABLE_TESTING)
    add_test(NAME HelloWorldTest COMMAND helloworld)
endif()