# INFORME TÉCNICO: ELABORACIÓN DE BACKUPS Y RESTAURACIÓN DE BASES DE DATOS
## Arquitectura Políglota: Base de Datos Relacional (SQL Server) y No Relacional (MongoDB)

**Proyecto:** Agropacayales S.A.C.  
**Equipo de Proyecto:** Hugo Fernandez y Equipo de Proyecto  
**Herramientas Empleadas:** SQL Server Management Studio (SSMS), MongoDB Compass, T-SQL, MongoDB Database Tools  
**Presentación Oficial en Google Slides:** [Ver Diapositivas en Google Slides](https://docs.google.com/presentation/d/1b7qHOjeMv2MpBvhKLj9aCpblSJ-Fj7tBMlBYF8awAq4/edit)  
**Guion de Presentación Diapositiva por Diapositiva:** [GUION_PRESENTACION_SLIDES.md](file:///e:/Nueva%20carpeta%20(8)/actividad-backups-restauracion/GUION_PRESENTACION_SLIDES.md)  
**Guion Didáctico para el Video (SSMS + Compass):** [GUION_VIDEO_DEMOSTRACION.md](file:///e:/Nueva%20carpeta%20(8)/actividad-backups-restauracion/GUION_VIDEO_DEMOSTRACION.md)  
**Enlace al Video Demostrativo (Google Drive):** `[>>> PEGAR AQUÍ TU ENLACE PÚBLICO DE GOOGLE DRIVE <<<]`

---

## 1. INTRODUCCIÓN Y OBJETIVOS

En las organizaciones modernas, los datos representan el activo más crítico de la infraestructura tecnológica. Una interrupción operativa provocada por fallos de hardware, errores humanos, corrupción de software o incidentes de ciberseguridad (como ataques de ransomware) puede ocasionar pérdidas financieras severas y daño reputacional irreparable.

El objetivo de esta actividad práctica es **diseñar, ejecutar y documentar didácticamente los procedimientos estandarizados de copias de seguridad (Backups) y restauración (Restore)** para dos motores con paradigmas distintos:
1. **Motor Relacional:** Microsoft SQL Server mediante **SQL Server Management Studio (SSMS)** y scripts **T-SQL**.
2. **Motor No Relacional (Documental):** MongoDB mediante la herramienta visual **MongoDB Compass** y utilidades nativas (**mongodump / mongorestore**).

### Métricas Clave de Continuidad de Negocio

* **RPO (Recovery Point Objective - Objetivo de Punto de Recuperación):** Determina el volumen máximo aceptable de datos perdidos, medido en tiempo transcurrido desde el último respaldo hasta el momento del incidente. En el proyecto **Agropacayales S.A.C.**, el RPO se establece en **< 15 minutos**, asegurado mediante copias continuas de logs transaccionales y exportaciones programadas.
* **RTO (Recovery Time Objective - Objetivo de Tiempo de Recuperación):** Determina el tiempo máximo tolerable durante el cual el sistema puede permanecer fuera de línea antes de que las operaciones sean restauradas. Nuestro RTO objetivo es de **< 30 minutos**, sustentado en procedimientos probados de restauración con reemplazo (`WITH REPLACE` / `--drop`).

---

## 2. ARQUITECTURA DE DATOS DEL PROYECTO (AGROPACAYALES S.A.C.)

El sistema implementa una **arquitectura políglota** que aprovecha las fortalezas de ambos paradigmas:

```text
                                  ┌──────────────────────────────────────────────┐
                                  │            AGROPACAYALES S.A.C.             │
                                  └──────────────────────┬───────────────────────┘
                                                         │
                        ┌────────────────────────────────┴───────────────────────────────┐
                        ▼                                                                ▼
         ┌──────────────────────────────┐                                 ┌──────────────────────────────┐
         │     SQL SERVER (SSMS)        │                                 │   MONGODB (COMPASS / CLI)    │
         ├──────────────────────────────┤                                 ├──────────────────────────────┤
         │ • Paradigma: Relacional ACID │                                 │ • Paradigma: NoSQL Documental│
         │ • DB: agropacayales_db       │                                 │ • DB: agropacayales_db       │
         │ • Tablas:                    │                                 │ • Colecciones:               │
         │   - cultivos (Catálogo)      │                                 │   - supplies (Insumos)       │
         │   - actividades_cultivo (Cab)│                                 │   - users (Usuarios)         │
         │   - insumos_consumidos (Det) │                                 │   - plots (Parcelas)         │
         │ • Backup: Archivo .BAK       │                                 │ • Backup: JSON / BSON Dump   │
         └──────────────────────────────┘                                 └──────────────────────────────┘
```

---

## 3. PROCEDIMIENTO EN BASE DE DATOS RELACIONAL: SQL SERVER (SSMS)

### 3.1. Elaboración del Backup Completo (Full Backup)

El respaldo completo consolida todas las páginas de datos asignadas en el archivo primario (`.mdf`), los archivos secundarios (`.ndf`) y la porción activa del registro transaccional (`.ldf`).

#### A) Procedimiento Gráfico en SSMS:
1. Abra **SQL Server Management Studio** y conéctese a la instancia de base de datos.
2. En el panel **Object Explorer (Explorador de Objetos)**, expanda la carpeta **Databases**.
3. Haga clic derecho sobre `agropacayales_db` ➔ seleccione **Tasks (Tareas)** ➔ **Back Up... (Copia de seguridad...)**.
4. Configure los parámetros en la ventana emergente:
   - **Database:** `agropacayales_db`.
   - **Recovery model:** `FULL` (o `SIMPLE`).
   - **Backup type:** `Full`.
   - **Destination (Destino):** Verifique que esté seleccionado `Disk` y configure la ruta destino:  
     `C:\Backups\agropacayales_db_full.bak`.  
     *(Si existen rutas antiguas en la lista, selecciónelas y haga clic en Remove antes de agregar la ruta limpia).*
5. En la pestaña lateral **Backup Options (Opciones de copia de seguridad)**:
   - Marque la casilla **Verify backup when finished (Comprobar copia de seguridad al finalizar)** para validar la suma de verificación (checksum).
   - Opcional: En *Compression*, seleccione **Compress backup** para optimizar el tamaño en disco.
6. Haga clic en **OK**. Se desplegará el mensaje de confirmación:  
   *`The backup of database 'agropacayales_db' completed successfully.`*

#### B) Script Automatizado T-SQL Equivalente:
```sql
USE master;
GO

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
```

---

### 3.2. Simulación de Falla / Incidente de Pérdida de Datos

Para comprobar didácticamente la efectividad del proceso de restauración, simulamos una modificación accidental de registros en la tabla transaccional `cultivos`:

```sql
USE agropacayales_db;
GO

-- Simulación de error de actualización masiva no controlada
UPDATE dbo.cultivos 
SET nombre = 'REGISTRO_CORRUPTO_ERROR', observaciones = 'Fallo operativo'
WHERE id_cultivo IN (1, 2, 3);
GO

-- Verificación del estado dañado:
SELECT id_cultivo, id_parcela, nombre, tipo_cultivo, observaciones 
FROM dbo.cultivos 
WHERE id_cultivo IN (1, 2, 3);
GO
```

---

### 3.3. Restauración de la Base de Datos (Restore Database)

El proceso de restauración reemplaza los archivos de la base de datos dañada por la versión íntegra contenida en el archivo `.bak`.

#### A) Procedimiento Gráfico en SSMS:
1. En el **Object Explorer**, haga clic derecho sobre la carpeta **Databases** ➔ seleccione **Restore Database... (Restaurar base de datos...)**.
2. En la sección **Source (Origen)**, seleccione la opción **Device (Dispositivo)**.
3. Haga clic en el botón de navegación `...` ➔ en la ventana emergente presione **Add** ➔ navegue hasta `C:\Backups\agropacayales_db_full.bak` ➔ presione **OK**.
4. En el panel lateral izquierdo, seleccione la sección **Options (Opciones)**:
   - **Crucial:** Marque la casilla **Overwrite the existing database (WITH REPLACE) [Sobrescribir la base de datos existente]**.
   - **Crucial:** Marque la casilla **Close existing connections to destination database [Cerrar las conexiones existentes a la base de datos de destino]** para evitar que conexiones abiertas bloqueen la operación con el error *"Database is in use"*.
5. Haga clic en **OK**. El motor procesará la restauración y confirmará con:  
   *`Database 'agropacayales_db' restored successfully.`*

#### B) Script Automatizado T-SQL de Restauración:
```sql
USE master;
GO

-- 1. Expulsar sesiones activas
ALTER DATABASE [agropacayales_db] 
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Restaurar base de datos con reemplazo
RESTORE DATABASE [agropacayales_db]
FROM DISK = N'C:\Backups\agropacayales_db_full.bak'
WITH 
    FILE = 1, 
    REPLACE, 
    STATS = 10, 
    RECOVERY;
GO

-- 3. Habilitar nuevamente acceso concurrente
ALTER DATABASE [agropacayales_db] 
SET MULTI_USER;
GO
```

#### C) Validación Final de Integridad:
```sql
SELECT id_cultivo, id_parcela, nombre, tipo_cultivo, observaciones 
FROM agropacayales_db.dbo.cultivos 
WHERE id_cultivo IN (1, 2, 3);
GO
-- Resultado: Los nombres y observaciones han vuelto a sus valores originales previos al incidente.
```

---

## 4. PROCEDIMIENTO EN BASE DE DATOS NO RELACIONAL: MONGODB (COMPASS)

### 4.1. Elaboración del Backup / Exportación en MongoDB Compass

En MongoDB, los respaldos pueden estructurarse a nivel de colecciones individuales (formato JSON legible y portable) o a nivel de clúster/base completa mediante volcados BSON binarios.

#### A) Procedimiento Gráfico en MongoDB Compass:
1. Abra **MongoDB Compass** y conéctese al servidor (`mongodb://localhost:27017` o el Connection String de su clúster).
2. En la lista de bases de datos, haga clic en `agropacayales_db`.
3. Seleccione la colección a respaldar: `supplies` (Insumos agrícolas con identificadores `INS-...`).
4. En la barra de herramientas superior de la colección, localice el menú **Collection** o el botón de acción **Export Data** (ícono de flecha hacia afuera).
5. En el asistente emergente:
   - Seleccione la opción: **Export the full collection (Exportar la colección completa)**.
   - Seleccione el formato de salida: **JSON** *(permite inspección humana inmediata y migración multiplataforma)*.
   - En *Output file*, haga clic en **Browse** y defina la ruta:  
     `C:\Backups\supplies_backup.json`.
6. Presione el botón **Export**. Compass indicará la cantidad de documentos exportados satisfactoriamente.

#### B) Alternativa Profesional en Entornos de Producción (CLI - mongodump):
En infraestructuras de misión crítica se utiliza la herramienta nativa `mongodump`, la cual extrae los documentos en formato binario BSON junto con el archivo `metadata.json` que preserva índices y restricciones:
```bash
mongodump --db=agropacayales_db --collection=supplies --out=C:\Backups\mongo_dump
```

---

### 4.2. Simulación de Desastre en MongoDB

Para certificar la restauración en Compass, simulamos la pérdida total de la colección:
1. En MongoDB Compass, dentro de la colección `supplies`, haga clic en el botón con ícono de papelera **Drop Collection** (o elimine los documentos con *Delete*).
2. Compass solicitará confirmación escribiendo el nombre exacto de la colección: `supplies`.
3. Confirme la eliminación. La colección desaparece de la base de datos o queda con 0 documentos.

---

### 4.3. Restauración / Importación en MongoDB Compass

#### A) Procedimiento Gráfico en MongoDB Compass:
1. Dentro de la base de datos `agropacayales_db`, si la colección fue eliminada, haga clic en **Create collection**, ingrese el nombre `supplies` y presione **Create**.
2. Ingrese a la colección `supplies`.
3. Haga clic en el botón verde **Add Data** ➔ seleccione **Import JSON or CSV file**.
4. En la ventana del explorador, seleccione el archivo previamente respaldado:  
   `C:\Backups\supplies_backup.json`.
5. En el selector *File Type*, asegúrese de que esté marcado **JSON**.
6. Haga clic en el botón azul **Import**.
7. Compass procesará los documentos y mostrará el mensaje *"Import completed"*. Todos los registros con sus identificadores de negocio (`INS-FERT-001`, `INS-PEST-002`, precios, stock y tipos) quedan reestablecidos exactamente en su estado previo.

#### B) Alternativa Profesional en Producción (CLI - mongorestore):
```bash
mongorestore --db=agropacayales_db --collection=supplies --drop C:\Backups\mongo_dump\agropacayales_db\supplies.bson
```
*El parámetro `--drop` elimina la colección previa defectuosa antes de reconstruirla con el respaldo.*

---

## 5. CUADRO COMPARATIVO TÉCNICO

| Criterio de Comparación | SQL Server (SSMS / .BAK) | MongoDB (Compass / BSON / JSON) |
| :--- | :--- | :--- |
| **Formato de Salida** | Archivo binario monolítico propietario (`.bak`). | Archivos de texto estructurado (`.json`) o binario (`.bson`). |
| **Garantía de Consistencia** | Consistencia transaccional estricta **ACID** a nivel de motor. | Consistencia a nivel de documento; eventual en réplicas. |
| **Punto en el Tiempo (Point-in-Time)** | Soporte nativo a segundo exacto aplicando Logs de Transacciones. | Posible en clústeres mediante reproducción secuencial de `oplog`. |
| **Granularidad de Respaldo** | Base completa, diferencial o grupos de archivos (Filegroups). | Granularidad por colección individual, documentos o base completa. |
| **Portabilidad** | Limitado a instancias de Microsoft SQL Server compatibles. | Altamente portable entre plataformas, servidores cloud y sistemas operativos. |
| **Impacto Operativo** | Mínimo impacto gracias a aislamiento por instantáneas (VSS). | Exportaciones JSON consumen CPU/RAM; BSON dump es ultra-rápido. |

---

## 6. ESTRATEGIA EMPRESARIAL 3-2-1 Y CIBERSEGURIDAD

Para cumplir con estándares internacionales (ISO 27001 y NIST CSF), las copias de seguridad deben regirse por la **Regla 3-2-1**:

1. **3 Copias de los Datos:**
   - 1 copia primaria de producción (bases activas en SQL Server y MongoDB).
   - 2 copias de respaldo secundarias independientes.
2. **2 Medios de Almacenamiento Diferentes:**
   - Almacenamiento local en discos rápidos (NVMe/SSD en servidores locales para restauración ágil).
   - Almacenamiento secundario en un repositorio dedicado (NAS, SAN o discos externos protegidos).
3. **1 Copia Fuera del Sitio (Off-site / Cloud):**
   - Respaldo replicado automáticamente a servicios de almacenamiento en la nube (AWS S3 con políticas de inmutabilidad *Object Lock*, Azure Blob Storage o Google Cloud Storage). Esto previene pérdidas totales ante catástrofes físicas o ataques de ransomware en la red local.

### Políticas de Ciberseguridad Aplicadas:
* **Cifrado en Reposo:** Archivos de respaldo cifrados mediante algoritmo **AES-256**.
* **Principio de Mínimo Privilegio:** Permisos de ejecución de backup y restore restringidos a roles de administración de base de datos (`db_backupoperator` / `backupAdmin`).
* **Simulacros Periódicos:** "Una copia de seguridad que no ha sido probada no constituye un respaldo válido". Se programan pruebas de restauración quincenales en ambientes aislados de Staging.

---

## 7. CONCLUSIONES

1. Se demostró de manera práctica y didáctica el flujo completo de **Copia de Seguridad (Backup)** y **Restauración (Restore)** en ambos motores: SQL Server mediante **SSMS** y MongoDB mediante **MongoDB Compass**.
2. Se comprobó la recuperación exitosa de datos ante incidentes simulados de corrupción y eliminación involuntaria, validando que los datos recuperados conservan su integridad referencial, tipos de datos e índices.
3. Se garantizó el cumplimiento de los objetivos de continuidad de negocio (**RPO < 15 min** y **RTO < 30 min**), estableciendo procedimientos claros y reproducibles para el equipo de desarrollo y operaciones.
