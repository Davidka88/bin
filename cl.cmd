@REM $Id: cl.cmd,v 1.0 2017/08/19 04:31:43 david Exp david $
@REM set CKP non-blank to trace command procedure operation
@if [%CKP%]==[] echo off
setlocal
set CommandPromptType=Native
set DevEnvDir=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\
set ExtensionSdkDir=C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs
set Framework40Version=v4.0
set FrameworkDir=C:\Windows\Microsoft.NET\Framework64\
set FrameworkDir64=C:\Windows\Microsoft.NET\Framework64\
set FrameworkVersion=v4.0.30319
set FrameworkVersion64=v4.0.30319
set INCLUDE=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\ATLMFC\include;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\include;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\include\um;C:\Program Files (x86)\Windows Kits\10\include\10.0.15063.0\ucrt;C:\Program Files (x86)\Windows Kits\10\include\10.0.15063.0\shared;C:\Program Files (x86)\Windows Kits\10\include\10.0.15063.0\um;C:\Program Files (x86)\Windows Kits\10\include\10.0.15063.0\winrt;
set LIB=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\ATLMFC\lib\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\lib\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\lib\um\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.15063.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.15063.0\um\x64;
set LIBPATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\ATLMFC\lib\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\lib\x64;C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.15063.0\;C:\Program Files (x86)\Windows Kits\10\References\10.0.15063.0\;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;
set NETFXSDKDir=C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\
set __VSCMD_PREINIT_PATH=%PATH%
set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\bin\HostX64\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\VC\VCPackages;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\bin\Roslyn;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Team Tools\Performance Tools;C:\Program Files (x86)\Microsoft Visual Studio\Shared\Common\VSPerfCollectionTools\;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\;C:\Program Files (x86)\Windows Kits\10\bin\x64;C:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0\x64;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\\MSBuild\15.0\bin;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\;%PATH%
set Platform=x64
set UCRTVersion=10.0.15063.0
set UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
set VCIDEInstallDir=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\VC\
set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\
set VCToolsInstallDir=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\
set VCToolsRedistDir=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Redist\MSVC\14.10.25017\
set VisualStudioVersion=15.0
set VS150COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\
set VSCMD_ARG_app_plat=Desktop
set VSCMD_ARG_HOST_ARCH=x64
set VSCMD_ARG_TGT_ARCH=x64
set VSCMD_VER=15.0.26430.16
set VSINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\
set WindowsLibPath=C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.15063.0\;C:\Program Files (x86)\Windows Kits\10\References\10.0.15063.0\
set WindowsSdkBinPath=C:\Program Files (x86)\Windows Kits\10\bin\
set WindowsSdkDir=C:\Program Files (x86)\Windows Kits\10\
set WindowsSDKLibVersion=10.0.15063.0\
set WindowsSdkVerBinPath=C:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0\
set WindowsSDKVersion=10.0.15063.0\
set WindowsSDK_ExecutablePath_x64=C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\
set WindowsSDK_ExecutablePath_x86=C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\
set __DOTNET_ADD_64BIT=1
set __DOTNET_PREFERRED_BITNESS=64
set INCLUDE=%INCLUDE%;C:\Users\passp\OneDrive\Projects\headers
cl.exe %*
