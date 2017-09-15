@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

if .%1==. (
    echo Usage: %0 process_name [FO_option]
    echo        is equivalent to tasklist /FI imagemane eq process_name.exe
    echo        type tasklist /? for more information
    goto :EOF
)
setlocal
set FO=/FO
if .%2==. set FO=
echo on
tasklist /FI "imagename eq %1.exe" %FO% %2 %3 %4 %5 %6
@echo off
endlocal
goto :EOF
@REM %~nx0: $Revision: 1.2 $
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
