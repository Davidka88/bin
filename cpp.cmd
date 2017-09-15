@REM $Id: cpp.cmd,v 1.0 2017/08/19 04:34:55 david Exp david $
@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
cl.cmd -EHa %*
