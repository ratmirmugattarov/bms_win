@echo off
SETLOCAL EnableDelayedExpansion

echo Checking for Python installation...

where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Installing Python 3.10...
    curl -o python_installer.exe https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe
    python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python_installer.exe
)

:: Create and activate virtual environment
echo Creating virtual environment...
python -m venv dfu_venv
call dfu_venv\Scripts\activate.bat

:: Install required packages
echo Installing required packages...
python -m pip install --upgrade pip
python -m pip install pyusb libusb

:: Install libusb backend
echo Installing USB backend...
curl -L -o libusb-win32-latest.zip https://sourceforge.net/projects/libusb-win32/files/latest/download
tar -xf libusb-win32-latest.zip
.\libusb-win32-bin-*\bin\install-filter-win.exe

:: Run the DFU update
echo Running firmware update...
python dfu.py -m
python dfu.py -v "rbms-pybdsf2w-usg-ribv3.dfu"

:: Clean up
deactivate

echo Firmware update complete
pause