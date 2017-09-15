@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
setlocal
set RUN_TEST=no
REM Microsoft Visual C++ environment setup file
set VCVARS=C:\Program Files\Microsoft Visual Studio 8\VC\bin\vcvars32.bat
if /i "%1" == "-H" goto :SHOWHELP
if /i "%1" == "/H" goto :SHOWHELP
if /i "%1" == "-x" set RUN_TEST=yes
if /i "%1" == "/X" set RUN_TEST=yes
@if %RUN_TEST% == yes shift
set CC_QUALS=
set SHOW_CL_HELP=no
:ARG_LOOP
    set ARG1=%1
    if "%ARG1:~0,1%" == "/" (
	if "%ARG1%" == "/?" set SHOW_CL_HELP=yes
	set CC_QUALS=%CC_QUALS% %1
	shift
	goto :ARG_LOOP
    )

call "%VCVARS%"

if %SHOW_CL_HELP% == yes (
    cl /?
    goto :BYE
)

if "%1" == "" goto :SHOWHELP


REM .c extension is optional
set C_FILE=%~n1.c
set EXE_FILE=%~n1.exe

@echo on
cl %CC_QUALS% %C_FILE%
@if [%CKP%]==[] echo off
@if ERRORLEVEL 1 goto :BYE
@if %RUN_TEST% == yes echo Running %EXE_FILE%
@if %RUN_TEST% == yes %EXE_FILE%
)
goto :BYE

:SHOWHELP
echo Usage: %0 [-h -x] [cl_qualifiers] file
echo compiles a C file using Microsoft Visual C++
echo         -h  display this message and terminate
echo         -x  run executable file after compiling
echo %~nx0: $Revision: 1.1 $

:BYE
endlocal
goto :EOF
@REM                   Copyright 2011 by David M. Elins
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
