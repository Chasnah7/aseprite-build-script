# Aseprite-Build-Script

**Created by [Chasnah](https://chasnah7.github.io/)**

## A customizable automated Windows batch script for easily compiling Aseprite

Please refer to Aseprite's [INSTALL.md](https://github.com/aseprite/aseprite/blob/845ff177880822f33939cfbe58ca5bebaf4efbea/INSTALL.md) to check for any updates to Aseprite installation procedure.

This script was tested on Windows 10 & 11 with Visual Studio 2022 Community and is designed for x64 based systems.

As long as all dependencies are met and all paths are correct this script will automatically download and extract
both the Aseprite source code and a pre-built package of Skia then run the build process.

## Dependencies

* [7-Zip](https://7-zip.org/) (64-bit recommended)
* The latest version of [Cmake](https://cmake.org) (3.14 or greater)
* [Curl](https://curl.se/) (Should be bundled with recent releases of Windows 10 and newer)
* [Ninja](https://ninja-build.org/) build system
* [Visual Studio 2019](https://visualstudio.microsoft.com/) or newer + Desktop Development with C++
* Windows SDK 10.0.18362.0 (Available via Visual Studio)
* Installing [scoop](<https://scoop.sh/>) is recommended to install several dependencies:

         scoop install ninja cmake

## Explanation of Paths

The user customizable portion of this script consists of paths. Most of these paths can be changed to better fit your build environment. Below is a short description of each path in order of appearance.

1. DEPS

    * Change DEPS path to your main working directory. The working directory will be created for you if it does not already exist.

2. ASEPRITE

    * Path where aseprite source code will be unzipped into, directory is created for you. DO NOT MODIFY!

3. SKIA

    * Path where Skia will be unzipped into, directory is created for you. DO NOT MODIFY!

4. ASEZIP

    * Determines what URL aseprite source code is downloaded from, modify if you are building a different version of aseprite.

5. SKIAZIP

    * Determines what URL Skia is downloaded from, modify if your version of INSTALL.MD recommends a different version of Skia.

6. VISUALSTUDIO

    * Path to Visual Studio 2019 or newer, modify if you have installed on a different drive and/or if using a different edition.

7. WINSDK

    * This path is to check if the correct version of the Windows SDK is installed, modify if INSTALL.MD recommends a newer SDK version.

8. ZIP

    * Path to 7-Zip, alternate commented code if using the 32-bit version of 7-Zip.

9. TEMP

    * Path to temporary directory for curls.

## Details

After adjusting paths to fit your build environment simply execute the script and it will run completely hands off,
creating your specified working directory and all subdirectories.

Aseprite source code and a pre-built copy of Skia are curled into the temp directory and extracted into their respective subdirectories.

The script will then begin the build process based on instructions from [INSTALL.md](https://github.com/aseprite/aseprite/blob/845ff177880822f33939cfbe58ca5bebaf4efbea/INSTALL.md).

Upon completion the script will output a DIR command displaying the newly compiled aseprite.exe located in the
%ASEPRITE%\build\bin directory. navigating to this directory you will find your newly created copies of the Aseprite executable and its data folder.

Enjoy using Aseprite!
