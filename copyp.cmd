@REM set CKP non-blank to trace command procedure operation
@echo off
if %1. == . (
    echo Usage: %0 file [file...]
    echo Copies files to the current directory, first prompting for confirmation
    echo %~nx0: $Revision: 1.1 $
    goto :EOF
)

for %%F in (%*) do call :COPY_ONE "%%F"
goto :EOF

:COPY_ONE
if NOT EXIST "%1" (
    echo File %1 does not exist
    goto :EOF
)
set ANSWER=
set /p ANSWER=Copy %1 [Y] ? 1>&2
if "%ANSWER%" == "" set ANSWER=Y
if /i "%ANSWER:~0,1%" == "Y" copy /-y %1
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
