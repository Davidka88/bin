@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
setlocal
prompt %~n0$G$G$S
set C=/C
set WIN_TITLE=
set MSG_PGM=MessageBox.exe
set MSG_WAIT_SECONDS=20

set CMDLINE=%*

set NOTIFY_ON_COMPLETION=yes
set W_OPTION_SPECIFIED=no

:CHECK_QUAL_LOOP
    if %1.==/?. goto :SHOWHELP
    if %1.==. goto :CHECK_DONE
    set ARG1=%1
    if NOT %ARG1:~0,1%==- goto :CHECK_DONE
    shift /1
    if /i %ARG1% == -h goto :SHOWHELP
    if /i %ARG1% == --notify (
	set NOTIFY_ON_COMPLETION=no
	set CMDLINE=%CMDLINE:--notify=%
	goto :CHECK_QUAL_LOOP
    )
    if /i %ARG1% == -k (
	set C=/K
	set CMDLINE=%CMDLINE:-k =%
	goto :CHECK_QUAL_LOOP
    )
    if /i %ARG1% == -w (
	if %1.==. (
	    echo Missing window title for -w option
	    goto :BYE
	)
	set WIN_TITLE=%~1
	set W_OPTION_SPECIFIED=yes
	shift /1
	goto :CHECK_QUAL_LOOP
    )
    echo Invalid option %ARG1% specified
    goto :BYE

:CHECK_DONE

if %1. == . goto :SHOWHELP

if "%WIN_TITLE%" == "" (
    if NOT %BGL_WIN_TITLE_OVERRIDE%. == . (
	set WIN_TITLE=%BGL_WIN_TITLE_OVERRIDE%
    ) else (
	set WIN_TITLE=%0_%1_%RANDOM%
    )
)

if %W_OPTION_SPECIFIED% == no goto :COMMAND_GENERATED

echo -w specified, arguments of the form a=b will not be parsed correctly

set CMDLINE=

:GENERATE_COMMAND_FROM_EACH_ARG
    set ARG1=%1
    shift /1
    set CMDLINE=%CMDLINE% %ARG1%
    if NOT %1.==. goto :GENERATE_COMMAND_FROM_EACH_ARG

:COMMAND_GENERATED
call :STRIP_CMDLINE
call :MSG_BUILD
set MSG=/C:Background Command: %MSG%

echo start "%WIN_TITLE%" /min cmd %C% %CMDLINE%

if %NOTIFY_ON_COMPLETION% == yes set CMDLINE="%CMDLINE% & %MSG_PGM% %MSG%"

start "%WIN_TITLE%" /min cmd %C% %CMDLINE%
goto :BYE

:MSG_BUILD
    set MSG=%WIN_TITLE%\n
    set MSG=%MSG%%CMDLINE% finished
    set MSG=\n%MSG%\n(this message box will close in %MSG_WAIT_SECONDS% seconds)
    set MSG=/W:%MSG_WAIT_SECONDS% /M:%MSG%
    goto :EOF

:STRIP_CMDLINE
    if NOT "%CMDLINE:~0,1%" == " " goto :EOF
    set CMDLINE=%CMDLINE:~1%
    goto :STRIP_CMDLINE

:SHOWHELP
echo %0 runs a command in the "background"
echo    by starting it in a minimized separate window
echo Usage: %0 [--notify] [-k] [-w title] [-h] command
echo        by default, a dialog box pops (%MSG_PGM%) when the command finishes
echo        --notify suppresses the dialog box
echo        -k will cause the window to remain (uses cmd /K instead of cmd /C)
echo        -w specifies alternate title for background window.
echo           note: arguments of the form -w a=b are parsed incorrectly
echo        -h will print this message and terminate.
echo        %MSG_PGM% should be located on the executable PATH
echo        If not present on the system, it can be downloaded
echo        and extracted from http://www.optimumx.com/download/MessageBox.zip
echo %~nx0: $Revision: 1.2 $

:BYE
endlocal
goto :EOF
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
