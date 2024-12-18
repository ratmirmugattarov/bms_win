@echo off
SETLOCAL EnableDelayedExpansion

echo =====================================
echo DFU Firmware Update Tool
echo =====================================

:: Activate the virtual environment
call C:\dfu_venv\Scripts\activate.bat

echo [1/2] Checking device connection...
C:\dfu_venv\Scripts\python.exe dfu.py -l

echo [2/2] Running firmware update...
C:\dfu_venv\Scripts\python.exe dfu.py -m
C:\dfu_venv\Scripts\python.exe dfu.py "rbms-pybdsf2w-usg-ribv3.dfu"

deactivate

echo =====================================
echo Firmware update completed
echo =====================================
pause