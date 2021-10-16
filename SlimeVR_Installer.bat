@echo off
for /f "tokens=9,9 delims=/,>" %%d in (
	'curl https://github.com/SlimeVR/SlimeVR-OpenVR-Driver/releases/latest ^|find "v"'
) do set dnet=%%d
for /f "tokens=9,9 delims=/,>" %%s in (
	'curl https://github.com/SlimeVR/SlimeVR-Server/releases/latest ^|find "v"'
) do set snet=%%s
set dnet=%dnet:"=%
set snet=%snet:"=%
:start
set dloc=C:\Program Files (x86)\Steam\steamapps\common\SteamVR\drivers\
set sloc=C:\
cls
echo ------------------
echo SlimeVR Installer
echo Made by kaaku
echo ------------------
echo INSTALL - 1
echo UNINSTALL - 2
echo ------------------
set /p uniins=
if %uniins%==1 goto :ins
if %uniins%==2 goto :uni
if %uniins%== goto :start
:uni
cls
echo CHANGE DRIVER UNINSTALL DIRECTORY
echo PRESS ANY KEY WITH NO TEXT TO SKIP
echo MAKE SURE DIRECTORY ENDS WITH \
echo MAKE SURE DIRECTORY DOES NOT REQUIRE ADMIN RIGHTS
echo DEFAULT DIRECTORY: %dloc%
set /p dloc=
cls
echo SERVER UNINSTALL DIRECTORY
echo PRESS ANY KEY WITH NO TEXT TO SKIP
echo MAKE SURE DIRECTORY ENDS WITH \
echo MAKE SURE DIRECTORY DOES NOT REQUIRE ADMIN RIGHTS
echo DEFAULT DIRECTORY: %sloc%
set /p sloc=
cls
echo DRIVER: %dloc%
echo SERVER: %sloc%
echo ARE THESE CORRECT?
echo [y/n] CASE SENSITIVE
set /p dircon=
if %dircon%==y goto :1
if %dircon%==n goto :start
if %dircon%== goto :start
:1
del /q /s "%userprofile%\Desktop\SlimeVR.lnk"
del /q /s "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\SlimeVR.lnk"
rmdir /q /s "%dloc%slimevr"
rmdir /q /s "%sloc%SlimeVR"
cls
echo SlimeVR SUCCESSFULLY UNINSTALLED
echo PRESS ANY KEY TO CLOSE && pause >nul
exit
:ins
cls
echo CHANGE DRIVER INSTALL DIRECTORY
echo PRESS ANY KEY WITH NO TEXT TO SKIP
echo MAKE SURE DIRECTORY ENDS WITH \
echo MAKE SURE DIRECTORY DOES NOT REQUIRE ADMIN RIGHTS
echo DEFAULT DIRECTORY: %dloc%
set /p dloc=
cls
echo SERVER INSTALL DIRECTORY
echo PRESS ANY KEY WITH NO TEXT TO SKIP
echo MAKE SURE DIRECTORY ENDS WITH \
echo MAKE SURE DIRECTORY DOES NOT REQUIRE ADMIN RIGHTS
echo DEFAULT DIRECTORY: %sloc%
set /p sloc=
cls
echo DRIVER: %dloc%
echo SERVER: %sloc%
echo ARE THESE CORRECT?
echo [y/n] CASE SENSITIVE
set /p dircon=
if %dircon%==y goto :2
if %dircon%==n goto :start
if %dircon%== goto :start
:2
cls
powershell -command "Invoke-WebRequest https://github.com/SlimeVR/SlimeVR-Server/releases/download/%snet%/SlimeVR.zip -OutFile svrs.zip"
powershell -nop -noni -command "Expand-Archive '.\svrs.zip' '%sloc%'"
del /q /s ".\svrs.zip"
echo %snet%>"%sloc%SlimeVR\sver."
powershell -command "Invoke-WebRequest https://github.com/SlimeVR/SlimeVR-OpenVR-Driver/releases/download/%dnet%/slimevr-openvr-driver-win64.zip -OutFile svrd.zip"
powershell -nop -noni -command "Expand-Archive '.\svrd.zip' '%dloc%'"
del /q /s ".\svrd.zip"
echo %dnet%>"%sloc%SlimeVR\dver."
echo %dloc%>"%sloc%SlimeVR\dloc."
powershell -command "Invoke-WebRequest https://github.com/sankaaku/SlimeVR-Batch-Installer/releases/download/v1/AutoUpdater.bat -OutFile run.bat"
move ".\run.bat" "%sloc%SlimeVR"
powershell -command "Invoke-WebRequest https://files.catbox.moe/vjwil9.ico -OutFile slime.ico"
move ".\slime.ico" "%sloc%SlimeVR"
echo Set oWS = WScript.CreateObject("WScript.Shell") > svrsc.vbs
echo sLinkFile = "%userprofile%\Desktop\SlimeVR.lnk" >> svrsc.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> svrsc.vbs
echo oLink.TargetPath = "%sloc%SlimeVR\run.bat" >> svrsc.vbs
echo oLink.WorkingDirectory = "%sloc%SlimeVR" >> svrsc.vbs
echo oLink.Description = "SlimeVR Launcher by kaaku" >> svrsc.vbs
echo oLink.IconLocation = "%sloc%SlimeVR\slime.ico" >> svrsc.vbs
echo oLink.Save >> svrsc.vbs
cscript svrsc.vbs
del /q /s ".\svrsc.vbs"
xcopy "%userprofile%\Desktop\SlimeVR.lnk" "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\"
cls
echo SlimeVR SUCCESSFULLY INSTALLED 
echo PRESS ANY KEY TO CLOSE && pause >nul
exit
