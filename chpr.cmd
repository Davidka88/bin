@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

REM toggle command prompt display
if NOT defined PROMPT goto :NO_PATH_PROMPT
if NOT .%PROMPT:$P=%==.%PROMPT% goto :NO_PATH_PROMPT
prompt $P$+$G
goto :EOF
:NO_PATH_PROMPT
prompt $+$G
goto :EOF
@REM %~nx0: $Revision: 1.1 $
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
