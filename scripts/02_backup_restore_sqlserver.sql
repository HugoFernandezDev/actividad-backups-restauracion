-- ==============================================================================
-- AGROPACAYALES S.A.C. — BACKUP Y RESTORE T-SQL (SQL SERVER)
-- ==============================================================================

USE master;
GO

-- ------------------------------------------------------------------------------
-- PASO 1: VERIFICAR DATOS ANTES DEL BACKUP
-- ------------------------------------------------------------------------------
SELECT 'ESTADO ANTES DE BACKUP' AS Fase, id_cultivo, id_parcela, nombre, tipo_cultivo
FROM agropacayales_db.dbo.cultivos;
GO

-- ------------------------------------------------------------------------------
-- PASO 2: GENERACIÓN DEL BACKUP COMPLETO (FULL BACKUP)
-- Asegurarse de tener creada la carpeta C:\Backups en el disco local
-- ------------------------------------------------------------------------------
BACKUP DATABASE [agropacayales_db]
TO DISK = N'C:\Backups\agropacayales_db_full.bak'
WITH 
    FORMAT, 
    INIT, 
    NAME = N'agropacayales_db - Backup Completo', 
    SKIP, 
    NOREWIND, 
    NOUNLOAD, 
    COMPRESSION, 
    STATS = 10,
    CHECKSUM;
GO

-- ------------------------------------------------------------------------------
-- PASO 3: SIMULACIÓN DE CONTINGENCIA / ERROR HUMANO
-- ------------------------------------------------------------------------------
USE agropacayales_db;
GO

UPDATE dbo.cultivos
SET nombre = 'DATO_CORRUPTO_ERROR_OPERACIONAL',
    observaciones = 'Registro dañado accidentalmente por un script defectuoso'
WHERE id_cultivo IN (1, 2);
GO

-- Comprobar que los registros están dañados:
SELECT 'ESTADO DANADO' AS Fase, id_cultivo, id_parcela, nombre, observaciones
FROM dbo.cultivos;
GO

-- ------------------------------------------------------------------------------
-- PASO 4: RESTAURACIÓN COMPLETA CON REEMPLAZO (WITH REPLACE)
-- ------------------------------------------------------------------------------
USE master;
GO

-- 1. Cerrar conexiones activas para evitar bloqueos
ALTER DATABASE [agropacayales_db] 
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Restaurar desde el archivo de backup
RESTORE DATABASE [agropacayales_db]
FROM DISK = N'C:\Backups\agropacayales_db_full.bak'
WITH 
    FILE = 1, 
    REPLACE,       -- Sobrescribe la base de datos dañada
    STATS = 10, 
    RECOVERY;
GO

-- 3. Devolver la base a modo multiusuario
ALTER DATABASE [agropacayales_db] 
SET MULTI_USER;
GO

-- ------------------------------------------------------------------------------
-- PASO 5: VALIDACIÓN FINAL DE INTEGRIDAD
-- ------------------------------------------------------------------------------
SELECT 'RESTAURACION EXITOSA' AS Fase, id_cultivo, id_parcela, nombre, tipo_cultivo, observaciones
FROM agropacayales_db.dbo.cultivos;
GO
