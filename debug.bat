@echo off
echo ========================================
echo Sphinx-Vim Debug Mode
echo ========================================
echo.
echo This will help identify why completion is not working.
echo.
echo The debug info will show:
echo - Filetype settings
echo - Omnifunc configuration
echo - Function availability
echo - Test results
echo.
pause
vim -u debug.vim
