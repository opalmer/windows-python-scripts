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

