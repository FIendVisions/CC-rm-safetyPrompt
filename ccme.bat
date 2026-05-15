@echo off
REM Shortcut wrapper for start_with_dir.bat
REM Usage: ccme <directory> [additional args...]
REM Example: ccme %cd%

call "%~dp0start_with_dir.bat" %*
