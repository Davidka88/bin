@REM $Id: pd.cmd,v 1.0 2017/04/05 01:28:54 david Exp david $
@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

REM name and location of this procedure
setlocal

set CMND=
set CD_IN_PROMPT=no
set PROMPTX=%PROMPT%x
if "%PROMPTX%"=="x" set CD_IN_PROMPT=yes
if NOT "%PROMPTX:$P=%"=="%PROMPTX%" set CD_IN_PROMPT=yes
if %CD_IN_PROMPT%==no set CD_CMND=^& echo. ^& cd
set CATCHPHRASE=Push directory
set DIR_VAR=PUSH_DIR
call :SET_PROMPT %0

if %1.==. goto :SHOW_STACK
if %1.==/?. goto :SHOWHELP
if %1.==-?. goto :SHOWHELP
call :STRIP_QUOTES ARG1 %1
if /i "%ARG1%"=="-h" goto SHOWHELP
if /i "%ARG1%"=="-help" goto SHOWHELP
if /i "%ARG1%"=="--help" goto SHOWHELP

set MYNAME=%~nx0
set BINDIR=%~dp0

if /i "%ARG1%"=="-mk" goto :MAKE_CALLER
if /i "%ARG1%"=="-f" goto :LIST_CMDFILES
if /i "%ARG1%"=="-s" goto :SWAP_DIRS
if /i "%ARG1%"=="-swap" goto :SWAP_DIRS
if /i "%ARG1%"=="-l" goto :SHOW_STACK
REM specify leading - to allow dir named -mk, etc.
if /i "%ARG1%"=="-" call :STRIP_QUOTES ARG1 %2

REM If we reach here, push the directory argument
    set NEWDIR=%ARG1:/=\%
    set CMND=^& pushd %NEWDIR%
    if NOT EXIST "%NEWDIR%" echo The system cannot find the path specified: %NEWDIR%
    if NOT EXIST "%NEWDIR%" set CMND=
    if %CD_IN_PROMPT%==no set CD_CMND=^& cd
    goto :DO_COMMAND

:SHOW_STACK
    call :STACK_DEPTH
    if %DIRCNT%==0 echo Directory stack is empty & goto :DO_COMMAND
    echo ==^>%CD%
    set CD_CMND=
    pushd
    goto :DO_COMMAND

:SHOWHELP
    echo %0 is a front end for the cd command that replaces / with \ in directory names
    echo Usage: %0 [-mk] [-s] [-] [-h] [directory_arg]
    echo        -mk dir keyword will generate pd%%keyword%%.cmd to push directory_arg
    echo        -f will display the pd*.cmd files created by "pd -mk"
    echo        -l display the directory stack
    echo        -s or -swap will swap the top two stacked directories
    echo        -  terminates the option specifications,
    echo           allowing -mk, , -s, etc. to be specified as directory_arg
    echo        -h, -help, or --help will display this information
    echo.
    echo %0 also changes the window title to be the new current directory
    echo Without any arguments, %0 will display the directory stack (like -l)
    echo.
    echo Notes: Type pushd /? for help with the pushd command
    echo %~nx0: $Revision: 1.0 $
    goto :DO_COMMAND

:MAKE_CALLER
    shift /1
    set NEWDIR=%1
    set CMDFILE=%2
    if %NEWDIR%.==. set /p NEWDIR=Directory [Press ^<Enter^> to exit] ? 
    if %NEWDIR%.==. goto :DO_COMMAND
    if /i %NEWDIR% == -swap set NEWDIR=-swap
    if %CMDFILE%.==. set /p CMDFILE=Keyword [Press ^<Enter^> to exit] ? 
    if %CMDFILE%.==. goto :DO_COMMAND
    set CMDFILE=%CMDFILE:.cmd=%
    set CMDFILE=%BINDIR%pd%CMDFILE%.cmd
    set FILE_REPL=YES
    if EXIST %CMDFILE% set /p FILE_REPL=%CMDFILE% exists. Replace it [Y]?
    if %FILE_REPL%.==. set FILE_REPL=YES
    if /i NOT %FILE_REPL:~0,1%==Y goto :DO_COMMAND
    REM expand directory name, display error if failure but create file anyway
    pushd %NEWDIR%
    if ERRORLEVEL 1 goto :CREATE_FILE
    set NEWDIR=%CD%
    popd
