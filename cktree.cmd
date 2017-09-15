@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

REM Run a command over files in a directory tree
setlocal
if %1.==/?. goto :SHOWHELP
if /i %1.==-h. goto :SHOWHELP
if /i %1.==-help. goto :SHOWHELP
if /i %1.==--help. goto :SHOWHELP

call :STRIP_QUOTES CMD %1
if .%1==. set CMD=cksum
set DIR=%2
if .%2==. set DIR=.
if "%CMD%"=="ls" (
    cygfind %DIR% -type f -ls
) else (
    cygfind %DIR% -type f -exec %CMD% {} ;
)
goto :BYE

:STRIP_QUOTES
    set %1=%~2
    goto :EOF

:SHOWHELP
    echo cktree [cmd] [dir], cmd default=cksum, dir default=.
    echo scans files in tree using cygfind
    echo %~nx0: $Revision: 1.1 $
    goto :BYE

REM # awk script to extract size and file name from ls listing
REM {
REM     size = $7
REM     nm = $0
REM     sub(/.*\.\//, "/")
REM     gsub(/\//, "\\")
REM     print size "\t" $0
REM }

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
