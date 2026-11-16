# GUION OFICIAL DE PRESENTACIÓN EN EQUIPO (HUGO, ANA Y AXEL)
## Grabación Individual por Bloques Continuos (Sin Cortes Internos)
### Demostración Técnica: Microsoft SQL Server y MongoDB
### Diapositivas Diseñadas por Hugo Fernandez | Proyecto: Agropacayales S.A.C.

> **Metodología de Grabación:**  
> Cada integrante graba su bloque **de un solo tirón continuo (una sola toma)** en su computadora (`hugo.mp4`, `ana.mp4`, `axel.mp4`).  
> Al finalizar, se unen los 3 clips en cualquier editor de video (Clipchamp de Windows, CapCut o Premiere) para formar el video final de entrega (~4 minutos y 45 segundos).

---

### 👥 DISTRIBUCIÓN SECUENCIAL CONTINUA (ORDEN DE LAS DIAPOSITIVAS)

| Video Clip | Integrante | Diapositivas Asignadas | Duración de la Toma |
| :--- | :--- | :--- | :--- |
| **CLIP 1** | **HUGO FERNÁNDEZ** | **Diapositivas 1, 2, 3 y 4** (Portada, Continuidad, Arquitectura y SQL Server) | **~1 min 45 seg** |
| **CLIP 2** | **ANA FÉLIX** | **Diapositiva 5** (Operaciones MongoDB y Compass) | **~1 min 15 seg** |
| **CLIP 3** | **AXEL HUAPAYA** | **Diapositivas 6, 7 y 8** (Análisis Comparativo, Estrategia 3-2-1 y Objetivos) | **~1 min 35 seg** |

---

## 🎬 GUIONES INDIVIDUALES PALABRA POR PALABRA

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ CLIP 1 | HUGO FERNÁNDEZ (TOMA CONTINUA: DIAPOSITIVAS 1 A 4)                  ║
║ Duración estimada: ~1 minuto y 45 segundos                                   ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

> **Instrucciones para Hugo:**  
> Abres tu presentación en pantalla completa, inicias la grabación con **`Win + Alt + R`** y hablas de corrido avanzando tus láminas del 1 al 4. Al terminar tu última frase, cortas la grabación con **`Win + Alt + R`** y guardas tu archivo como `hugo.mp4`.

---

#### 📌 DIAPOSITIVA 1 | Portada
*(Inicias a grabar)*

> *"Buenas tardes profesor y compañeros.*  
> *En esta oportunidad, nuestro equipo de proyecto conformado por **Hugo Fernandez, Ana Félix y Axel Huapaya**, presenta la sustentación de la actividad: **Estrategias de Backup y Restauración de Base de Datos**, aplicada a nuestra empresa agrícola **Agropacayales S.A.C.***  
> 
> *A lo largo de este video demostraremos cómo garantizar la resiliencia y la disponibilidad continua de los datos bajo una arquitectura políglota, abordando el motor relacional en **SQL Server** y el motor no relacional en **MongoDB**.*  
> 
> *Pasemos a revisar las métricas de negocio que sustentan nuestra estrategia."*

*(Pasas a la Diapositiva 2)*

---

#### 📌 DIAPOSITIVA 2 | Continuidad de Negocio

> *"Para diseñar cualquier plan de respaldo empresarial debemos responder a dos métricas fundamentales que vemos en pantalla:*  
> 
> *Primero, el **RPO (Recovery Point Objective)**, fijado en **menos de 15 minutos**. Representa la tolerancia máxima a la pérdida de datos en el tiempo, asegurada mediante copias continuas de los registros transaccionales.*  
> 
> *Segundo, el **RTO (Recovery Time Objective)**, establecido en **menos de 30 minutos**. Mide el tiempo máximo admisible para reactivar el sistema operativo y las bases de datos tras una contingencia grave.*  
> 
> *Ahora analicemos la arquitectura políglota de nuestro proyecto."*

*(Pasas a la Diapositiva 3)*

