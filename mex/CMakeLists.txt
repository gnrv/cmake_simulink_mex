# https://www.mathworks.com/help/matlab/matlab_external/table-of-mex-file-source-code-files.html

set_property(DIRECTORY PROPERTY LABELS "mex")


# To link to other libraries, use the LINK_TO option.
matlab_add_mex(NAME example SHARED SRC example.c LINK_TO ${Matlab_MEX_BLAS})

matlab_add_mex(NAME singleExample SHARED SRC singleExample.c LINK_TO ${Matlab_MEX_BLAS})

add_test(NAME C_EXAMPLE
COMMAND ${Matlab_MAIN_PROGRAM} -batch
 "addpath('$<TARGET_FILE_DIR:example>'), r=runtests('${CMAKE_CURRENT_SOURCE_DIR}', Name='TestMex/test_example'); assertSuccess(r)"
)

add_test(NAME C_SINGLEEXAMPLE
COMMAND ${Matlab_MAIN_PROGRAM} -batch
 "addpath('$<TARGET_FILE_DIR:singleExample>'), r=runtests('${CMAKE_CURRENT_SOURCE_DIR}', Name='TestMex/test_singleExample'); assertSuccess(r)"
)
