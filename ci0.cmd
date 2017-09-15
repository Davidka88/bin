@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

setlocal
if %1.==. goto :SHOWHELP
set ARG1=%1
if "%ARG1:~0,1%" == "/" goto :SHOWHELP
if "%ARG1:~0,1%" == "-" goto :SHOWHELP

@REM lbash.exe should be on the PATH & symbolically linked to the real bash.exe
set BASHEXE=lbash

for %%F in (%*) do call :CHECKIN %%F
goto :BYE

:CHECKIN
@REM Make sure RCS directory exists, create Linux symbolic link if it doesn't
  if NOT EXIST RCS %BASHEXE% -c "ln -s `pwd | sed s=/c/=/c/Users/passp/OneDrive/RCS/=` RCS"
  set RCSFILE=RCS/%1,v
  set REV0=
  %BASHEXE% -c "test -e %RCSFILE%"
  if ERRORLEVEL 1 set REV0=-r1.0
  @echo on
  %BASHEXE% -c "ci -l %REV0% %1"
  @if [%CKP%]==[] echo off
  goto :EOF

:SHOWHELP
echo %0 checks in a file setting the first revision to 1.0 if th RCS file doesn't exist
echo Usage:  %0 file file [file...]
echo %~nx0: $Revision: 1.8 $

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
