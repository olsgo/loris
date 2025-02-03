include(ExternalProject)


#--------------------------------------------------------------------
# set min version and deployment target -- before project
#--------------------------------------------------------------------

cmake_minimum_required(VERSION 3.5)

set(CMAKE_OSX_DEPLOYMENT_TARGET "10.13" CACHE STRING "Minimum OS X deployment version")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

IF(APPLE)
  SET(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Build architectures for Mac OS X" FORCE)
ENDIF(APPLE)

#--------------------------------------------------------------------
# project and version
#--------------------------------------------------------------------

set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE) 

project(loris)

#--------------------------------------------------------------------
# Compiler flags
#--------------------------------------------------------------------

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -std=c++17")

  # For now, explicitly disable C++17 alignment feature 
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-aligned-new")
elseif(WIN32)
  #untested
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zc:alignedNew-")
endif()
 
if(MSVC)
    # arcane thing about setting runtime library flags
    cmake_policy(SET CMP0091 NEW)

    add_compile_options(
        $<$<CONFIG:>:/MT>
        $<$<CONFIG:Debug>:/MTd>
        $<$<CONFIG:Release>:/MT>
    )
endif()

 #--------------------------------------------------------------------
 # Choose library output name
 #--------------------------------------------------------------------
 
 # creates the library loris-debug in debug configuration
 set(LIBRARY_NAME loris$<$<CONFIG:Debug>:-debug>)
 
 
 #--------------------------------------------------------------------
 # Enforce out of source build
 #--------------------------------------------------------------------
 
 if(CMAKE_BINARY_DIR EQUAL CMAKE_SOURCE_DIR)
   message(FATAL_ERROR "Loris requires an out of source build.")
 endif()
 
 #--------------------------------------------------------------------
 # Add include directories
 #--------------------------------------------------------------------
 
 message("\n\n\ncurrent dir: " ${CMAKE_CURRENT_SOURCE_DIR})
 
 include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
 include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
 
 #--------------------------------------------------------------------
 # collect sources and headers
 #--------------------------------------------------------------------
 
 file(GLOB LORIS_SOURCES "src/*.c")
 file(GLOB LORIS_HEADERS_PRIVATE "src/*.h")
 file(GLOB LORIS_HEADERS "include/*.h")
 
 #--------------------------------------------------------------------
 # create and install library
 #--------------------------------------------------------------------
 
 set(target loris)
 
 add_library(${target} STATIC ${LORIS_SOURCES})
 
 
 # send binary output to the current build/bin
 set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

 
 set_target_properties(${target} PROPERTIES
                       OUTPUT_NAME "${LIBRARY_NAME}"
                       VERSION "1.9.0"
                       SOVERSION "1"
                       POSITION_INDEPENDENT_CODE ON
                       FOLDER "loris")
                       
 if(APPLE)
     set_target_properties(${target} PROPERTIES 
         XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf-with-dsym")
 endif()
 
 # set compiler options
 if(APPLE)
     # missing return value should be an error
     target_compile_options(${target} PRIVATE "-Werror=return-type")
     # suppress block comments warnings
     target_compile_options(${target} PRIVATE "-Wno-comment")
 elseif(WIN32)
     target_compile_options(${target} PRIVATE "/wd4068") # silence unknown pragma warning
     target_compile_options(${target} PRIVATE "/EHa") # standard C++ stack unwinding
 endif()
 
 include(GNUInstallDirs)
 
if(WIN32)
    set(CMAKE_INSTALL_LIBDIR "C:/Program Files/loris/lib")
    if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
      set(CMAKE_INSTALL_PREFIX "C:/Program Files/loris" CACHE PATH "..." FORCE)
    endif()
endif()

 # Modify the install(TARGETS) command to include EXPORT
install(
    TARGETS ${target}
    EXPORT lorisTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
 
 #--------------------------------------------------------------------
 # install headers
 #--------------------------------------------------------------------
 
 install(FILES include/loris.h DESTINATION include)

#--------------------------------------------------------------------
 # Including custom cmake rules
 #--------------------------------------------------------------------
 
 set(ALL_SOURCES
     ${LORIS_SOURCES}
     ${LORIS_HEADERS_PRIVATE}
     ${LORIS_HEADERS}
     )
 
 # Adding clang-format target if executable is found
 find_program(CLANG_FORMAT "clang-format")
 if(CLANG_FORMAT)
   add_custom_target(
     clang-format
     COMMAND /opt/homebrew/bin/clang-format
     -i
     --verbose
     -style=file
     ${ALL_SOURCES}
     )
 endif()

# Generate and install config files
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/LorisConfigVersion.cmake"
    VERSION "1.9.0"
    COMPATIBILITY SameMajorVersion
)

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/LorisConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/LorisConfig.cmake"
    @ONLY
)

# Export targets
export(TARGETS ${target}
    NAMESPACE loris::
    FILE "${CMAKE_CURRENT_BINARY_DIR}/LorisTargets.cmake"
)

# Install CMake config files
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/LorisConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/LorisConfigVersion.cmake"
    DESTINATION lib/cmake/loris
)

install(EXPORT lorisTargets
    FILE LorisTargets.cmake
    NAMESPACE loris::
    DESTINATION lib/cmake/loris
)
 
 

