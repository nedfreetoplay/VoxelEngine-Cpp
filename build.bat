@echo off
:MENU
cls
echo Select an action:
echo Installing dependencies:
echo 1. Install Git
echo 2. Install vcpkg
echo 3. Install CMake (opens browser to download page)
echo 4. Install vcpkg libs
echo --------------------------------------
echo Operations with the engine code:
echo 5. Build with Visual Studio 17 2022
echo 6. Build with Visual Studio 16 2019
echo 7. Build with Visual Studio 15 2017
echo 8. Build with Visual Studio 14 2015
echo 9. Delete build folder
echo 10. Open build/Release folder
echo 11. Run Engine
echo --------------------------------------
echo 12. Exit
set /p choice=Enter the action number (1-12): 

if %choice%==1 (
    echo Installing Git...
    powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoExit', '-Command', 'winget install --id Git.Git -e --source winget'"
    pause
    goto MENU
) else if %choice%==2 (
    echo Installing vcpkg...
    powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoExit', '-Command', 'cd C:\; if (Test-Path vcpkg) { Remove-Item vcpkg -Recurse -Force }; git clone https://github.com/microsoft/vcpkg.git; cd vcpkg; .\\bootstrap-vcpkg.bat; [Environment]::SetEnvironmentVariable(\"VCPKG_ROOT\", \"C:\\vcpkg\", \"Machine\"); $path = [Environment]::GetEnvironmentVariable(\"Path\", \"Machine\"); [Environment]::SetEnvironmentVariable(\"Path\", \"$path;C:\\vcpkg\", \"Machine\")'"
    echo Vcpkg installed. Please restart this script to apply environment variables.
    pause
    goto MENU
) else if %choice%==3 (
    echo Opening CMake download page...
    start https://cmake.org/download/
    goto MENU
) else if %choice%==4 (
    vcpkg install
    pause
    goto MENU
) else if %choice%==5 (
    if exist build (
        echo Deleting the existing build folder...
        rmdir /s /q build
    )
    cmake --preset=default-vs-msvc-windows
    cd build
    cmake --build . --config Release
    cd ..
    pause
    goto MENU
) else if %choice%==6 (
    if exist build (
        echo Deleting the existing build folder...
        rmdir /s /q build
    )
    cmake --preset=default-vs-msvc-windows -G "Visual Studio 16 2019"
    cd build
    cmake --build . --config Release
    cd ..
    pause
    goto MENU
) else if %choice%==7 (
    if exist build (
        echo Deleting the existing build folder...
        rmdir /s /q build
    )
    cmake --preset=default-vs-msvc-windows -G "Visual Studio 15 2017"
    cd build
    cmake --build . --config Release
    cd ..
    pause
    goto MENU
) else if %choice%==8 (
    if exist build (
        echo Deleting the existing build folder...
        rmdir /s /q build
    )
    cmake --preset=default-vs-msvc-windows -G "Visual Studio 14 2015"
    cd build
    cmake --build . --config Release
    cd ..
    pause
    goto MENU
) else if %choice%==9 (
    if exist build (
        echo Deleting the build folder...
        rmdir /s /q build
        echo Build folder deleted.
    ) else (
        echo Build folder does not exist.
    )
    pause
    goto MENU
) else if %choice%==10 (
    if exist build\Release (
        echo Opening build/Release folder in Explorer...
        start "" "build\Release"
    ) else (
        echo The build/Release folder does not exist.
    )
    pause
    goto MENU
) else if %choice%==11 (
    echo Running VoxelEngine...
    cd build\Release
    VoxelEngine.exe
    pause
    goto MENU
) else if %choice%==12 (
    exit
) else (
    echo Wrong choice, try again.
    pause
    goto MENU
)