@echo off
setlocal

REM Updates the official Anthropic SDK packages used by this restored tree.
REM Run from anywhere; the script switches to the repository root first.

cd /d "%~dp0"

where bun >nul 2>nul
if errorlevel 1 (
    echo Error: bun was not found in PATH.
    echo Install Bun or add it to PATH, then run this script again.
    exit /b 1
)

echo Updating Anthropic SDK packages...
call bun update @anthropic-ai/sdk @anthropic-ai/claude-agent-sdk
if errorlevel 1 (
    echo Error: SDK update failed.
    exit /b 1
)

echo Refreshing dependencies...
call bun install
if errorlevel 1 (
    echo Error: dependency install failed.
    exit /b 1
)

echo Verifying CLI version...
call bun run version
if errorlevel 1 (
    echo Error: version smoke test failed.
    exit /b 1
)

echo SDK update completed.
