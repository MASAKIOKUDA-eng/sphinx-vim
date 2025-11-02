@echo off
cls
echo ========================================
echo Sphinx-Vim Diagnostic Tool
echo ========================================
echo.
echo This tool will help you find out why
echo completion is not working.
echo.
echo After Vim opens:
echo.
echo 1. Press SPACE to dismiss dialogs
echo 2. Move to line ".. cod"
echo 3. Press "A" for INSERT mode at end
echo 4. Press Ctrl-X then Ctrl-O
echo.
echo Special keys:
echo   F3 = Show diagnostic info
echo   F4 = Test completion manually
echo.
pause
vim -u diagnose.vim
echo.
echo.
echo Did you see a completion menu? (Y/N)
pause
