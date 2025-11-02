@echo off
echo ==========================================
echo Sphinx-Vim Quick Start
echo ==========================================
echo.
echo This will open Vim with the plugin loaded.
echo.
echo After Vim opens:
echo   1. Press 'i' to enter INSERT mode
echo   2. Move to line 6 (the line with '.. ')
echo   3. Press 'A' to go to end of line
echo   4. Press Ctrl-X, then Ctrl-O
echo   5. You should see a completion menu!
echo.
echo Press any key to start...
pause > nul

cd /d "%~dp0"
vim -u test_insert_mode.vim

echo.
echo Test finished!
pause
