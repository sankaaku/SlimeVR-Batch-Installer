for /f "delims=" %%d in (.\dloc.) do set dloc=%%d
for /f "delims=" %%r in (.\dver.) do set dver=%%r
for /f "delims=" %%s in (.\sloc.) do set sloc=%%sSlimeVR
for /f "delims=" %%e in (.\sver.) do set sver=%%e
for /f "tokens=9,9 delims=/,>" %%D in (
	'curl https://github.com/SlimeVR/SlimeVR-OpenVR-Driver/releases/latest ^|find "v"'
) do set dnet=%%D
for /f "tokens=9,9 delims=/,>" %%S in (
	'curl https://github.com/SlimeVR/SlimeVR-Server/releases/latest ^|find "v"'
) do set snet=%%S
set dnet=%dnet:"=%
set snet=%snet:"=%
if %dver%==%dnet% (goto :cs) else (goto :ud)
:ud
del /q /s "%dloc%slimevr"
powershell -Command "Invoke-WebRequest https://github.com/SlimeVR/SlimeVR-OpenVR-Driver/releases/download/%dnet%/slimevr-openvr-driver-win64.zip -OutFile SVRD.zip"
powershell.exe -NoP -NonI -Command "Expand-Archive '.\SVRD.zip' '%dloc%'"
del /q /s ".\SVRD.zip"
echo %dnet%>.\dver.
:cs
if %sver%==%snet% (goto :l) else (goto :us)
:us
powershell -Command "Invoke-WebRequest https://github.com/SlimeVR/SlimeVR-Server/releases/download/%snet%/slimevr.jar -OutFile slimevr.jar"
echo %snet%>.\sver.
:l
start javaw -Xmx512M -jar slimevr.jar
