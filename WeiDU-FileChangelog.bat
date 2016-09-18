@ECHO OFF
setlocal enabledelayedexpansion
pushd "%temp%"
makecab /D RptFileName=~.rpt /D InfFileName=~.inf /f nul >nul
for /f "tokens=3-7" %%a in ('find /i "makecab"^<~.rpt') do (
   set "current-date=%%e-%%b-%%c"
   set "current-time=%%d"
)
del ~.*
popd
SET dt=%current-date%
echo %dt%
if "%~1"=="" (
	SET /P filename=No parameters have been provided, please enter filename: 
	GOTO PROCESS
) ELSE (
	SET filename=%*
	GOTO PROCESS
)
:PROCESS
	IF "%filename%"=="" GOTO Error
		ECHO %filename%
		ECHO WARNING: WEIDU LIMITATION PREVENTS DETECTING FIRST MOD WHICH MODIFY/CHANGE FILE! > WeiDU-FileChangelog/%filename%-WeiDU-FileChangelog-%dt%.txt
		ECHO. >> WeiDU-FileChangelog/%filename%-WeiDU-FileChangelog-%dt%.txt
		WeiDU-FileChangelog.exe --log nul --change-log %filename% >> WeiDU-FileChangelog/%filename%-WeiDU-FileChangelog-%dt%.txt --out WeiDU-FileChangelog
		ECHO Log file path: WeiDU-FileChangelog\%filename%-WeiDU-FileChangelog-%dt%.txt
		GOTO End
:Error
	ECHO You did not enter filename!
:End
	ECHO WARNING: WEIDU LIMITATION PREVENTS DETECTING FIRST MOD WHICH MODIFY/CHANGE FILE!
	START "" /B type WeiDU-FileChangelog\%filename%-WeiDU-FileChangelog-%dt%.txt
	START "" NOTEPAD.exe WeiDU-FileChangelog\%filename%-WeiDU-FileChangelog-%dt%.txt
