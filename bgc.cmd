@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
setlocal
prompt %~n0$G$G$S

set USE_TAIL_PGM=-t

REM Windows supports file links for files which will change the value of %0
REM file name ends with q if this is quiet version
set ME=%~n0
if /i %ME:~-1% == q set USE_TAIL_PGM=

set JOBNAME=%~n0%RANDOM%
REM Generate job and log file names in case user doesn't specify them
set BGL_WIN_TITLE_OVERRIDE=%JOBNAME%

:CHECK_QUAL_LOOP
    if %1.==. goto :CHECK_DONE
    if %1.==/?. goto :SHOWHELP
    if /i %1.==-h. goto :SHOWHELP
    shift /1
    goto :CHECK_QUAL_LOOP

:CHECK_DONE

set TMPFILE=%TEMP%\%JOBNAME%.cmd
call :GENERATE_CMD_FILE
if %CTR% == 1 (
    echo No commands specified, exiting
    del %TMPFILE%
    goto :BYE
)
echo REM Ignore "batch file cannot be found" message (Dos problem?) >> %TMPFILE%
echo del %TMPFILE% >> %TMPFILE%

call bg log2 -l %JOBNAME% -o %USE_TAIL_PGM% %* %TMPFILE%
goto :BYE

:GENERATE_CMD_FILE
echo REM Generated file: %TMPFILE% > %TMPFILE%
echo type %TMPFILE% >> %TMPFILE%
prompt %~n0$G$G$S
echo Enter commands, empty line to finish:
set CTR=1
:GEN_LOOP
set LINE=
set /p LINE=Line %CTR%: 
if "%LINE%" == "" goto :EOF
set /a CTR = %CTR% + 1
echo %LINE% >> %TMPFILE%
goto :GEN_LOOP

:SHOWHELP
echo %0 prompts for commands, builds a .cmd file of those commands,
echo     and then runs that .cmd file in the "background" and logs the output
echo     by calling bg log2 -o -t with the generated .cmd file as an argument
echo Usage: %0 [-h]
echo        -h: prints this text and exits
echo            any other options specified are passed to log2
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
