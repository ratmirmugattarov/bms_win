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

echo [1/6] Downloading required files...
:: Download Python installer
curl -L -o python_installer.exe https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe
:: Download libusb binaries
curl -L -o libusb-win32.zip https://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/1.2.6.0/libusb-win32-bin-1.2.6.0.zip/download

echo [2/6] Installing Python...
python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
timeout /t 10

echo [3/6] Extracting libusb...
powershell -command "Expand-Archive -Force libusb-win32.zip ."

echo [4/6] Installing libusb system files...
xcopy /y libusb-win32-bin-1.2.6.0\bin\x64\libusb0.dll C:\Windows\System32\
xcopy /y libusb-win32-bin-1.2.6.0\bin\x64\libusb0.sys C:\Windows\System32\drivers\

echo [5/6] Setting up Python environment...
python -m venv dfu_env
call dfu_env\Scripts\activate.bat

:: Install required packages
python -m pip install --upgrade pip
pip install pyusb

echo [6/6] Installing Zadig...
curl -L -o zadig.exe https://github.com/pbatard/libwdi/releases/download/v1.5.0/zadig-2.8.exe
start zadig.exe

echo =====================================
echo Installation completed!
echo.
echo Next steps:
echo 1. In Zadig:
echo    - Options -> List All Devices
echo    - Find your device (might be 'STM32 BOOTLOADER' or 'STM Device in DFU Mode')
echo    - Select WinUSB driver
echo    - Click Install Driver
echo 2. Make sure device is in DFU mode
echo 3. Run update_firmware.bat
echo =====================================

pause