# Aseprite-Build-Script

**Created by [Chasnah](https://chasnah7.github.io/)**

## An automated Windows batch script for easy compilation of Aseprite source code

Please refer to aseprite's [INSTALL.md](https://github.com/aseprite/aseprite/blob/845ff177880822f33939cfbe58ca5bebaf4efbea/INSTALL.md) to check for any updates.

As long as all dependencies are met this script will automatically download and extract
both the Aseprite source code and Skia then run the build process.

## Dependencies

* [7-Zip](https://7-zip.org/) (64-bit recommended)
* The latest version of [Cmake](https://cmake.org) (3.14 or greater)
* [Curl](https://curl.se/)
* [Ninja](https://ninja-build.org/) build system
* [Visual Studio 2019](https://visualstudio.microsoft.com/) or newer + Desktop Development with C++
* Windows SDK 10.0.18362.0 (Available via Visual Studio)
* Installing [scoop](<https://scoop.sh/>) is recommended to install several dependencies:

     scoop install ninja cmake
