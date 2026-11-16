# GUION DIDÁCTICO PARA VIDEO DEMOSTRATIVO (3 A 5 MINUTOS)
## Backup y Restauración de Base de Datos Relacional (SSMS) y No Relacional (MongoDB Compass)

> **Datos de la Entrega:**
> - **Estudiante / Equipo:** Hugo Fernandez y Equipo de Proyecto
> - **Proyecto Aplicado:** Agropacayales S.A.C.
> - **Duración recomendada:** 4 minutos a 4 minutos y 30 segundos.
> - **Destino:** Video subido a Google Drive con enlace compartido al profesor.
> - **Presentación oficial en Google Slides:** [Estrategias de Backup y Restauración](https://docs.google.com/presentation/d/1b7qHOjeMv2MpBvhKLj9aCpblSJ-Fj7tBMlBYF8awAq4/edit)

---

## 🛠️ PREPARACIÓN PREVIA (Antes de iniciar a grabar)

Abre y ten listas las siguientes ventanas en tu pantalla:
1. **Ventana 1 - Navegador:** Tu presentación de Google Slides abierta en la Diapositiva 1:  
   👉 `https://docs.google.com/presentation/d/1b7qHOjeMv2MpBvhKLj9aCpblSJ-Fj7tBMlBYF8awAq4/edit`
2. **Ventana 2 - SQL Server Management Studio (SSMS):**  
   - Conectado a tu instancia local (`localhost` o `.\SQLEXPRESS`).
   - Base de datos `agropacayales_db` expandida con sus tablas visibles (`cultivos`, etc.).
   - Crea una carpeta para backups: `C:\Backups` en tu disco local.
3. **Ventana 3 - MongoDB Compass:**  
   - Conectado a tu servidor de MongoDB (`mongodb://localhost:27017` o réplica).
   - Base de datos `agropacayales_db` abierta, mostrando la colección `supplies` con sus documentos.
4. **Atajo para iniciar grabación en Windows:** Presiona **`Win + Alt + R`** (o tu software de grabación: OBS / Clipchamp).

---

## ⏱️ GUION PASO A PASO (PALABRA POR PALABRA)

### 🕒 [0:00 – 0:50] BLOQUE 1: INTRODUCCIÓN Y FUNDAMENTOS (GOOGLE SLIDES)

**Qué mostrar en pantalla:**
- Google Slides en pantalla completa (Modo Presentación).
- Pasa de la Diapositiva 1 (Portada) a la Diapositiva 2 (RPO y RTO).

**Qué decir:**
> *"Buenas tardes profesor. En este video, en representación de nuestro equipo de proyecto, voy a realizar la demostración didáctica de los procedimientos para la **elaboración de backups (copias de seguridad)** y la **restauración completa** tanto de nuestra base de datos **relacional en SQL Server** como de nuestra base de datos **no relacional en MongoDB**.*
>
> *(Pasa a la diapositiva 2 de RPO y RTO)*  
> *Para garantizar la continuidad de negocio en nuestro proyecto agrícola **Agropacayales S.A.C.**, nos basamos en dos métricas fundamentales:*
> *1. El **RPO (Recovery Point Objective)**, que define la cantidad máxima de datos que estamos dispuestos a perder ante una catástrofe; en nuestro caso fijado en menos de 15 minutos mediante respaldos frecuentes.*
> *2. El **RTO (Recovery Time Objective)**, que representa el tiempo que nos toma volver a poner operativa la base de datos tras una falla, proyectado en menos de 30 minutos.*
>
> *A continuación, pasamos a la demostración práctica en vivo."*

---

### 🕒 [0:50 – 2:15] BLOQUE 2: DEMOSTRACIÓN EN SQL SERVER MANAGEMENT STUDIO (SSMS)

**Qué mostrar en pantalla:**
- Cambia a la ventana de **SQL Server Management Studio (SSMS)**.

**Paso A: Elaboración del Backup Completo (Full)**
- En el explorador de objetos, haz clic derecho sobre la base de datos `agropacayales_db`.
- Ve a **Tasks (Tareas)** ➔ **Back Up... (Copia de seguridad...)**.
- Muestra la ventana: Tipo de copia de seguridad: **Full (Completo)**.
- En destino, señala que se guardará en `C:\Backups\agropacayales_db_full.bak` (si hay otro destino, bórralo y pon ese).
- En la pestaña **Backup Options (Opciones)**, marca la casilla **"Verify backup when finished (Comprobar copia de seguridad al finalizar)"**.
- Haz clic en **OK**. Espera el mensaje *"The backup of database 'agropacayales_db' completed successfully."*

**Qué decir en Paso A:**
> *"Primero nos encontramos en **SQL Server Management Studio**. Nuestra base de datos relacional `agropacayales_db` almacena transacciones críticas como cultivos e insumos consumidos.*
>
> *Para crear una copia de seguridad completa, hacemos clic derecho en la base de datos, seleccionamos **Tasks ➔ Back Up**.*
> *Verificamos que el tipo sea **Full**, definimos la ruta de destino como `C:\Backups\agropacayales_db_full.bak` y en las opciones activamos la verificación de integridad.*
> *Al darle OK, SQL Server consolida todas las páginas de datos y el log de transacciones en un único archivo binario .BAK."*

**Paso B: Simulación de Incidente / Pérdida de Datos**
- Abre una ventana de consulta (**New Query**) en `agropacayales_db` y ejecuta:
  ```sql
  -- Simulación de error humano o pérdida accidental
  UPDATE dbo.cultivos SET nombre = 'DATO_CORRUPTO_ERROR' WHERE id_cultivo = 1;
  SELECT TOP 3 id_cultivo, id_parcela, nombre, tipo_cultivo FROM dbo.cultivos;
  ```
- Muestra en los resultados que el dato se corrompió/modificó.

**Qué decir en Paso B:**
> *"Ahora simulamos un escenario de desastre o error humano: por ejemplo, una actualización accidental que corrompe los nombres de los cultivos. Como vemos en la consulta, los datos originales se han visto alterados."*

**Paso C: Restauración de la Base de Datos (Restore)**
- En el explorador de objetos, haz clic derecho en **Databases** ➔ **Restore Database... (Restaurar base de datos...)**.
- Selecciona **Device (Dispositivo)** ➔ Clic en `...` ➔ Clic en **Add** ➔ Selecciona `C:\Backups\agropacayales_db_full.bak` ➔ Clic en **OK**.
- En el menú izquierdo, entra a **Options (Opciones)**:
  - Marca la casilla **"Overwrite the existing database (WITH REPLACE)"**.
  - Marca la casilla **"Close existing connections to destination database"**.
- Haz clic en **OK**. Espera el mensaje *"Database 'agropacayales_db' restored successfully."*
- Vuelve a la consulta y ejecuta `SELECT TOP 3 id_cultivo, id_parcela, nombre, tipo_cultivo FROM dbo.cultivos;` para mostrar que el nombre original regresó perfectamente.

**Qué decir en Paso C:**
> *"Para remediar el incidente y aplicar la restauración, vamos a **Databases ➔ Restore Database**.*
> *Seleccionamos como origen nuestro archivo `agropacayales_db_full.bak`.*
> *En la sección de Opciones, es crucial activar **'Close existing connections'** para cerrar sesiones abiertas, y **'Overwrite the existing database (WITH REPLACE)'** para que el motor reemplace el estado dañado.*
> *Damos clic en OK... y la base de datos queda restaurada exitosamente.*
> *Volvemos a consultar la tabla `cultivos` y confirmamos que la información ha recuperado su integridad y consistencia ACID al 100%."*

---

### 🕒 [2:15 – 3:35] BLOQUE 3: DEMOSTRACIÓN EN MONGODB COMPASS (NO RELACIONAL)

**Qué mostrar en pantalla:**
- Cambia a la ventana de **MongoDB Compass**.

**Paso A: Exportación / Backup de la Colección**
- Conéctate al clúster y selecciona la base de datos `agropacayales_db`.
- Entra a la colección `supplies` (Insumos agrícolas).
- Señala los documentos existentes (por ejemplo, `INS-FERT-001`, `INS-PEST-002`, etc.).
- En la barra de herramientas superior de la colección, haz clic en el botón **"Export Data"** (o en el menú superior *Collection ➔ Export Collection*).
- Selecciona la opción: **"Export the full collection"**.
- Elige el formato: **JSON** (o BSON si prefieres formato nativo binario).
- Haz clic en **Browse**, elige `C:\Backups\supplies_backup.json` y presiona **Export**.
- Muestra el mensaje de éxito indicando la cantidad de documentos exportados.

**Qué decir en Paso A:**
> *"Pasamos ahora a nuestra base de datos no relacional en **MongoDB Compass**. Aquí gestionamos documentos semiestructurados en formato BSON/JSON, como la colección `supplies` con los insumos y stock.*
>
> *Para generar el respaldo desde la interfaz gráfica, ingresamos a la colección y hacemos clic en **Export Data**.*
> *Elegimos **'Export the full collection'** en formato **JSON**, que es portable y de fácil auditoría, y guardamos el archivo como `supplies_backup.json` en nuestra carpeta de backups.*
> *Compass exporta todos los documentos respetando su estructura y tipos de datos."*

**Paso B: Simulación de Desastre en MongoDB**
- En Compass, dentro de la colección `supplies`, haz clic en la pestaña de configuración o el ícono de basura para hacer un **Drop Collection** (o selecciona varios documentos y dale a **Delete**).
- Escribe el nombre `supplies` para confirmar la eliminación.
- Muestra que la colección ahora está vacía o ha sido eliminada por completo.

**Qué decir en Paso B:**
> *"Nuevamente simulamos una contingencia: un operador elimina por error la colección `supplies` o sus documentos clave. Como vemos, los datos ya no están disponibles en la base de datos."*

**Paso C: Restauración / Import Data en MongoDB Compass**
- En Compass, dentro de `agropacayales_db`, si la colección no existe, haz clic en **Create collection** con nombre `supplies`.
- Entra a `supplies` y haz clic en el botón verde **"Add Data"** ➔ **"Import JSON or CSV file"**.
- Selecciona el archivo de respaldo: `C:\Backups\supplies_backup.json`.
- En File Type verifica que esté seleccionado **JSON**.
- Haz clic en el botón azul **"Import"**.
- Observa cómo se cargan los documentos y vuelve a mostrar la vista de lista con todos los registros `_id: "INS-..."` recuperados.

**Qué decir en Paso C:**
> *"Para restaurar la información, simplemente hacemos clic en **Add Data ➔ Import JSON or CSV file**, seleccionamos nuestro archivo `supplies_backup.json` y presionamos **Import**.*
> *En cuestión de segundos, MongoDB Compass reconstruye la totalidad de los documentos con sus identificadores de negocio e índices originales, recuperando la operatividad total."*

---

### 🕒 [3:35 – 4:15] BLOQUE 4: MEJORES PRÁCTICAS Y CIERRE

**Qué mostrar en pantalla:**
- Regresa a Google Slides en la Diapositiva 7 (Regla 3-2-1) y luego a la Diapositiva 8 (Conclusiones).

**Qué decir:**
> *"Como consideración empresarial para entornos de producción:*
> - *En SQL Server se configuran planes de mantenimiento automatizados con **SQL Server Agent** para backups diferenciales cada 4 horas y de log transaccional cada 15 minutos.*
> - *En MongoDB se utilizan herramientas CLI nativas como **`mongodump`** y **`mongorestore`**, integradas en Kubernetes CronJobs o copias snapshot a nivel de volumen.*
> - *Y en ambos casos aplicamos la **Estrategia 3-2-1**: tres copias de los datos, en dos medios diferentes, con al menos una copia externa en la nube (como AWS S3 o Google Cloud Storage).*
>
> *Con esto concluye nuestra demostración de backup y restauración relacional y no relacional. Muchas gracias por su atención."*

*(Presionas **`Win + Alt + R`** para detener la grabación).*

---

## ☁️ PASO FINAL: CÓMO SUBIR EL VIDEO A GOOGLE DRIVE Y COMPARTIRLO

1. **Ubica tu archivo de video grabado:**  
   Normalmente se encuentra en:  
   `C:\Users\<TuUsuario>\Videos\Captures\*.mp4`
2. **Sube el video a Google Drive:**
   - Abre tu navegador en [Google Drive](https://drive.google.com).
   - Haz clic en **Nuevo** ➔ **Subir archivo** y selecciona tu archivo MP4.
3. **Configura los Permisos de Visualización (¡Muy Importante!):**
   - Una vez subido, haz clic derecho sobre el video en Drive ➔ **Compartir (Share)** ➔ **Compartir**.
   - En la sección *"Acceso general"*, cambia de **Restringido** a **"Cualquier persona con el enlace"**.
   - Rol: Asegúrate de que diga **"Lector"**.
   - Haz clic en **"Copiar enlace"**.
4. **Pega el enlace en la Documentación:**
   - Abre tu documento de entrega o el archivo de presentación e incluye el enlace para el profesor.