:CREATE_FILE
    if EXIST %CMDFILE% del %CMDFILE%
    echo @REM set CKP non-blank to trace command procedure operation>> %CMDFILE%
    echo @REM Created on %DATE% at %TIME%>> %CMDFILE%
    echo @REM by %~nx0: $Revision: 1.0 $>> %CMDFILE%
    echo @if [%%CKP%%]==[] echo off>> %CMDFILE%
    echo setlocal>> %CMDFILE%
    echo prompt %%~n0$G$G$S>> %CMDFILE%
    echo set %DIR_VAR%=%NEWDIR%>> %CMDFILE%
    echo.>> %CMDFILE%
    echo if "%%1" == "" goto :DO_COMMAND>> %CMDFILE%
    echo set ARG1=%%1>> %CMDFILE%
    echo if %%ARG1:~0,1%%==/ set ARG1=-%%ARG1:~1%%>> %CMDFILE%
    echo if %%ARG1%%==/? goto :SHOWHELP>> %CMDFILE%
    echo if %%ARG1%%==-? goto :SHOWHELP>> %CMDFILE%
    echo if /i %%ARG1%%==-h goto SHOWHELP>> %CMDFILE%
    echo if /i %%ARG1%%==-help goto SHOWHELP>> %CMDFILE%
    echo if /i %%ARG1%%==--help goto SHOWHELP>> %CMDFILE%
    echo REM fall through to go to directory specified on command line>> %CMDFILE%
    echo.>> %CMDFILE%
    echo :DO_COMMAND>> %CMDFILE%
    echo REM This file and %~nx0 should be in the same directory (%%~dp0)>> %CMDFILE%
    echo endlocal ^& %%~dp0%MYNAME% %%1 %%2 %%3 %%4 %%5 "%%%DIR_VAR%%%">> %CMDFILE%
    echo echo %%~f0 should not get here>> %CMDFILE%
    echo goto :EOF>> %CMDFILE%
    echo.>> %CMDFILE%
    echo :SHOWHELP>> %CMDFILE%
    set SWMSG= (swap the top two stacked directories)
    if /i NOT "%NEWDIR%" == "-swap" set SWMSG=
    echo endlocal ^& echo %CATCHPHRASE% %%%DIR_VAR%%%%SWMSG%>> %CMDFILE%
    echo echo Type %%~dp0%MYNAME% -h for more details>> %CMDFILE%
    echo Created %CMDFILE%
    goto :DO_COMMAND

:LIST_CMDFILES
    pushd  %BINDIR%
    REM nul forces filename display even if only one file matches
    findstr /%SYSTEMDRIVE%%DIR_VAR%= pd*.cmd nul
    popd
    set CD_CMND=
    goto :DO_COMMAND

:SWAP_DIRS
    call :STACK_DEPTH
    if %DIRCNT%==0 echo No directories to swap & goto :DO_COMMAND
    set TOPDIR=%CD%
    popd
    set DIR_2=%CD%
    pushd %TOPDIR%
    set CMND=^& popd ^& %TOPDIR:~0,2% ^& cd %TOPDIR% ^& pushd %DIR_2%
    goto :DO_COMMAND

:DO_COMMAND
    endlocal %CMND% %CD_CMND%

    setlocal
    call :SET_PROMPT %0

:SET_TITLE_AND_EXIT
    if NOT "%KEEPTITLE%" == "" set KEEPTITLE=%KEEPTITLE%-
    title %KEEPTITLE%%CD%
    goto :BYE

:SET_PROMPT
    set USE_SHORT_PROMPT= ^& %~dp0shpr.cmd on
    if %PROMPT%==%PROMPT:...=% set USE_SHORT_PROMPT=
    if NOT EXIST %~dp0shpr.cmd set USE_SHORT_PROMPT=
    prompt %~n1$G$G$S

:STRIP_QUOTES
    set %1=%~2
    goto :EOF

:STACK_DEPTH
    set TMPFILE=%TEMP%\pd%RANDOM%.txt
    pushd > %TMPFILE%
    set DIRCNT=0
    for /f %%f in (%TMPFILE%) do set /a DIRCNT=DIRCNT+1
    del %TMPFILE%
    goto :EOF

:BYE
    endlocal %USE_SHORT_PROMPT%
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
