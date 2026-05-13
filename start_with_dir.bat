@echo off
REM Claude Code launcher with custom working directory
REM Usage: start_with_dir.bat <target-directory> [additional args...]

if "%~1"=="" (
    echo Usage: start_with_dir.bat ^<directory^> [args...]
    echo Example: start_with_dir.bat C:\my-project
    exit /b 1
)

REM Claude Code project root (where this script lives)
set "CLAUDE_DIR=%~dp0%"

set "TARGET_DIR=%~1"
shift

if not exist "%TARGET_DIR%" (
    echo Error: Directory "%TARGET_DIR%" does not exist
    exit /b 1
)

REM Collect remaining args (excluding the target dir) into EXTRA_ARGS.
REM In cmd.exe, %* is unaffected by shift, so we must rebuild manually.
set "EXTRA_ARGS="
:collect_args
if "%~1"=="" goto args_done
set "EXTRA_ARGS=%EXTRA_ARGS% %1"
shift
goto collect_args
:args_done

REM Switch into the target directory so process.cwd() reflects it.
REM bun resolves node_modules from the script's location upward, so passing
REM the absolute path to bootstrap-entry.ts still finds the project's deps.
cd /d "%TARGET_DIR%"
bun run "%CLAUDE_DIR%src\bootstrap-entry.ts" --dangerously-skip-permissions%EXTRA_ARGS%