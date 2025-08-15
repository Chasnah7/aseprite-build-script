# Aseprite-Build-Script

**Created by [Chasnah](https://chasnah.com/)**

## A customizable, automated Windows batch script for easily compiling Aseprite

Please refer to Aseprite's [INSTALL.md](https://github.com/aseprite/aseprite/blob/v1.3.14.4/INSTALL.md) to check for any updates to Aseprite installation procedure.

This script was tested on Windows 10 & 11 with Visual Studio 2022 Community and is targeted at x64 based systems.

As long as all dependencies are met and all paths are correct this script will automatically download and extract
both the Aseprite source code and a pre-built package of Skia then run the build process.

## NOTICE OF ANTIVIRUS FALSE POSITIVE

There is currently an issue with Windows Defender falsely identify the aseprite source code zip file as containing a trojan. This will cause an error during the download portion of the script.
Temporarily disable real-time protection in Windows Defender before running the script and remember to re-enable protection afterwards.
PLEASE MAKE SURE YOU FULLY TRUST THE CONTENTS OF THE SCRIPT BEFORE RUNNING AND THAT YOU HAVE DOWNLOADED IT ONLY FROM THE ORIGINAL GITHUB OR CODEBERG PAGE!

## Dependencies

* Tar (Bundled with recent releases of Windows 10 and newer)
* The latest version of [Cmake](https://cmake.org)
* [Curl](https://curl.se/) (Bundled with recent releases of Windows 10 and newer)
* [Ninja](https://ninja-build.org/) build system
* [Visual Studio 2022](https://visualstudio.microsoft.com/) + Desktop Development with C++
* Windows SDK 10.0.26100.0 (Available via Visual Studio)
* Installing [scoop](<https://scoop.sh/>) is recommended to install several dependencies:

         scoop install ninja cmake

## Explanation of Paths

The user customizable portion of this script consists of paths. Most of these paths can be changed to better fit your build environment. Below is a short description of each path in order of appearance.

1. WORKING
    * Main working directory for compiling. Recommended to make a separate directory from where the script is run from so it can be easily deleted to build a fresh copy of aseprite.

2. DEPS

    * Change DEPS path to your main working directory. The working directory will be created for you if it does not already exist.

3. ASEPRITE

    * Path where Aseprite source code will be unzipped into, directory is created for you. DO NOT MODIFY!

4. SKIA

    * Path where Skia will be unzipped into, directory is created for you. DO NOT MODIFY!

5. ASEZIP

    * Determines what URL aseprite source code is downloaded from, modify if you are building a different version of aseprite.

6. SKIAZIP

    * Determines what URL Skia is downloaded from, modify if your version of INSTALL.MD recommends a different version of Skia.

7. VISUALSTUDIO

    * Path to Visual Studio 2022, modify if you have installed on a different drive and/or if using a different edition.

8. WINSDK

    * This path is to check if the correct version of the Windows SDK is installed, modify if INSTALL.MD recommends a newer SDK version.

9. TEMP

    * Path to temporary directory for curls.

## Updating

* If you have previously run the script and have changed the URL for ASEZIP, please make sure to delete the previous aseprite directory in the working directory (%DEPS%), and the source code ZIP file in your temp directory (%TEMP).

* If you change the URL for SKIAZIP, please make sure to delete the skia directory in the working directory (%DEPS%), and the Skia ZIP file in your temp directory (%TEMP%).

## Details

Aseprite recommends using Visual Studio 2022 and the latest version of the Windows 11 SDK (Currently 26100).

After adjusting paths to fit your build environment simply execute the script and it will run completely hands off, creating your specified working directory and all subdirectories.

Aseprite source code and a pre-built copy of Skia are curled into the temp directory and extracted into their respective subdirectories.

The script will then begin the build process based on instructions from [INSTALL.md](https://github.com/aseprite/aseprite/blob/v1.3.14.4/INSTALL.md).

Upon completion the script will output a directory listing of the newly compiled aseprite.exe located in the
%ASEPRITE%\build\bin directory. You can freely copy the executable and data folder located in the previously mentioned bin directory to a new location of your choosing.

Enjoy using Aseprite!

## Changelog

* 08/15/2025 - Updated to aseprite 1.3.14.4 & Skia m124. Windows SDK updated to 10.0.26100.0.

* 12/13/2024 - Updated to aseprite 1.3.10.1, added script to automatically create the TEMP directory. Encapsulated DEPS and TEMP into WORKING directory for easy cleanup. Addressed issue with Windows Defender false-positive and a temporary workaround.