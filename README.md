# rawReadeR [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Build status](https://ci.appveyor.com/api/projects/status/x6r218kf1v51oqiq/branch/master?svg=true)](https://ci.appveyor.com/project/wilsontom/rawreader/branch/master) [![License](https://img.shields.io/badge/license-GNU%20General%20Public%20License%20v3.0-blue.svg "GNU GPL v3.0")](https://raw.githubusercontent.com/wilsontom/rawReadeR/master/LICENSE)

 > __read Thermo .RAW data into R__

#### What is rawReadeR ?

`rawReadeR` is an R/C++ API to the `MSFileReader.dll`.  `rawReadeR` allows for m/z profiles and scan header data to be extracted from `.RAW` files without the need for manual extraction using `Xcalibur` or conversion to a more universal format (`.mzML`, `.mZXML`, etc...)

#### Installation
 __N.B `rawReadeR` can only be installed on a Windows Operating System__

1. [Download](https://thermo.flexnetoperations.com/control/thmo/login?nextURL=%2Fcontrol%2Fthmo%2Fdownload%3Felement%3D63066 77) the `MSFileReader`
 - The `MSFileReader` filepath needs to be `C:\Thermo\MSFileReader.XRawfile2.dll`
 - The `.dll` can then be registered using the following command from a Command Prompt with Administrator privileges 
  ```sh 
  regsvr32 C:\Thermo\MSFileReader.XRawfile2.dll
  ```
2. Download and install Microsoft Visual Studio
3. Clone the repository
```sh
git clone https://github.com/wilsontom/rawReadeR
```
4. To prevent having to distibute compied executables with the package, these need to be compiled prior to package installation. Start a new R session and enter the following;
```R
setwd("rawReadeR")
options(VSPATH = "<path_to_visual_studio_vcvars32.bat>")
ource("rawReadeR/R/compileAll.R") 
compileAll(getwd())
```
5. Finally, build and install.
```sh
R CMD build RawReadeR
R CMD INSTALL RawReadeR_0.1.0_tar.gz
```
6. To check everything has compiled and installed ok...
```R
library(rawReadeR
testPackage(scans = c(1:10)
```


##### Acknowledgments

This package was inspired by a similar effort using [MATLAB and the mex complier](https://github.com/jgoldford/msfilereader-matlab-api). Also, [Galaxy-M](https://github.com/Viant-Metabolomics/Galaxy-M) contains a excellent Python parser for MSfilereader which was helpful during development of this package
