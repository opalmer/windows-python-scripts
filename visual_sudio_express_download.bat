@echo off

if [%SOURCES%] == [] (
    set SOURCES=sources
)

if not exist %SOURCES%\isos (
    mkdir %SOURCES%\isos
)

echo "Downloading Visual Studio 2008"
curl --silent -C - -o %SOURCES%\isos\VS2008.iso http://download.microsoft.com/download/E/8/E/E8EEB394-7F42-4963-A2D8-29559B738298/VS2008ExpressWithSP1ENUX1504728.iso
echo "Downloading Visual Studio 2010"
curl --silent -C - -o %SOURCES%\isos\VS2010.iso http://download.microsoft.com/download/1/E/5/1E5F1C0A-0D5B-426A-A603-1798B951DDAE/VS2010Express1.iso
echo "Extracting Visual Studio 2008"
7z x %SOURCES%\isos\VS2008.iso -o%SOURCES%\isos\VS2008 -bd
echo "Extracting Visual Studio 2010"
7z x %SOURCES%\isos\VS2010.iso -o%SOURCES%\isos\VS2010 -bd