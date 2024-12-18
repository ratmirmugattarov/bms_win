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
:: Download Zadig
curl -L -o zadig.exe https://github.com/pbatard/libwdi/releases/download/v1.5.0/zadig-2.8.exe

echo [2/5] Installing Python...
python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
if %ERRORLEVEL% neq 0 (
    echo Python installation failed
    pause
    exit /b 1
)

echo [3/5] Setting up Python environment...
:: Add Python to current session PATH
set PATH=%PATH%;C:\Program Files\Python310;C:\Program Files\Python310\Scripts

:: Install required Python packages
python -m pip install --upgrade pip
python -m pip install pyusb pypiwin32 wheel libusb-package libusb libusb1 pyusb-backend-libusb1

echo [4/5] Installing Zadig...
start /wait zadig.exe

echo [5/5] Cleanup...
del python_installer.exe
del zadig.exe

echo =====================================
echo Installation completed!
echo.
echo Next steps:
echo 1. Put your device in DFU mode
echo 2. Run Zadig and install WinUSB driver
echo 3. Use update_firmware.bat to flash your device
echo =====================================

pause