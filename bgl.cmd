@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
setlocal
prompt %~n0$G$G$S

set USE_TAIL_PGM=-t

REM Windows supports file links for files which will change the value of %0
REM file name ends with q if this is quiet version
set ME=%~n0
if /i %ME:~-1% == q set USE_TAIL_PGM=

if %1.==. goto :SHOWHELP

:CHECK_QUAL_LOOP
    if %1.==/?. goto :SHOWHELP
    if /i %1==-h goto :SHOWHELP
    if %1.==. goto :CHECK_DONE
    set ARG1=%1
    if NOT %ARG1:~0,1%==- goto :CHECK_DONE
    shift /1
    goto :CHECK_QUAL_LOOP

:CHECK_DONE

set BGL_WIN_TITLE_OVERRIDE=%0_%1_%RANDOM%

call bg log2 -o %USE_TAIL_PGM% %*
goto :BYE

:SHOWHELP
echo %0 invokes the command procedure combination bg log2 -o %USE_TAIL_PGM% %%*
echo     to run a command in the background and log the output
echo Usage: %0 [-h] command
echo        -h: prints this text and exits
echo            any other options specified are passed to log2
echo %~nx0: $Revision: 1.2 $

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
