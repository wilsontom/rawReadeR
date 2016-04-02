# rawReadeR [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Build status](https://ci.appveyor.com/api/projects/status/x6r218kf1v51oqiq/branch/master?svg=true)](https://ci.appveyor.com/project/wilsontom/rawreader/branch/master) [![License](https://img.shields.io/badge/license-GNU%20General%20Public%20License%20v3.0-blue.svg "GNU GPL v3.0")](https://raw.githubusercontent.com/wilsontom/rawReadeR/master/LICENSE)

 > __read Thermo .RAW data into R__

#### What is rawReadeR ?

`rawReadeR` is an R package that provides a series of functions which act as an interface to the `MSFileReader.dll` The `MSFileReader.dll` is accessed _via_ [C++ functions](https://github.com/wilsontom/rawReadeR/tree/master/inst/src) and the corresponding [compiled binaries]( https://github.com/wilsontom/rawReadeR/tree/master/inst/bin) are utilised through a `R` wrappers.

`rawReadeR` allows for m/z profiles and scan header data to be extracted from `.RAW` files without the need for manual extraction using `Xcalibur` or conversion to a more universal format (`.mzML`, `.mZXML`, etc...)

#### Installation

To install `rawReadR`;
```R
devtools::install_github("wilsontom/rawReadR")
```
__Due to the requirements of the `MSFileReader.dll`, `rawReadR` can only be installed on a Windows OS__

The `MSFileReader.dll` also needs to be accessible and registered before using. First, [download](https://thermo.flexnetoperations.com/control/thmo/login?nextURL=%2Fcontrol%2Fthmo%2Fdownload%3Felement%3D6306677) the `MSFileReader`. Each `C++` source file contains a line indicating where the `.dll` can be accessed from;

```cpp
#import "C:\Thermo\MSFileReader.XRawfile2.dll"
```
All of the pre-compiled binaries in `/inst/bin/ `have been compiled using this `.dll` location.  If you wish to use a different path, then the `C++ #import` will need amending and the binaries re-compiled. To re-compile open the `Visual Studio Developers Command Prompt`;

```bat
cl /EHsc rawReadRfunction.cpp
```
Finally, the `.dll` needs to be registered. This can be done from a command prompt which has Administrator privileges;

```bat
regsvr32 C:\Thermo\MSFileReader.XRawfile2.dll
```


##### Acknowledgments

This package was inspired by a similar effort using [MATLAB and the mex complier](https://github.com/jgoldford/msfilereader-matlab-api). Also, [Galaxy-M](https://github.com/Viant-Metabolomics/Galaxy-M) contains a excellent Python parser for MSfilereader which was helpful during development of this package
