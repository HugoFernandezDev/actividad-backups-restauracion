# MANUAL PASO A PASO PARA COMPAÑEROS DE EQUIPO
## Cómo realizar el Backup y Restauración de SQL Server y MongoDB en tu PC
### Proyecto: Agropacayales S.A.C. | Equipo: Hugo, Ana y Axel

> **Propósito de este manual:**  
> Esta guía está pensada para que cualquier integrante del equipo (**Ana, Axel o Hugo**) pueda configurar rápidamente su computadora, crear la base de datos de prueba, realizar la copia de seguridad, simular una falla y restaurarla exitosamente para la sustentación o grabación del video.

---

## 🛠️ PASO 0: PREPARATIVOS RÁPIDOS EN TU MÁQUINA

1. **Crear la carpeta de backups en tu disco C:**
   - Abre el Explorador de Windows, ve a `Este equipo ➔ Disco local (C:)`.
   - Crea una nueva carpeta llamada: **`Backups`**  
     *(Ruta final: `C:\Backups`)*.
2. **Tener instaladas las herramientas visuales:**
   - **Para SQL Server:** SQL Server Management Studio (SSMS) + Instancia local (`.\SQLEXPRESS` o `localhost`).
   - **Para MongoDB:** MongoDB Compass + Servicio de MongoDB activo en `mongodb://localhost:27017` *(o vía Docker)*.

---

## 🟥 PARTE 1: MICROSOFT SQL SERVER (RELACIONAL)

### Paso 1.1: Inicializar la Base de Datos de Prueba
1. Abre **SQL Server Management Studio (SSMS)** y conéctate a tu servidor local.
2. Haz clic en **File ➔ Open ➔ File...** y abre el archivo:  
   `scripts/01_setup_database_sqlserver.sql`.
3. Presiona **F5** (o el botón verde **Execute**).
4. Verifica que en el Explorador de Objetos aparezca la base de datos `agropacayales_db` con la tabla `dbo.cultivos` y 5 registros cargados.

---

### Paso 1.2: Generar la Copia de Seguridad (Backup Full)

#### 🔹 Opción A: Por Interfaz Gráfica (SSMS) — Recomendado para mostrar en video
1. En el Explorador de Objetos de SSMS, haz clic derecho en `agropacayales_db` ➔ **Tasks (Tareas)** ➔ **Back Up... (Copia de seguridad...)**.
2. Verifica los siguientes campos en la ventana emergente:
   - **Database:** `agropacayales_db`.
   - **Backup type:** `Full`.
   - **Destination (Destino):** Debe decir `Disk`. Si hay una ruta previa en la lista, selecciónala y dale a **Remove**. Luego haz clic en **Add** y selecciona la ruta:  
     `C:\Backups\agropacayales_db_full.bak`.
3. Ve a la pestaña **Backup Options (Opciones de copia de seguridad)** a la izquierda:
   - Marca la casilla: **Verify backup when finished (Comprobar copia de seguridad al finalizar)**.
4. Haz clic en **OK**. Verás el mensaje:  
   *"The backup of database 'agropacayales_db' completed successfully."*

#### 🔹 Opción B: Por Script T-SQL
Si prefieres hacerlo por código en 2 segundos, abre una consulta en SSMS y corre:
```sql
BACKUP DATABASE [agropacayales_db]
TO DISK = N'C:\Backups\agropacayales_db_full.bak'
WITH FORMAT, INIT, NAME = N'agropacayales_db - Backup Completo', STATS = 10;
```

---

### Paso 1.3: Simular una Falla o Pérdida de Datos
Abre una nueva consulta en SSMS (**New Query**) y ejecuta:
```sql
USE agropacayales_db;
-- Simulamos una actualización accidental destructiva
UPDATE dbo.cultivos
SET nombre = 'DATO_CORRUPTO_ERROR_OPERATIVO',
    observaciones = 'Registro alterado accidentalmente'
WHERE id_cultivo IN (1, 2);

-- Comprobamos el daño:
SELECT id_cultivo, id_parcela, nombre, tipo_cultivo, observaciones FROM dbo.cultivos;
```
*Verás que los cultivos 1 y 2 tienen el nombre corrupto.*

---

### Paso 1.4: Restaurar la Base de Datos (Restore)

