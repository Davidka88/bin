@REM $Id: attr2.cmd,v 1.0 2017/04/05 01:28:54 david Exp david $
@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
setlocal

setlocal

if %1.==. goto :SHOWHELP
if %1.==/?. goto :SHOWHELP
if /i %1.==-help. goto :SHOWHELP
if /i %1.==--help. goto :SHOWHELP

set ATTR=
set ARG1=%1
if "%ARG1:~0,1%"=="+" set ATTR=%ARG1%
if "%ARG1:~0,1%"=="-" set ATTR=%ARG1%
if NOT "%ATTR%"=="" shift /1
if %1.==. goto :SHOWHELP

:ARGLOOP
    if "%1"=="" goto :BYE
    if NOT "%ATTR%"=="" attrib %ATTR% %1
    attrib %1
    shift /1
    goto :ARGLOOP

:SHOWHELP
    echo %0 changes or displays the attributes of its filename arguments
    echo Usage: %0 [+or- attr] file [file...]
    echo %~nx0: $Revision: 1.0 $
    goto :BYE

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
