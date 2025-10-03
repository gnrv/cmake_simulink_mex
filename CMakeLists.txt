cmake_minimum_required(VERSION 3.22)

project(SimulinkMEX LANGUAGES C)

enable_testing()


find_package(Matlab COMPONENTS MAIN_PROGRAM MEX_COMPILER SIMULINK REQUIRED) # ENG_LIBRARY MAT_LIBRARY MX_LIBRARY

# CMake/FindMatlab can yield an 'unknown' version even when the install path is known (e.g., R2024b).
if(NOT DEFINED Matlab_VERSION OR Matlab_VERSION_STRING STREQUAL "" OR Matlab_VERSION_STRING STREQUAL "unknown")
  if(Matlab_ROOT_DIR MATCHES "([0-9][0-9])([ab])")
    set(_ml_year "${CMAKE_MATCH_1}")
    set(_ml_half "${CMAKE_MATCH_2}")
    string(SUBSTRING "${_ml_year}" 0 2 _ml_major)
    if(_ml_half STREQUAL "a")
      set(_ml_minor 1)
    else()
      set(_ml_minor 2)
    endif()
    set(Matlab_VERSION_STRING_INTERNAL "${_ml_major}.${_ml_minor}" CACHE INTERNAL "Matlab version (automatically determined)" FORCE)
    set(Matlab_VERSION_STRING "${Matlab_VERSION_STRING_INTERNAL}")
    message(STATUS "Derived Matlab_VERSION_STRING=${Matlab_VERSION_STRING} from Matlab_ROOT_DIR=${Matlab_ROOT_DIR}")
  else()
    message(WARNING "Could not derive Matlab version from Matlab_ROOT_DIR=${Matlab_ROOT_DIR}")
  endif()
endif()

if(CMAKE_VERSION VERSION_LESS 3.27)
  set(Matlab_VERSION ${Matlab_VERSION_STRING})
endif()

# --- Matlab paths and libs
include(cmake/matlab.cmake)

# --- Mex example
add_subdirectory(mex)

include(FeatureSummary)

feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES)
