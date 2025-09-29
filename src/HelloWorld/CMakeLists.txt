
# Copyright (c) 2025 OpenVoxel-Studio <xavier.beheydt@gmail.com>
# SPDX-License-Identifier: MIT

add_executable(helloworld helloworld.cpp)

# Register the HelloWorld executable as a CTest test
if (ENABLE_TESTING)
    add_test(NAME HelloWorldTest COMMAND helloworld)
endif()