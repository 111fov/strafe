@echo off
rem Runs Strafe with its data beside this file. Security software can deny an unsigned
rem build any write inside the user profile, and then the cache, saved logins and the
rem diagnostic log all stay read-only. Put this file next to strafe.exe.
setlocal
set "ROOT=%~dp0"
if not exist "%ROOT%strafe.exe" (
	echo Put this file next to strafe.exe.
	exit /b 1
)
if not exist "%ROOT%data" mkdir "%ROOT%data"
set "STRAFE_DATA_DIR=%ROOT%data"
start "" "%ROOT%strafe.exe" %*
endlocal
