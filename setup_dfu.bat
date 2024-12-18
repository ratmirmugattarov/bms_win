@echo off
SETLOCAL EnableDelayedExpansion

echo =====================================
echo DFU Programming Environment Setup
echo =====================================

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script needs admin rights.
    echo Please run as Administrator.
    pause
    exit /b 1
)

echo [1/5] Downloading required files...
:: Download Python installer
curl -L -o python_installer.exe https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe

echo [2/5] Installing Python...
python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
timeout /t 10

echo [3/5] Setting up Python environment...
python -m venv dfu_env
call dfu_env\Scripts\activate.bat

:: Install required packages
python -m pip install --upgrade pip
pip install pyusb libusb libusb1 pyusb-backend-libusb1

echo =====================================
echo Installation completed!
echo.
echo Next steps:
echo 1. Make sure device is in DFU mode
echo 2. Run Zadig and install WinUSB driver
echo =====================================

pause