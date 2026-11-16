@echo off
REM ==============================================================================
REM AGROPACAYALES S.A.C. — BACKUP Y RESTORE CLI (MONGODB)
REM Requiere tener MongoDB Database Tools (mongodump y mongorestore en el PATH)
REM ==============================================================================

set DB_NAME=agropacayales_db
set BACKUP_DIR=C:\Backups\mongodb_dump

echo ==============================================================================
echo   AGROPACAYALES S.A.C. - MONGODB BACKUP Y RESTORE CLI
echo ==============================================================================

if not exist "C:\Backups" mkdir "C:\Backups"

echo.
echo [1/3] Generando Backup BSON completo con mongodump...
mongodump --db=%DB_NAME% --out=%BACKUP_DIR%

if %ERRORLEVEL% EQU 0 (
    echo [EXITO] Backup guardado en: %BACKUP_DIR%\%DB_NAME%
) else (
    echo [AVISO] mongodump no esta en el PATH. Recuerda que tambien puedes usar
    echo         el boton 'Export Data' directamente desde MongoDB Compass.
)

echo.
echo Presiona una tecla para simular la restauracion con mongorestore...
pause

echo.
echo [2/3] Restaurando base de datos con reemplazo (--drop)...
mongorestore --db=%DB_NAME% --drop %BACKUP_DIR%\%DB_NAME%

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [3/3] [EXITO] Base de datos restaurada correctamente al 100%%.
) else (
    echo [AVISO] mongorestore no esta en el PATH o no se encontro el volcado.
)

pause
