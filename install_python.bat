@echo off

if not exist installers\python\modules (
    mkdir installers\python\modules
)
if not exist installers\python\msis (
    mkdir installers\python\msis
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
echo Downloading get-pip.py
curl --silent -o installers\python\modules\get-pip.py https://bootstrap.pypa.io/get-pip.py

:download_python
    if not "%~1" == "" (
        set PYTHON_VERSION=%~1
        echo Downloading Python %PYTHON_VERSION% 32-bit
        curl --silent -C - -o installers\python\msis\python-%PYTHON_VERSION%-x86.msi https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%.msi
        echo Downloading Python %PYTHON_VERSION% 64-bit
        curl --silent -C - -o installers\python\msis\python-%PYTHON_VERSION%-x64.msi https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%.amd64.msi
    )
goto :eof

:download_pywin32
    if not "%~1" == "" (
        set PYWIN_VERSION=%~1
        echo Downloading pywin32 32-bit for Python %PYWIN_VERSION%
        curl --silent -C - -L -o installers\python\modules\pywin32-219-py%PYWIN_VERSION%-x86.exe http://sourceforge.net/projects/pywin32/files/pywin32/Build%%20219/pywin32-219.win32-py%PYWIN_VERSION%.exe/download
        echo Downloading pywin32 64-bit for Python %PYWIN_VERSION%
        curl --silent -C - -L -o installers\python\modules\pywin32-219-py%PYWIN_VERSION%-x64.exe http://sourceforge.net/projects/pywin32/files/pywin32/Build%%20219/pywin32-219.win-amd64-py%PYWIN_VERSION%.exe/download
    )
goto :eof
