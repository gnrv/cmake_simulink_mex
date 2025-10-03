add_compile_definitions($<$<AND:$<BOOL:${MSVC}>,$<COMPILE_LANGUAGE:C,CXX>>:_CRT_SECURE_NO_WARNINGS>)

function(find_mex_libs)
# MEX BLAS may need to be linked for targets using BLAS
set(_suffix)
if(MSVC)
  set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
  set(_suffix microsoft)
elseif(MINGW)
  set(_suffix mingw64)
endif()

find_library(Matlab_MEX_BLAS
NAMES mwblas
NO_DEFAULT_PATH
PATHS ${Matlab_EXTERN_LIBRARY_DIR} ${Matlab_BINARIES_DIR}
PATH_SUFFIXES ${_suffix}
)
message(STATUS "Matlab BLAS library: ${Matlab_MEX_BLAS}")
endfunction()

find_mex_libs()

matlab_get_mex_suffix(${Matlab_ROOT_DIR} Matlab_MEX_SUFFIX)
message(STATUS "MEX suffix: ${Matlab_MEX_SUFFIX}")
