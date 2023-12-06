@echo off
SETLOCAL EnableDelayedExpansion

:: REMEMBER TO CONSULT README.MD FIRST!
:: IF YOU RECIEVED THIS SCRIPT FROM ANYWHERE OTHER THAN https://github.com/Chasnah7/aseprite-build-script
:: DOUBLE CHECK TO MAKE SURE IT HAS NOT BEEN MALICIOUSLY EDITED.
:: THE AUTHOR CLAIMS NO LIABILITY NO WARRANTY FOR THIS SCRIPT
:: USE AT YOUR OWN RISK.

:: Paths

set DEPS=C:\deps

set ASEPRITE=%DEPS%\aseprite

set SKIA=%DEPS%\skia

set ASEZIP=https://github.com/aseprite/aseprite/releases/download/v1.3.2/Aseprite-v1.3.2-Source.zip

set SKIAZIP=https://github.com/aseprite/skia/releases/download/m102-861e4743af/Skia-Windows-Release-x64.zip

set VISUALSTUDIO="C:\Program Files\Microsoft Visual Studio\2022\Community"

set WINSDK="C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.20348.0"

set ZIP="C:\Program Files\7-Zip"
:: set ZIP="C:\Program Files (x86)\7-Zip"

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
    echo Did you set the correct DEPS path for your system?
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
    echo Is TEMP correctly set?
    echo Are you connected to the internet?
    echo Does ASEZIP point to the correct URL?
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
    echo Downloading Skia m102...
    del %TEMP%\skia.zip
    curl %SKIAZIP% -L -o %TEMP%\skia.zip
    echo Unzipping to %SKIA%...
    md %SKIA%
    %ZIP%\7z.exe x %TEMP%\skia.zip -o%SKIA% -y
)
if ERRORLEVEL 1 (
    echo Skia failed to download and extract
    echo Is TEMP correctly set?
    echo Are you connected to the internet?
    echo Does SKIAZIP point to the correct URL?
    echo Fatal Error. Aborting...
    exit /b 1
)
if ERRORLEVEL 0 (
    echo Skia was successfully downloaded and unzipped
)

echo All checks okay!
echo .

:: Compile

echo Building Aseprite on Windows
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
