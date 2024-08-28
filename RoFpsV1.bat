@echo off
echo @DullerKill3R
echo Started Roblox Automatic FPS BOOSTER
echo "DO NOT CLOSE THIS WINDOW, UNLESS YOU WANT TO STOP BOOSTING"
setlocal

:: Define variables to keep track of the state
set BOOSTED=0
set INITIAL_CHECK_DONE=0
set PRIORITY_SET=0

:loop
:: Check if Roblox is running
tasklist /FI "IMAGENAME eq RobloxPlayerBeta.exe" | find /I "RobloxPlayerBeta.exe" >nul
if not errorlevel 1 (
    :: Check if the priority is already set to high
    wmic process where "name='RobloxPlayerBeta.exe'" get Priority | findstr /C:"128" >nul
    if errorlevel 1 (
        if %PRIORITY_SET%==0 (
            :: Priority is not high, set it to high
            wmic process where "name='RobloxPlayerBeta.exe'" call setpriority 128 >nul 2>&1
            echo Successfully Boosted Roblox Client! - Set Priority to High
            
            :: Update the variables to indicate that the priority has been set
            set BOOSTED=1
            set PRIORITY_SET=1
        )
    ) else (
        if %BOOSTED%==0 (
            set BOOSTED=1
        )
    )
) else (
    if %INITIAL_CHECK_DONE%==0 (
        echo Ready To Start Boost, Open Roblox Please!
        set INITIAL_CHECK_DONE=1
    )
    
    if %BOOSTED%==1 (
        echo Roblox is not running anymore.
        
        :: Reset all variables
        set BOOSTED=0
        set PRIORITY_SET=0
        set INITIAL_CHECK_DONE=0
    )
)

:: Wait 5 seconds before checking again
timeout /t 5 /nobreak >nul

:: Loop back to the start
goto loop
