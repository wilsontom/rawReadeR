# rawReadeR [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

 > __read Thermo .RAW data into R__

#### What is rawReadeR ?

rawReadeR is an R package that uses the MSFileReader.dll to access Thermo .RAW files without the need for any propiotory software or third party conversion to a different format.

The only caveat is that all of the C++ exeacutables will only run on a Windows OS.

##### Installation

All the the .exe files have been compiled using a Version XX (64-Bit) of the MSFileReader. To utilise the .exe's you must have the exact same version, and it must also be named `MSFileReader.XRawfile2.dll` and located in the following directory `C:\Thermo\MSFileReader\`

The `.dll` must also be registered, this can be done using the following command, from a command prompt with Administrator privalleges.

The R package can then be simply installed using `devtools`

```R
devtools::install_github("wilsontom/rawReadR")
```

##### Recompling

If you chose to use a different version of the MSFileReader or wish to change the directory where MSfilerreader is installed, then the `#import` line of each executable will need ammending and then the exe recompiled.

```cpp
#import "C:\Thermo\MSFileReader.XRawfile2.dll"
```

```cpp
#<import> "<new_path_to_MSFileRader.dll>"
```


##### Acknowledgments

This package was inspried by a smilar effort using MATLAB and the mex complier. Also, Galaxy-M contains a excellent Python parser for MSfilereader which was helpful during development of this package
