# Aseprite-Build-Script

**Created by [Chasnah](https://chasnah7.github.io/)**

## A customizable automated Windows batch script for easily compiling Aseprite

Please refer to Aseprite's [INSTALL.md](https://github.com/aseprite/aseprite/blob/845ff177880822f33939cfbe58ca5bebaf4efbea/INSTALL.md) to check for any updates to Aseprite installation procedure.

This script was tested on Windows 10 & 11 with Visual Studio 2022 Community and is targeted for x64 based systems.

As long as all dependencies are met and all paths are correct this script will automatically download and extract
both the Aseprite source code and a pre-built package of Skia then run the build process.

If updating from a previous version of Aseprite make sure you delete the previous aseprite and skia directories in your working directory (DEPS).

## Dependencies

* Tar (Bundled with recent releases of Windows 10 and newer)
* The latest version of [Cmake](https://cmake.org) (3.16 or greater)
* [Curl](https://curl.se/) (Bundled with recent releases of Windows 10 and newer)
* [Ninja](https://ninja-build.org/) build system
* [Visual Studio 2022](https://visualstudio.microsoft.com/) + Desktop Development with C++
* Windows SDK 10.0.20348.0 (Available via Visual Studio)
* Installing [scoop](<https://scoop.sh/>) is recommended to install several dependencies:

         scoop install ninja cmake

## Explanation of Paths

The user customizable portion of this script consists of paths. Most of these paths can be changed to better fit your build environment. Below is a short description of each path in order of appearance.

1. DEPS

    * Change DEPS path to your main working directory. The working directory will be created for you if it does not already exist.

2. ASEPRITE

    * Path where Aseprite source code will be unzipped into, directory is created for you. DO NOT MODIFY!

3. SKIA

    * Path where Skia will be unzipped into, directory is created for you. DO NOT MODIFY!

4. ASEZIP

    * Determines what URL aseprite source code is downloaded from, modify if you are building a different version of aseprite.

5. SKIAZIP

    * Determines what URL Skia is downloaded from, modify if your version of INSTALL.MD recommends a different version of Skia.

6. VISUALSTUDIO

    * Path to Visual Studio 2022, modify if you have installed on a different drive and/or if using a different edition.

7. WINSDK

    * This path is to check if the correct version of the Windows SDK is installed, modify if INSTALL.MD recommends a newer SDK version.

8. TEMP

    * Path to temporary directory for curls.

## Details

Aseprite recommends using Visual Studio 2022 and the latest version of the Windows 10 SDK (Currently 20348).

After adjusting paths to fit your build environment simply execute the script and it will run completely hands off, creating your specified working directory and all subdirectories.

Aseprite source code and a pre-built copy of Skia are curled into the temp directory and extracted into their respective subdirectories.

The script will then begin the build process based on instructions from [INSTALL.md](https://github.com/aseprite/aseprite/blob/main/INSTALL.md).

Upon completion the script will output a DIR command displaying the newly compiled aseprite.exe located in the
%ASEPRITE%\build\bin directory. You can freely copy the executable and data folder located in the previously mentioned bin directory to a new location of your choosing.

Enjoy using Aseprite!

## InDev

* Currently writing up a macOS script that functions similarly to the current windows batch file. Will include prebuild checks for dependencies and customizable paths.
    (Will be it's own repository.)

* Working on a linux based script as well.
