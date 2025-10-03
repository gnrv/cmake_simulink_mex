# CMake MATLAB/Simulink mex example

A CMake MATLAB/Simulink mex that defines an S-function, based on https://github.com/scivision/matlab-buildtool-mex.

This was tested with Ubuntu 22.04 and MATLAB R2024b.

## CMake

CMake may be used to build and test this S-function MEX example:

```sh
cmake -B build
cmake --build build

ctest --test-dir build -L mex -V
```

## Simulink

# References

https://github.com/scivision/matlab-buildtool-mex
https://www.scivision.dev/cmake-matlab-add-mex/
https://se.mathworks.com/help/simulink/sfg/example-of-a-basic-c-mex-s-function.html
https://www.mathworks.com/help/simulink/sfg/templates-for-c-s-functions.html
