@echo off
SETLOCAL EnableDelayedExpansion

echo =====================================
echo DFU Firmware Update Tool
echo =====================================

:: Activate the virtual environment
call dfu_env\Scripts\activate.bat

echo [1/2] Checking device connection...
python dfu.py -l

echo [2/2] Running firmware update...
python dfu.py -m
python dfu.py "rbms-pybdsf2w-usg-ribv3.dfu"

deactivate

echo =====================================
echo Firmware update completed
echo =====================================
pause