---

#### 📌 DIAPOSITIVA 3 | Arquitectura Políglota

> *"En Agropacayales S.A.C. adoptamos una **arquitectura políglota** aprovechando lo mejor de cada paradigma:*  
> 
> *A la izquierda tenemos **SQL Server**: diseñado con una estructura relacional estricta para garantizar cumplimiento transaccional **ACID** en el catálogo de cultivos, actividades de campo y cosechas, sumando más de 800 registros vinculados a 50 lotes agrícolas. Toda la base de datos se respalda en un único archivo binario monolítico **.BAK**.*  
> 
> *A la derecha tenemos **MongoDB**: gestiona colecciones de documentos JSON semiestructurados bajo esquemas de validación para insumos, usuarios y parcelas, permitiendo respaldos modulares mediante exportaciones JSON en Compass y volcados binarios BSON con utilidades CLI.*  
> 
> *Veamos a continuación la ejecución técnica en SQL Server."*

*(Pasas a la Diapositiva 4)*

---

#### 📌 DIAPOSITIVA 4 | Operaciones SQL Server (Ejecución T-SQL)

> *"En esta lámina observamos la automatización técnica de respaldos y recuperación en **SQL Server**:*  
> 
> *Como indica el punto 1, la **generación de la copia de seguridad de toda la base de datos** se ejecuta mediante la instrucción `BACKUP DATABASE [agropacayales_db] TO DISK = '...' WITH FORMAT, INIT;`. Esto empaqueta los archivos de datos y el log de transacciones en un archivo binario monolítico **.BAK** con validación de integridad.*  
> 
> *En el punto 2, para la **restauración ante contingencias o errores operativos**, aplicamos un protocolo estricto: primero pasamos la base a modo `SINGLE_USER WITH ROLLBACK IMMEDIATE`, cerrando cualquier conexión concurrente que pueda bloquear la operación. Luego ejecutamos `RESTORE DATABASE db FROM DISK = '...'` con la cláusula `WITH REPLACE`, sobrescribiendo el estado dañado y devolviendo toda la base de datos a su estado original al 100%.*  
> 
> ***A continuación, mi compañera Ana Félix continuará con las operaciones correspondientes en MongoDB.***"*

*(Detienes tu grabación con **`Win + Alt + R`**)* 🛑

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ CLIP 2 | ANA FÉLIX (TOMA CONTINUA: DIAPOSITIVA 5)                            ║
║ Duración estimada: ~1 minuto y 15 segundos                                   ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

> **Instrucciones para Ana:**  
> Te ubicas en la Diapositiva 5, inicias tu grabación y hablas de corrido. Al terminar, cortas y guardas como `ana.mp4`.

---

#### 📌 DIAPOSITIVA 5 | Operaciones MongoDB (Gestión CLI y Compass)
*(Inicia la grabación)*

> *"Gracias, Hugo.*  
> *Continuando con la gestión no relacional en **MongoDB**, abordamos un modelo modular centrado en colecciones documentales:*  
> 
> *Como indica el punto 1, realizamos el **volcado BSON completo** mediante la instrucción `mongodump --db=agropacayales_db --out=C:\Backups\dump`. Esto extrae los documentos y los archivos de metadatos de las colecciones `supplies`, `users` y `plots`. Asimismo, desde la herramienta visual **MongoDB Compass**, podemos realizar la exportación granular de cualquier colección directamente a formato **JSON** estándar.*  
> 
> *En el punto 2, para la **recuperación ante desastres y reconstrucción de índices**, ejecutamos `mongorestore --db=agropacayales_db --drop` apuntando a la carpeta de respaldo, o realizamos la importación del archivo JSON mediante el asistente **Add Data ➔ Import JSON** en Compass. Esto regenera los documentos preservando los identificadores de negocio y sus tipos de datos en segundos.*  
> 
> ***A continuación, mi compañero Axel Huapaya presentará el análisis comparativo, la estrategia 3-2-1 y las conclusiones finales.***"*

