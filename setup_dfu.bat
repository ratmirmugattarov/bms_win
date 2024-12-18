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
:: Wait for installation
timeout /t 10

echo [3/5] Setting up Python environment...
:: Create new virtual environment in Windows path
C:\Program Files\Python310\python.exe -m venv C:\dfu_venv
call C:\dfu_venv\Scripts\activate.bat

:: Install required packages
C:\dfu_venv\Scripts\python.exe -m pip install --upgrade pip
C:\dfu_venv\Scripts\pip install pyusb

echo [4/5] Cleanup...
del python_installer.exe

echo =====================================
echo Installation completed!
echo.
echo Next steps:
echo 1. Make sure device is in DFU mode
echo 2. Verify Zadig installed WinUSB driver
echo =====================================

pause