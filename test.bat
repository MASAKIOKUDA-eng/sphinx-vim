@echo off
echo ========================================
echo Running Sphinx-Vim Tests
echo ========================================
echo.
vim -u run_tests.vim -N -n -i NONE
echo.
echo.
echo Test results saved to test_results.txt
echo.
pause
