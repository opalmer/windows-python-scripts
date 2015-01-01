@echo off

if [%SOURCES%] == [] (
    set SOURCES=sources
)

if not exist %SOURCES%\modules (
    mkdir %SOURCES%\modules
)
if not exist %SOURCES%\python (
    mkdir %SOURCES%\python
)

:: get python installers
call:download_python 2.6.6 x86
call:download_python 2.6.6 x64
call:download_python 2.7.9 x86
call:download_python 2.7.9 x64
call:download_python 3.2.5 x86
call:download_python 3.2.5 x64
call:download_python 3.3.5 x86
call:download_python 3.3.5 x64
call:download_python 3.4.2 x86
call:download_python 3.4.2 x64

:: get pywin32 installers
call:download_pywin32 2.6 x86
call:download_pywin32 2.6 x64
call:download_pywin32 2.7 x86
call:download_pywin32 2.7 x64
call:download_pywin32 3.2 x86
call:download_pywin32 3.2 x64
call:download_pywin32 3.3 x86
call:download_pywin32 3.3 x64
call:download_pywin32 3.4 x86
call:download_pywin32 3.4 x64

:: get pip
echo Downloading get-pip.py to %SOURCES%\modules\get-pip.py
curl --silent -o %SOURCES%\modules\get-pip.py https://bootstrap.pypa.io/get-pip.py


:download_python
    if [%~1] == [] (goto :eof)
    if [%~2] == [] (goto :eof)
    setlocal
    set VERSION=%~1
    set ARCH=%~2
    if "%ARCH%" == "x86" (
        set URL=https://www.python.org/ftp/python/%VERSION%/python-%VERSION%.msi
    ) else (
        set URL=https://www.python.org/ftp/python/%VERSION%/python-%VERSION%.amd64.msi
    )
    echo Downloading Python %VERSION% %ARCH% to %SOURCES%\python\python-%VERSION%-%ARCH%.msi
    curl --silent -C - -o %SOURCES%\python\python-%VERSION%-%ARCH%.msi %URL%
    endlocal
goto :eof

:download_pywin32
    if [%~1] == [] (goto :eof)
    if [%~2] == [] (goto :eof)
    setlocal
    set VERSION=%~1
    set ARCH=%~2
    if "%ARCH%" == "x86" (
        set URL=http://sourceforge.net/projects/pywin32/files/pywin32/Build%%20219/pywin32-219.win32-py%VERSION%.exe/download
    ) else (
        set URL=http://sourceforge.net/projects/pywin32/files/pywin32/Build%%20219/pywin32-219.win-amd64-py%VERSION%.exe/download
    )
    echo Downloading pywin32 %ARCH% for Python %VERSION% to %SOURCES%\modules\pywin32-219-py%VERSION%-%ARCH%.exe
    curl --silent -C - -L -o %SOURCES%\modules\pywin32-219-py%VERSION%-%ARCH%.exe %URL%
    endlocal
goto :eof
