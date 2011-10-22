@echo off

set buildDir=%~dp0%build
set toolsDir=%~dp0%packages\psake.4.0.1.0\tools\

echo buildDir is: %buildDir%
echo toolsDir is: %toolsDir%

if '%1'=='/?' goto usage
if '%1'=='-?' goto usage
if '%1'=='?' goto usage
if '%1'=='/help' goto usage
if '%1'=='help' goto usage

powershell -NoProfile -ExecutionPolicy unrestricted -Command "& '%toolsDir%psake.ps1' '%buildDir%\build.ps1' -framework 4.0"

goto :eof
:usage
powershell -NoProfile -ExecutionPolicy unrestricted -Command "& '%DIR%psake-help.ps1'"