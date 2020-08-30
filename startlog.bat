@echo off
echo Starting logger, directing output to .\logoutput.txt.
echo Press control+C to quit the logger.
echo.
echo The existing logfile will be overwritten!
pause
del .\logoutput.txt
cls
echo Logger started...
echo Press control+C to quit the logger.
lua logger.lua > logoutput.txt
