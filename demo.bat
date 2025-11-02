@echo off
echo ========================================
echo Sphinx-Vim Interactive Demo
echo ========================================
echo.
echo Starting Vim demo...
echo.
echo IMPORTANT:
echo 1. Press 'i' key to enter INSERT mode
echo 2. Look at bottom of screen for "-- INSERT --"
echo 3. Press Ctrl-X then Ctrl-O for completion
echo 4. Press Esc to return to NORMAL mode
echo 5. Type :q and press Enter to quit
echo.
pause
vim -u demo.vim
