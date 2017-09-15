@REM set CKP non-blank to trace command procedure operation
@if %CKP%.==. echo off

rem -- Run Vim --

setlocal
set VIM_EXE_DIR=C:\Program Files (x86)\Vim\vim80
if exist "%VIM%\vim80\gvim.exe" set VIM_EXE_DIR=%VIM%\vim80
if exist "%VIMRUNTIME%\gvim.exe" set VIM_EXE_DIR=%VIMRUNTIME%

if exist "%VIM_EXE_DIR%\gvim.exe" goto havevim
echo "%VIM_EXE_DIR%\gvim.exe" not found
goto eof

:havevim
rem collect the arguments in VIMARGS for Win95
set REMOTE_ARGS=--servername gvim --remote-silent
set VIMARGS=%REMOTE_ARGS%
set VIMNOFORK=
:loopstart
if .%1==. goto loopend
if NOT .%1==.--nofork goto noforklongarg
set VIMNOFORK=1
:noforklongarg
if NOT .%1==.-f goto noforkarg
set VIMNOFORK=1
:noforkarg
set VIMARGS=%VIMARGS% %1
shift
goto loopstart
:loopend

if "%VIMARGS%"=="" goto showhelp
if "%VIMARGS%"=="%REMOTE_ARGS%" goto showhelp

if .%OS%==.Windows_NT goto ntaction

if .%VIMNOFORK%==.1 goto nofork
start "%VIM_EXE_DIR%\gvim.exe"  %VIMARGS%
goto eof

:nofork
start /w "%VIM_EXE_DIR%\gvim.exe"  %VIMARGS%
goto eof

:ntaction
rem for WinNT we can use %*
if .%VIMNOFORK%==.1 goto noforknt
start "dummy" /b "%VIM_EXE_DIR%\gvim.exe"  %REMOTE_ARGS% %*
goto eof

:noforknt
start "dummy" /b /wait "%VIM_EXE_DIR%\gvim.exe"  %REMOTE_ARGS% %*
goto eof

:showhelp
    echo Usage: %0 file [files ...]
    echo        sends files to existing instance of gvim
    echo %~nx0: $Revision: 1.2 $

:eof
set VIMARGS=
set VIMNOFORK=
@REM                   Copyright 2016 by David M. Elins
@REM
@REM This program is free software: you can redistribute it and/or modify
@REM it under the terms of the GNU General Public License as published by
@REM the  Free  Software  Foundation, either version 3 of the License, or
@REM (at your option) any later version.
@REM
@REM This program is distributed in the hope that it will be useful,  but
@REM WITHOUT   ANY   WARRANTY;  without  even  the  implied  warranty  of
@REM MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the  GNU
@REM General Public License for more details.
@REM
@REM A  copy  of  the  GNU  General  Public  License  (GPL)  be  found at
@REM <http://www.gnu.org/licenses/gpl-3.0-standalone.html>.
@REM
@REM One  is  supposed  to be included here but doing so would bloat this
@REM source code too much.
@REM vim:tabstop=8:shiftwidth=4:noexpandtab
