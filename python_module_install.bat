@echo off

if "%PREFIX%" == "" (
    set PREFIX=C:\dev\python
)

if "%SOURCES%" == "" (
    set SOURCES=sources
)

set GET_PIP=%SOURCES%\modules\get-pip.py

if not exist %GET_PIP% (
    echo ERROR: %GET_PIP% does not exist
    goto :eof
)

:: install pip
for /D %%d in (%PREFIX%\*) do (
    call:get_pip "%%d"
)

:: install additional python package(s)
for /D %%d in (%PREFIX%\*) do (
    call:pip_install "%%d" virtualenv
    call:pip_install "%%d" setuptools
    call:pip_install "%%d" wheel
)

:get_pip
    if [%~1] == [] (goto :eof)
    setlocal
    set PYTHON=%~1\python.exe
    set COMMAND=%PYTHON% %GET_PIP% --upgrade
    if not exist %PYTHON% (
        echo ERROR: %PYTHON% does not exist
        goto :eof
    )
    echo %COMMAND%
    %COMMAND%
    endlocal
goto :eof


:pip_install
    if [%~1] == [] (goto :eof)
    if [%~2] == [] (goto :eof)
    setlocal
    set PIP=%~1\Scripts\pip.exe
    set PACKAGE=%~2
    set COMMAND=%PIP% install %PACKAGE% --quiet
    if not exist %PIP% (
        echo ERROR: %PIP% does not exist
        goto :eof
    )
    echo %COMMAND%
    %COMMAND%
    endlocal
goto :eof


:pywin32_install
    if [%~1] == [] (goto :eof)
    if [%~2] == [] (goto :eof)
    if [%~3] == [] (goto :eof)
    setlocal
    set VERSION=%~1
    set SHORT_VERSION=%~2
    set ARCH=%~3
    set PYTHON=%PREFIX%\%VERSION%-%ARCH%\python.exe
    set PYWIN32_INSTALLER=%SOURCES%\modules\pywin32-219-py%SHORT_VERSION%-%ARCH%.exe
    set OUTPUT_DIR=%SOURCES%\modules\pywin32-219-py%SHORT_VERSION%-%ARCH%
    if not exist %PYTHON% (
        echo ERROR: %PYTHON% does not exist
        goto :eof
    )
    if not exist %PYWIN32_INSTALLER% (
        echo ERROR: %PYWIN32_INSTALLER% does not exist
        goto :eof
    )
    if exist %OUTPUT_DIR% (
        rd /s /q %OUTPUT_DIR%
    )
    echo Installing %PYWIN32_INSTALLER%
    %PYWIN32_INSTALLER%
    endlocal
goto :eof
