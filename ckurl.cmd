@REM $Id: ckurl.cmd,v 1.0 2017/04/05 01:28:54 david Exp david $
@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off

setlocal
if .%1==. goto :ASK
if .%1==.reset goto :RESET
:FORCEIP
graburl "http://freedns.afraid.org/dynamic/update.php?UWd3ZmowVmRMUG9BQVNYQWxHbzo3Mjg5MTY=&address=%1"
goto :BYE
:ASK
graburl %1 http://checkip.dyndns.org/ | sed -e "s+.*: +IP address is +" -e "s+<.*++"
goto :BYE
:RESET
graburl "http://freedns.afraid.org/dynamic/update.php?UWd3ZmowVmRMUG9BQVNYQWxHbzo3Mjg5MTY="
goto :BYE
rem original version
c:
cd "\Documents and Settings\David\My Documents\Data\Logs"
wget -q -O url.tmp http://checkip.dyndns.org/
sed -e 's/.*: /URL is still /' -e "s/<.*//" url.tmp > url.log
del url.tmp
diff url.log oldurl.log > NUL 2>&1
if not errorlevel 1 type oldurl.log && goto :BYE
del oldurl.log
ren url.log oldurl.log
wget -q -O url.tmp http://freedns.afraid.org/dynamic/update.php?UWd3ZmowVmRMUG9BQVNYQWxHbzo3Mjg5MTY=
type url.tmp
del url.tmp
:BYE
endlocal
REM $Id: ckurl.cmd,v 1.0 2017/04/05 01:28:54 david Exp david $
