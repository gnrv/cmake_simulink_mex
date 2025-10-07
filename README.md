# CMake MATLAB/Simulink mex example

A CMake MATLAB/Simulink mex that defines an S-function, based on https://github.com/scivision/matlab-buildtool-mex.

# Linux

This was tested with Ubuntu 22.04, CMake 3.22.1 and MATLAB R2024b.

# Windows

This was tested with Windows 11, CMake 3.31.9 and MATLAB R2024b.

## Dependencies

- Install Visual Studio Build Tools 2022
  - or Visual Studio Community/Professional/Enterprise 2022
  - E.g. using one of the [Evergreen Bootstrappers](https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history#evergreen-bootstrappers)
- Install [VS Code](https://code.visualstudio.com)
- Install [CMake](https://cmake.org/install) version 3.31.9 (a.k.a. "Legacy Release")
- Install the C/C++ Extension Pack in VS Code

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
