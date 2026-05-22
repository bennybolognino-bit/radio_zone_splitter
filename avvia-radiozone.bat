@echo off
title RadioZone — Server Locale
echo.
echo  =============================================
echo   RadioZone - Avvio server locale
echo  =============================================
echo.

:: Cerca Python
where python >nul 2>nul
if %errorlevel%==0 (
    echo  [OK] Python trovato
    goto :start
)
where python3 >nul 2>nul
if %errorlevel%==0 (
    set PYTHON=python3
    goto :start
)
echo  [ERRORE] Python non trovato.
echo  Scaricalo da https://python.org e installa con l'opzione "Add to PATH"
pause
exit

:start
echo  [>>] Avvio server su http://localhost:8765
echo  [>>] Apertura Chrome automatica...
echo.
echo  Lascia questa finestra aperta mentre usi RadioZone.
echo  Per chiudere premi CTRL+C
echo.

:: Apri Chrome con flag necessari per setSinkId
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --allow-file-access-from-files http://localhost:8765/radio-zone-splitter.html 2>nul
if errorlevel 1 (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --allow-file-access-from-files http://localhost:8765/radio-zone-splitter.html 2>nul
)
if errorlevel 1 (
    start http://localhost:8765/radio-zone-splitter.html
)

:: Avvia server Python nella cartella corrente
python -m http.server 8765 --bind 127.0.0.1

pause
