@echo off
SETLOCAL EnableDelayedExpansion

echo =====================================
echo DFU Firmware Update Tool
echo =====================================

:: Activate the virtual environment
call dfu_env\Scripts\activate.bat

echo [1/3] Checking device connection...
python dfu.py -l

echo [2/3] Mass erasing...
python dfu.py -m

echo [3/3] Uploading firmware...
python dfu.py --upload "rbms-pybdsf2w-usg-ribv3.dfu"

deactivate

echo =====================================
echo Firmware update completed
echo =====================================
pause