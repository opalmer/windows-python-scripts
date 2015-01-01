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
call:download_python 2.6.6
call:download_python 2.7.9
call:download_python 3.2.5
call:download_python 3.3.5
call:download_python 3.4.2

:: get pywin32 installers
call:download_pywin32 2.6
call:download_pywin32 2.7
call:download_pywin32 3.2
call:download_pywin32 3.3
call:download_pywin32 3.4

:: get pip
echo Downloading get-pip.py to %SOURCES%\modules\get-pip.py
curl --silent -o %SOURCES%\modules\get-pip.py https://bootstrap.pypa.io/get-pip.py


:download_python
    if [%~1] == [] (
        goto :eof
    )
    setlocal
    set VERSION=%~1
    echo Downloading Python %VERSION% 32-bit to %SOURCES%\python\python-%VERSION%-x86.msi
    curl --silent -C - -o %SOURCES%\python\python-%VERSION%-x86.msi https://www.python.org/ftp/python/%VERSION%/python-%VERSION%.msi
    echo Downloading Python %VERSION% 64-bit to %SOURCES%\python\python-%VERSION%-x64.msi
    curl --silent -C - -o %SOURCES%\python\python-%VERSION%-x64.msi https://www.python.org/ftp/python/%VERSION%/python-%VERSION%.amd64.msi
    endlocal
goto :eof

:download_pywin32
    if [%~1] == [] (
        goto :eof
    )
    setlocal
    set VERSION=%~1
    echo Downloading pywin32 32-bit for Python %VERSION% to %SOURCES%\modules\pywin32-219-py%VERSION%-x86.exe
    curl --silent -C - -L -o %SOURCES%\modules\pywin32-219-py%VERSION%-x86.exe http://sourceforge.net/projects/pywin32/files/pywin32/Build%%20219/pywin32-219.win32-py%VERSION%.exe/download
    echo Downloading pywin32 64-bit for Python %VERSION% to %SOURCES%\modules\pywin32-219-py%VERSION%-x64.exe
    curl --silent -C - -L -o %SOURCES%\modules\pywin32-219-py%VERSION%-x64.exe http://sourceforge.net/projects/pywin32/files/pywin32/Build%%20219/pywin32-219.win-amd64-py%VERSION%.exe/download
    endlocal
goto :eof
