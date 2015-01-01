@echo off

if [%SOURCES%] == [] (
    set SOURCES=sources
)

if [%PREFIX%] == [] (
    set PREFIX=C:\dev\python
)

call:install_python 2.6.6 x86
call:install_python 2.6.6 x64
call:install_python 2.7.9 x86
call:install_python 2.7.9 x64
call:install_python 3.2.5 x86
call:install_python 3.2.5 x64
call:install_python 3.3.5 x86
call:install_python 3.3.5 x64
call:install_python 3.4.2 x86
call:install_python 3.4.2 x64

:install_python
    setlocal
    if [%~1] == [] (goto :eof)
    if [%~2] == [] (goto :eof)
    if [%~3] == [] (
        set FEATURES=DefaultFeature
    ) else (
        set FEATURES=%~3
    )
    set VERSION=%~1
    set ARCH=%~2
    set MSI=%SOURCES%\python\python-%VERSION%-%ARCH%.msi
    set TARGETDIR=%PREFIX%\%VERSION%-%ARCH%

    if not exist %MSI% (
        echo ERROR: %MSI% does not exist
        goto :eof
    )
    echo Installing %MSI% to %TARGETDIR%
    msiexec /qr /i %MSI% TARGETDIR=%TARGETDIR% ALLUSERS=1 ADDLOCAL=%FEATURES%
    endlocal
goto :eof