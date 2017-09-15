@REM $Id: ask.cmd,v 1.0 2017/04/05 01:28:54 david Exp david $
@REM set CKP non-blank to trace command procedure operation
@if %CKP%.==. echo off

setlocal

prompt %~n0$G$G$S


call :ASK_USER PGM_ARGS "Command line arguments for  testing"
goto :BYE

:ASK_USER
    call :STRIP_QUOTES QUERY %2
    call :STRIP_QUOTES DFLT_ANSWER %3
    set QUERY=%QUERY% ? 
    set ANSWER=
    set /p ANSWER=%QUERY%
    echo ANSWER is %ANSWER%
    set %1=%ANSWER%
    goto :EOF

:STRIP_QUOTES
    set %1=%~2
    goto :EOF


:BYE
    echo %PGM_ARGS%
    endlocal
    goto :EOF