#### 🔹 Opción A: Por Interfaz Gráfica (SSMS)
1. En SSMS, haz clic derecho sobre la carpeta **Databases** ➔ selecciona **Restore Database... (Restaurar base de datos...)**.
2. En la sección **Source (Origen)**, selecciona **Device (Dispositivo)** y haz clic en los tres puntos `...`.
3. Haz clic en **Add**, busca y selecciona `C:\Backups\agropacayales_db_full.bak` y dale a **OK**.
4. En el panel lateral izquierdo, entra a **Options (Opciones)**:
   - ✅ Marca: **Overwrite the existing database (WITH REPLACE)**.
   - ✅ Marca: **Close existing connections to destination database** *(¡muy importante para que no dé error de base en uso!)*.
5. Haz clic en **OK**. Aparecerá: *"Database 'agropacayales_db' restored successfully."*

#### 🔹 Opción B: Por Script T-SQL
```sql
USE master;
ALTER DATABASE [agropacayales_db] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
RESTORE DATABASE [agropacayales_db] FROM DISK = N'C:\Backups\agropacayales_db_full.bak' WITH REPLACE;
ALTER DATABASE [agropacayales_db] SET MULTI_USER;
```

#### ✅ Validación:
Ejecuta `SELECT * FROM agropacayales_db.dbo.cultivos;` y verás que los nombres originales regresaron al 100%.

---

## 🟩 PARTE 2: MONGODB (NO RELACIONAL)

### Paso 2.1: Inicializar la Base de Datos y Colección
1. Abre **MongoDB Compass** y presiona **Connect** a `mongodb://localhost:27017`.
2. En la barra inferior de Compass, haz clic en **`_MONGOSH`** para abrir la consola embebida.
3. Copia y pega el contenido del archivo `scripts/03_setup_mongodb.js` y presiona Enter.
4. Actualiza la lista lateral de Compass: verás la base de datos `agropacayales_db` con la colección `supplies` y 5 documentos cargados (`INS-FERT-001`, etc.).

---

### Paso 2.2: Generar la Copia de Seguridad en MongoDB Compass
1. En MongoDB Compass, entra a la base de datos `agropacayales_db` y haz clic en la colección `supplies`.
2. En la barra superior, haz clic en el botón **Export Data** (o en el menú *Collection ➔ Export Collection*).
3. Selecciona: **Export the full collection (Exportar la colección completa)**.
4. Elige el formato: **JSON**.
5. Haz clic en **Browse**, elige la ruta `C:\Backups\supplies_backup.json` y presiona **Export**.
6. Compass te confirmará que se exportaron los 5 documentos.

---

### Paso 2.3: Simular la Pérdida de Datos en MongoDB
1. En Compass, dentro de la colección `supplies`, haz clic en la pestaña de configuración (o ícono de basura) para hacer un **Drop Collection**.
2. Escribe el nombre `supplies` para confirmar.
3. Observa que la colección desaparece por completo (0 documentos).

---

### Paso 2.4: Restaurar los Datos en MongoDB Compass
1. Dentro de `agropacayales_db`, haz clic en **Create collection**, ponle nombre `supplies` y dale a **Create collection**.
2. Entra a la colección `supplies` recién creada.
3. Haz clic en el botón verde **Add Data ➔ Import JSON or CSV file**.
4. Selecciona el archivo: `C:\Backups\supplies_backup.json`.
5. Verifica que en *File Type* esté seleccionado **JSON** y presiona el botón azul **Import**.
6. Compass cargará los 5 documentos y verás nuevamente los registros `INS-FERT-001`, `INS-PEST-002`, etc., con todos sus datos intactos.

---

## 🚨 SOLUCIÓN A PROBLEMAS FRECUENTES (TROUBLESHOOTING)

### 1. Error en SQL Server: *"Cannot open backup device... Operating system error 5: Access is denied"*
* **Causa:** El servicio de SQL Server no tiene permisos para escribir en la carpeta.
* **Solución:**
  1. Ve a `C:\Backups` en tu explorador.
  2. Clic derecho ➔ *Propiedades ➔ pestaña Seguridad ➔ Editar*.
  3. Haz clic en *Agregar*, escribe `Todos` (o `Everyone`), dale a Aceptar y marca la casilla **Control total**. Presiona Aplicar.

### 2. Error al Restaurar: *"The database is in use by another session"*
* **Solución:**
  En la ventana de Restore de SSMS, asegúrate de marcar en la pestaña *Options* la casilla **"Close existing connections to destination database"**, o corre el script T-SQL que incluye `ALTER DATABASE agropacayales_db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;`.

### 3. Si no tienes MongoDB instalado localmente:
Puedes levantarlo en 5 segundos con Docker corriendo en tu PowerShell:
```powershell
docker run -d --name mongo-local -p 27017:27017 mongo:latest
```
Y luego abres MongoDB Compass y te conectas a `mongodb://localhost:27017`.
