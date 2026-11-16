-- ==============================================================================
-- AGROPACAYALES S.A.C. — SCRIPT DE INICIALIZACIÓN RÁPIDA (SQL SERVER)
-- Crea la base de datos y la tabla transaccional para la práctica de backups
-- ==============================================================================

USE master;
GO

-- 1. Recreación limpia de la base de datos
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'agropacayales_db')
BEGIN
    ALTER DATABASE agropacayales_db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE agropacayales_db;
END;
GO

CREATE DATABASE agropacayales_db;
GO

USE agropacayales_db;
GO

-- 2. Tabla transaccional: Cultivos (Crops)
CREATE TABLE dbo.cultivos (
    id_cultivo INT IDENTITY(1,1) CONSTRAINT PK_cultivos PRIMARY KEY,
    id_parcela VARCHAR(30) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo_cultivo VARCHAR(80) NOT NULL,
    frecuencia_riego_dias INT NOT NULL DEFAULT 3,
    temperatura_ideal DECIMAL(5,2) NOT NULL DEFAULT 22.0,
    fecha_siembra DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    requiere_sombra BIT NOT NULL DEFAULT 0,
    observaciones VARCHAR(MAX) NULL,
    estado BIT NOT NULL DEFAULT 1,
    created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- 3. Inserción de datos semilla para la práctica
INSERT INTO dbo.cultivos (id_parcela, nombre, tipo_cultivo, frecuencia_riego_dias, temperatura_ideal, observaciones) VALUES
('PARC-NOR-001', 'Palto Hass Exportación', 'Frutal Perenne', 4, 21.5, 'Lote prioritario sector norte'),
('PARC-SUR-002', 'Uva Red Globe', 'Vid de Mesa', 3, 24.0, 'Riego por goteo automatizado'),
('PARC-EST-003', 'Espárrago Verde UC-157', 'Hortaliza', 2, 20.0, 'Fase de cosecha intensiva'),
('PARC-OES-004', 'Arándano Biloxi', 'Berry Arbustivo', 2, 19.5, 'Monitoreo de pH en sustrato'),
('PARC-CEN-005', 'Mango Kent', 'Frutal Tropical', 5, 26.0, 'Poda de formación completada');
GO

-- 4. Verificación de inicialización exitosa
SELECT 
    'INICIALIZACION COMPLETADA' AS Estado,
    COUNT(*) AS TotalRegistros,
    MIN(fecha_siembra) AS FechaPrimerCultivo
FROM dbo.cultivos;
GO
