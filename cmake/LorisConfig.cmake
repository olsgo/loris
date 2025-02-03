include(CMakeFindDependencyMacro)

# Compute paths
get_filename_component(LORIS_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
set(LORIS_INCLUDE_DIRS "@CMAKE_INSTALL_PREFIX@/include")

# Library dependencies (if any)
if(NOT TARGET loris::loris)
    include("${LORIS_CMAKE_DIR}/LorisTargets.cmake")
endif()

# These are IMPORTED targets created by LorisTargets.cmake
set(LORIS_LIBRARIES loris::loris)

# Version information
set(LORIS_VERSION_MAJOR 1)
set(LORIS_VERSION_MINOR 9)
set(LORIS_VERSION_PATCH 0)
set(LORIS_VERSION "${LORIS_VERSION_MAJOR}.${LORIS_VERSION_MINOR}.${LORIS_VERSION_PATCH}")

# Additional compile definitions
set(LORIS_DEFINITIONS "")

# Platform specific settings
if(APPLE)
    list(APPEND LORIS_DEFINITIONS 
        -fno-rtti 
        -std=c++17 
        -fno-aligned-new
        -Werror=return-type
        -Wno-comment
    )
elseif(WIN32)
    list(APPEND LORIS_DEFINITIONS 
        /Zc:alignedNew-
        /wd4068
        /EHa
    )
endif()

# Export compile definitions
set(LORIS_COMPILE_DEFINITIONS ${LORIS_DEFINITIONS})