*(Detienes tu grabación)* 🛑

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ CLIP 3 | AXEL HUAPAYA (TOMA CONTINUA: DIAPOSITIVAS 6 A 8)                    ║
║ Duración estimada: ~1 minuto y 35 segundos                                   ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

> **Instrucciones para Axel:**  
> Te ubicas en la Diapositiva 6, inicias tu grabación y hablas de corrido avanzando por las láminas 6, 7 y 8. Al terminar tu despedida, cortas y guardas como `axel.mp4`.

---

#### 📌 DIAPOSITIVA 6 | Análisis Comparativo
*(Inicia la grabación)*

> *"Gracias, Ana.*  
> *Continuando con la sustentación, en esta tabla comparativa resumimos las diferencias técnicas sustanciales entre ambos paradigmas:*  
> 
> *- **Naturaleza:** SQL Server genera un archivo binario `.bak` propietario del motor, mientras que MongoDB produce documentos abiertos en texto JSON o volcados binarios BSON independientes.*  
> *- **Consistencia:** SQL Server ofrece consistencia transaccional ACID estricta a nivel global de todo el catálogo. MongoDB ofrece consistencia fuerte por documento individual y replicación en clúster vía Oplog.*  
> *- **Point-in-Time:** SQL Server permite recuperaciones al segundo exacto aplicando la cadena de Transaction Logs. En MongoDB se logra mediante la reproducción del Oplog en Replica Sets.*  
> *- **Portabilidad:** SQL Server es dependiente del motor, mientras que MongoDB es completamente agnóstico y universal entre servidores, contenedores Docker y nubes públicas.*"

*(Pasas a la Diapositiva 7)*

---

#### 📌 DIAPOSITIVA 7 | Estrategia 3-2-1

> *"Para blindar la seguridad de la información corporativa, aplicamos la **Estrategia 3-2-1** con cifrado fuerte **AES-256 en reposo**:*  
> 
> *- **3 Copias Totales:** La copia activa en producción más dos respaldos redundantes.*  
> *- **2 Medios Físicos:** Almacenamiento local rápido en discos SSD/NVMe para восстановить con agilidad, y un repositorio secundario en la red interna.*  
> *- **1 Copia Externa:** Aislamiento físico en una nube segura como AWS S3 o Google Cloud Storage con políticas de inmutabilidad contra ataques de ransomware.*  
> 
> *Esta estrategia garantiza que ningún incidente físico o de malware comprometa los datos de la empresa.*"

*(Pasas a la Diapositiva 8)*

---

#### 📌 DIAPOSITIVA 8 | Objetivos Logrados y Cierre

> *"Para finalizar nuestra presentación, destacamos los objetivos alcanzados en este proyecto:*  
> 
> *- **Primero:** Validamos los tiempos de **RPO menor a 15 minutos** y **RTO menor a 30 minutos** sobre bases de datos reales.*  
> *- **Segundo:** Garantizamos la recuperación íntegra ante incidentes tanto en **SQL Server Management Studio** como en **MongoDB Compass**.*  
> *- **Tercero:** Completamos la documentación técnica exhaustiva y las guías paso a paso para todo el equipo.*  
> 
> *Compartimos con el profesor el enlace al video demostrativo completo y nuestro repositorio oficial de GitHub.*  
> *Agradecemos sinceramente su atención. ¡Muchas gracias!*"

*(Detienes tu grabación)* 🛑

---

### 🎬 EDICIÓN FINAL EN CLIPCHAMP / CAPCUT
1. Arrastras `hugo.mp4` a la línea de tiempo (0:00 ➔ 1:45).
2. Pegas `ana.mp4` a continuación (1:45 ➔ 3:00).
3. Pegas `axel.mp4` al final (3:00 ➔ 4:35).
4. Exportas en **1080p** como `Video_Demostrativo_S11_Agropacayales.mp4`.
5. ¡Listo para subir a Google Drive y compartir con el profesor!
