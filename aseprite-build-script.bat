@echo off
SETLOCAL EnableDelayedExpansion

:: REMEMBER TO CONSULT README.MD FIRST!

:: Paths

:: Change DEPS path to your main working directory.
:: The working directory will be created for you if it does not already exist.
set DEPS=E:\deps

:: Path where aseprite source code will be unzipped into, DO NOT MODIFY!
set ASEPRITE=%DEPS%\aseprite

:: Path where Skia will be unzipped into, DO NOT MODIFY!
set SKIA=%DEPS%\skia

:: This path determines what URL aseprite source code is downloaded from, modify if you are building a different version of aseprite.
set ASEZIP=https://github.com/aseprite/aseprite/releases/download/v1.2.33/Aseprite-v1.2.33-Source.zip

:: This path determines what URL Skia is downloaded from, modify if your version of INSTALL.MD recommends a different version of Skia.
set SKIAZIP=https://github.com/aseprite/skia/releases/download/m96-2f1f21b8a9/Skia-Windows-Release-x64.zip

:: Path to Visual Studio 2019 or newer, modify if you have installed on a different drive and/or if using a different edition.
set VISUALSTUDIO="C:\Program Files\Microsoft Visual Studio\2022\Community"

:: This path is to check if the correct version of the Windows SDK is installed, modify if INSTALL.MD recommends a newer SDK version.
set WINSDK="C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0"

:: Path to 7-Zip, alternate commented code if using the 32-bit version of 7-Zip.
set ZIP="C:\Program Files\7-Zip"
:: set ZIP="C:\Program Files (x86)\7-Zip"

:: Path to TEMP directory for curls, modify if wished.
set TEMP=C:\Temp

:: EVERYTHING AFTER THIS POINT SHOULD BE AUTOMATED, DO NOT MODIFY UNLESS SOMETHING IS BROKEN!!!

:: Dependencies check

echo Checking for 7-Zip...
if exist %ZIP%\7z.exe (
    echo 7-Zip was found!
)
if not exist %ZIP%\7z.exe (
    echo 7-Zip was not found
    echo Do you have the correct version uncommented?
    exit /b 1
)

echo Checking for ninja...
where /q ninja
if ERRORLEVEL 1 (
    echo Ninja is not installed
    echo Setup scoop and invoke:
    echo    scoop install ninja
    exit /b 1
)
if ERRORLEVEL 0 (
    echo Ninja was found
)

echo Checking for cmake...
where /q cmake
if ERRORLEVEL 1 (
    echo Cmake is not installed
    echo Setup scoop and invoke:
    echo    scoop install cmake
    exit /b 1
)
if ERRORLEVEL 0 (
    echo Cmake was found
)

echo Checking for Visual Studio...
if exist %VISUALSTUDIO% (
    echo Visual Studio was found
)
if not exist %VISUALSTUDIO% (
    echo Visual Studio was not found
    echo Did you remember modify the path to fit your installation?
    exit /b 1
)

echo Checking for Desktop Development with C++
if exist %VISUALSTUDIO%\VC\Tools\Llvm (
    echo Desktop Development with C++ was found
)
if not exist %VISUALSTUDIO%\VC\Tools\Llvm (
    echo Desktop Development with C++ was not found
    echo Did you select the option from the Visual Studio Installer?
    exit /b 1
)

echo Checking for Windows SDK...
if exist %WINSDK% (
    echo Correct Windows SDK was found
)
if not exist %WINSDK% (
    echo Correct Windows SDK version was not found
    echo Did you install the recommended version with Desktop Development with C++ for VS?
    echo Did you remember to update the path to the recommended version in INSTALL.MD?
    exit /b 1
)

echo All dependencies met

:: Beginning directory creation and downloads

echo Checking for deps directory...
if exist %DEPS% (
    echo Deps directory found
)
if not exist %DEPS% (
    echo Creating deps directory
    md %DEPS%
)
if ERRORLEVEL 1 (
    echo Something went wrong in checking for or creating the deps directory.
    echo Did you set the correct DEPS path for you system?
    exit /b 1
)

echo Checking for aseprite checkout...
if exist %ASEPRITE%\NUL (
    echo Aseprite was found
)
if not exist %ASEPRITE%\NUL (
    echo Aseprite was not found
    echo Downloading aseprite...
    del %TEMP%\asesrc.zip
    curl %ASEZIP% -L -o %TEMP%\asesrc.zip
    echo Unzipping to %ASEPRITE%...
    md %ASEPRITE%
    %ZIP%\7z.exe x %TEMP%\asesrc.zip -o%ASEPRITE% -y
)
if ERRORLEVEL 1 (
    echo Aseprite failed to download and extract
    echo Fatal error. Aborting...
    exit /b 1
)
if ERRORLEVEL 0 (
    echo Aseprite was successfully downloaded and unzipped
)

echo Checking for Skia...
if exist %SKIA%\NUL (
    echo Skia was found
)
if not exist %SKIA%\NUL (
    echo Skia was not found
    echo Downloading Skia m96...
    del %TEMP%\skia.zip
    curl %SKIAZIP% -L -o %TEMP%\skia.zip
    echo Unzipping to %SKIA%...
    md %SKIA%
    %ZIP%\7z.exe x %TEMP%\skia.zip -o%SKIA% -y
)
if ERRORLEVEL 1 (
    echo Skia failed to download and extract
    echo Fatal Error. Aborting...
    exit /b 1
)
if ERRORLEVEL 0 (
    echo Skia was successfully downloaded and unzipped
)

echo All checks okay!
echo .

:: Build details

echo Building aseprite on Windows
echo .

call %VISUALSTUDIO%\Common7\Tools\VsDevCmd.bat -arch=x64

pushd %ASEPRITE%
md build
cd build
call cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLAF_BACKEND=skia -DSKIA_DIR=%SKIA% -DSKIA_LIBRARY_DIR=%SKIA%\out\Release-x64 -DSKIA_LIBRARY=%SKIA%\out\Release-x64\skia.lib -G Ninja ..
call ninja aseprite
if ERRORLEVEL 1 (
    echo Fatal error. Aborting...
    popd
    exit /b %ERRORLEVEL%
)

echo Build complete
dir %ASEPRITE%\build\bin\aseprite.exe
