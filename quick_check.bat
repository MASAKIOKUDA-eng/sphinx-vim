@echo off
echo ========================================
echo Quick Check - Open Vim with plugin
echo ========================================
echo.
echo This will open test.rst with the plugin loaded.
echo.
echo After Vim opens:
echo 1. Press 'i' to enter INSERT mode
echo 2. Go to line 6 (with '..')
echo 3. Press Ctrl-X Ctrl-O
echo.
echo You should see completion menu!
echo.
pause

vim -u NONE -c "set runtimepath+=%~dp0" -c "filetype plugin on" -c "edit test.rst" -c "set filetype=rst"
