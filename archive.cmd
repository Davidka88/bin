@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

setlocal

set K_OPTION_SPECIFIED=no

:CHECK_QUAL_LOOP
    if %1.==/?. goto :SHOWHELP
    if %1.==. goto :CHECK_DONE
    set ARG1=%1
    if NOT %ARG1:~0,1%==- goto :CHECK_DONE
    shift /1
    if /i %ARG1% == -h goto :SHOWHELP
    if /i %ARG1% == -k (
        set K_OPTION_SPECIFIED=yes
        goto :CHECK_QUAL_LOOP
    )
    echo Invalid option %ARG1% specified
    goto :BYE

:CHECK_DONE
if %1. == . goto :SHOWHELP

:LOOP
    if %1. == . goto :BYE
    call :CHECKIN %1
    shift /1
    goto :LOOP

:CHECKIN
    set EXT=%~x1
    if exist RCS goto :CHECKIN2
    set ANSWER=
    set /p ANSWER=RCS directory does not exist. Create it? [Y] 
    if "%ANSWER%" == "" set ANSWER=Y
    if /i NOT "%ANSWER:~0,1%" == "Y" goto :EOF
    @echo on
    mkdir RCS
    @if [%CKP%]==[] echo off

:CHECKIN2
    set RCSFILE=RCS\%~1,v
    if EXIST "%RCSFILE%" goto :NORMAL_CHECKIN
    REM -k option only applies to first check in
    set CHECKIN_ROUTINE=NO_KEYWORD_EXPANSION
    if /i "%EXT%" == ".c" set CHECKIN_ROUTINE=NORMAL_CHECKIN
    if /i "%EXT%" == ".h" set CHECKIN_ROUTINE=NORMAL_CHECKIN
    if /i "%EXT%" == ".cpp" set CHECKIN_ROUTINE=NORMAL_CHECKIN
    if /i "%EXT%" == ".cmd" set CHECKIN_ROUTINE=NORMAL_CHECKIN
    if %K_OPTION_SPECIFIED%==yes goto :NOT_%CHECKIN_ROUTINE%
    goto :%CHECKIN_ROUTINE%

:NORMAL_CHECKIN
:NOT_NO_KEYWORD_EXPANSION
    set REV=-r1.0
    if EXIST "%RCSFILE%" set REV=
    @echo on
    ci -l %REV% %1
    @if [%CKP%]==[] echo off
    goto :EOF

:NO_KEYWORD_EXPANSION
:NOT_NORMAL_CHECKIN
    @echo on
    ci -r1.0 %1
    rcs -ko %1
    co -l %1
    @if [%CKP%]==[] echo off
    goto :EOF

:SHOWHELP
echo %0 uses RCS to check in a file, setting the first revision to 1.0
echo Usage:  %0 [-k] file file [file...]
echo         By default, RCS Keyword expansion is performed
echo         for .c .cpp .h .cmd and .bat files and not for others
echo         -k  reverses this interpretation
echo             (-k only applies to initial checkin)
echo         Notes: 1. The archive is stored in RCS subdirectory,
echo                   which will be created if necessary
echo                2. Each file specified invokes ci separately
echo                   unlike the ci command, there is no opportunity
echo                   to reuse the previous checkin message.
echo                   There's always cut-and-paste, though.
echo %~nx0: $Revision: 1.4 $

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
