@echo off
SETLOCAL EnableDelayedExpansion

echo Checking for Python installation...

where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Installing Python 3.10...
    
    :: Download Python installer
    curl -o python_installer.exe https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe
    
    :: Install Python with pip, add to PATH
    python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    :: Clean up
    del python_installer.exe
    
    :: Refresh environment variables
    call RefreshEnv.cmd
) else (
    echo Python is already installed
)

:: Create and activate virtual environment
echo Creating virtual environment...
python -m venv dfu_venv
call dfu_venv\Scripts\activate.bat

:: Install required packages
echo Installing required packages...
python -m pip install pyusb

:: Copy the DFU script to a temporary file
echo Creating DFU update script...
copy dfu.py temp_dfu.py

:: Run the DFU update
echo Running firmware update...
python temp_dfu.py --mass-erase
python temp_dfu.py rbms-pybdsf2w-usg-ribv3.dfu

:: Clean up
del temp_dfu.py
deactivate

echo Firmware update complete
pause