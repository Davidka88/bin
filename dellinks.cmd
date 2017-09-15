@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
@REM $Id: dellinks.cmd,v 1.2 2017/04/08 13:08:15 david Exp david $
if exist cddrop.cmd call :UNLINK cddrop.cmd
if exist cdh.cmd call :UNLINK cdh.cmd
if exist cdi.cmd call :UNLINK cdi.cmd
if exist cdone.cmd call :UNLINK cdone.cmd
if exist cdwsl.cmd call :UNLINK cdwsl.cmd
if exist pddrop.cmd call :UNLINK pddrop.cmd
if exist pdh.cmd call :UNLINK pdh.cmd
if exist pdi.cmd call :UNLINK pdi.cmd
if exist pdone.cmd call :UNLINK pdone.cmd
if exist pdwsl.cmd call :UNLINK pdwsl.cmd
if exist wm.cmd call :UNLINK wm.cmd
goto :EOF
:UNLINK
    del %1
    echo deleted %1
:EOF
