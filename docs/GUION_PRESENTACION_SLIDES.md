# GUION OFICIAL DE PRESENTACIÓN EN EQUIPO (HUGO, ANA Y AXEL)
## Estrategias de Backup y Restauración: Demostración Técnica SQL Server y MongoDB
### Diapositivas Diseñadas por Hugo Fernandez | Proyecto: Agropacayales S.A.C.

> **Estructura de la Presentación:** Basada exactamente en las 8 diapositivas del PDF mejorado por Hugo.  
> **Duración total:** ~4 minutos y 45 segundos (~1:35 min por integrante).

---

### 👥 DISTRIBUCIÓN EQUITATIVA DE ROLES Y LÁMINAS

| Integrante | Diapositivas Asignadas | Eje Temático | Tiempo Estimado |
| :--- | :--- | :--- | :--- |
| **HUGO** | **Diapositivas 1, 2 y 4** | Portada, Continuidad de Negocio y Operaciones SQL Server (T-SQL) | ~1 min 45 seg |
| **ANA** | **Diapositivas 3 y 5** | Arquitectura Políglota y Operaciones MongoDB (CLI) | ~1 min 30 seg |
| **AXEL** | **Diapositivas 6, 7 y 8** | Análisis Comparativo, Estrategia 3-2-1 y Objetivos Logrados | ~1 min 40 seg |

---

## 🎬 GUION DIAPOSITIVA POR DIAPOSITIVA (PALABRA POR PALABRA)

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ PARTE 1: HUGO (PORTADA Y CONTINUIDAD DE NEGOCIO)                             ║
║ Diapositivas 1 y 2 | Tiempo: ~1 minuto y 10 segundos                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 👤 PARTICIPANTE: HUGO

#### 📌 DIAPOSITIVA 1 | Portada
*👁️ Texto en pantalla: "Estrategias de Backup y Restauración — Demostración Técnica: SQL Server y MongoDB"*

> **HUGO:**  
> *"Buenas tardes profesor y compañeros.  
> En esta oportunidad, nuestro equipo de proyecto conformado por **Hugo Fernandez, Ana y Axel**, va a sustentar la actividad práctica: **Estrategias de Backup y Restauración** aplicadas a nuestra empresa agrícola **Agropacayales S.A.C.**
>
> En esta sesión demostraremos cómo garantizar la resiliencia y continuidad de los datos mediante una arquitectura políglota, abordando tanto la base de datos relacional en **SQL Server** como la no relacional en **MongoDB**.
>
> Pasemos a revisar las métricas de negocio que rigen nuestra estrategia."*

*(Hugo pasa a la Diapositiva 2)*

---

#### 📌 DIAPOSITIVA 2 | Continuidad de Negocio
*👁️ Texto en pantalla: "RPO < 15 min (Tolerancia máxima de pérdida) | RTO < 30 min (Reactivación del sistema operativo)"*

> **HUGO:**  
> *"Para diseñar cualquier plan de respaldo empresarial debemos responder a dos métricas fundamentales que vemos en pantalla:
>
> Primero, el **RPO (Recovery Point Objective)**, fijado en **menos de 15 minutos**. Representa la tolerancia máxima a la pérdida de datos en el tiempo; en nuestro caso asegurado mediante copias frecuentes del registro de transacciones.
>
> Segundo, el **RTO (Recovery Time Objective)**, establecido en **menos de 30 minutos**. Mide el tiempo máximo que nos toma reactivar el sistema operativo y las bases de datos tras una contingencia.
>
> Ahora, le cedo la palabra a mi compañera **Ana**, quien explicará nuestra arquitectura políglota."*

*(Hugo da el pase a Ana)*

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ PARTE 2: ANA (ARQUITECTURA POLÍGLOTA)                                        ║
║ Diapositiva 3 | Tiempo: ~45 segundos                                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 👤 PARTICIPANTE: ANA

#### 📌 DIAPOSITIVA 3 | Arquitectura Políglota
*👁️ Texto en pantalla: "SQL Server (Estructura relacional estricta, Cumplimiento transaccional ACID, Respaldo en binario .BAK) | MongoDB (Colecciones de documentos JSON, Esquemas flexibles, Exportación rápida BSON)"*

> **ANA:**  
> *"Gracias, Hugo. Buenas tardes profesor.  
> En Agropacayales S.A.C. implementamos una **arquitectura políglota** que aprovecha lo mejor de cada paradigma:
>
> A la izquierda tenemos **SQL Server**: diseñado con una estructura relacional estricta para garantizar cumplimiento transaccional **ACID** en el catálogo de cultivos y labores agrícolas. Sus respaldos se consolidan en archivos binarios **.BAK** con páginas de datos y logs.
>
> A la derecha tenemos **MongoDB**: gestiona colecciones de documentos JSON semiestructurados como insumos y usuarios, brindando esquemas flexibles y alta velocidad de exportación en formato binario **BSON** y **JSON**.
>
> Ahora mi compañero **Hugo** nos explicará las operaciones de respaldo y restauración en SQL Server."*

*(Ana le devuelve el turno a Hugo)*

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ PARTE 3: HUGO (OPERACIONES SQL SERVER)                                       ║
║ Diapositiva 4 | Tiempo: ~1 minuto                                            ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 👤 PARTICIPANTE: HUGO

#### 📌 DIAPOSITIVA 4 | Operaciones SQL Server (Ejecución T-SQL)
*👁️ Texto en pantalla: "1 Generación de .BAK | 2 Restauración con ROLLBACK | Código T-SQL con BACKUP DATABASE y ALTER DATABASE db SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE..."*

> **HUGO:**  
> *"Gracias, Ana. En esta lámina vemos la automatización técnica de respaldos en **SQL Server**:
>
> Como indica el punto 1, la **generación del archivo .BAK** se realiza mediante la instrucción `BACKUP DATABASE [agropacayales_db] TO DISK = 'C:\Backups\db.bak' WITH FORMAT, INIT;`. Esto empaqueta los datos activos y el log con verificación de integridad.
>
> En el punto 2, para la **restauración ante contingencias**, aplicamos un protocolo estricto: primero pasamos la base a modo `SINGLE_USER WITH ROLLBACK IMMEDIATE`, cerrando cualquier conexión concurrente que pueda bloquear el proceso. Acto seguido, ejecutamos `RESTORE DATABASE db FROM DISK = '...'` con la cláusula `REPLACE`, sobreescribiendo el estado corrupto y devolviendo la base a la normalidad.
>
> Ahora mi compañera **Ana** nos detallará las operaciones correspondientes en MongoDB."*

*(Hugo da el pase a Ana)*

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ PARTE 4: ANA (OPERACIONES MONGODB)                                           ║
║ Diapositiva 5 | Tiempo: ~45 segundos                                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 👤 PARTICIPANTE: ANA

#### 📌 DIAPOSITIVA 5 | Operaciones MongoDB (Gestión CLI)
*👁️ Texto en pantalla: "1 Volcado BSON completo | 2 Recuperación de índices | Código CLI: mongodump --db=agropacayales_db --out=C:\Backups\dump | mongorestore --db=agropacayales_db C:\Backups\dump\agropacayales_db"*

> **ANA:**  
> *"Gracias, Hugo. En el entorno no relacional, la administración se enfoca en la portabilidad directa de las colecciones:
>
> En el punto 1, realizamos el **volcado BSON completo** utilizando la herramienta nativa `mongodump --db=agropacayales_db --out=C:\Backups\dump`. Esto extrae los documentos y los metadatos de la colección `supplies`. Además, desde **MongoDB Compass**, podemos realizar este proceso visualmente exportando la colección completa en formato JSON.
>
> En el punto 2, para la **recuperación y reconstrucción de índices**, ejecutamos `mongorestore --db=agropacayales_db` apuntando a la carpeta del dump, o importamos el archivo JSON directamente en Compass. Esto regenera instantáneamente las claves primarias e índices de negocio.
>
> A continuación, mi compañero **Axel** presentará el análisis comparativo y la estrategia de ciberseguridad."*

*(Ana da el pase a Axel)*

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ PARTE 5: AXEL (ANÁLISIS COMPARATIVO, ESTRATEGIA 3-2-1 Y CIERRE)              ║
║ Diapositivas 6, 7 y 8 | Tiempo: ~1 minuto y 40 segundos                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 👤 PARTICIPANTE: AXEL

#### 📌 DIAPOSITIVA 6 | Análisis Comparativo
*👁️ Texto en pantalla: Tabla comparativa (Naturaleza, Consistencia, Point-in-Time, Portabilidad).*

> **AXEL:**  
> *"Buenas tardes profesor. Continuando con la sustentación, en esta tabla resumimos las diferencias técnicas clave entre ambos motores:
>
> - **Naturaleza:** SQL Server maneja un archivo binario propietario `.bak`, mientras que MongoDB produce texto JSON estructurado o binarios BSON portables.
> - **Consistencia:** SQL Server ofrece consistencia transaccional ACID estricta a nivel global. MongoDB ofrece consistencia fuerte a nivel de documento individual.
> - **Point-in-Time:** SQL Server permite recuperaciones al segundo exacto aplicando Logs de Transacciones. En MongoDB se logra mediante la reproducción del Oplog en Replica Sets.
> - **Portabilidad:** SQL Server es dependiente del motor de Microsoft, mientras que MongoDB es completamente agnóstico y universal entre servidores, contenedores y nubes públicas."*

*(Axel pasa a la Diapositiva 7)*

---

#### 📌 DIAPOSITIVA 7 | Estrategia 3-2-1
*👁️ Texto en pantalla: "Cifrado AES-256 en reposo | 3 Copias Totales | 2 Medios Físicos | 1 Copia Externa"*

> **AXEL:**  
> *"Para blindar la seguridad de la información corporativa, aplicamos la **Estrategia 3-2-1** con cifrado fuerte **AES-256 en reposo**:
>
> - **3 Copias Totales:** La copia activa en producción más dos respaldos redundantes.
> - **2 Medios Físicos:** Almacenamiento local rápido en discos SSD/NVMe para восстановить con agilidad, y un repositorio secundario en la red interna.
> - **1 Copia Externa:** Aislamiento físico en una nube segura como AWS S3 o Google Cloud Storage con políticas de inmutabilidad contra ataques de ransomware.
>
> Esta estrategia garantiza que ningún incidente físico o de malware comprometa los datos de la empresa."*

*(Axel pasa a la Diapositiva 8)*

---

#### 📌 DIAPOSITIVA 8 | Objetivos Logrados
*👁️ Texto en pantalla: "Agropacayales S.A.C. | Tiempos RPO y RTO validados | Recuperación ante incidentes garantizada | Documentación técnica completada"*

> **AXEL:**  
> *"Para finalizar nuestra presentación, destacamos los objetivos logrados en este proyecto:
>
> - **Primero:** Validamos los tiempos de RPO menor a 15 minutos y RTO menor a 30 minutos.
> - **Segundo:** Garantizamos la recuperación íntegra ante incidentes tanto en **SQL Server Management Studio** como en **MongoDB Compass**.
> - **Tercero:** Completamos la documentación técnica exhaustiva con guías reproducibles para todo el equipo y el video demostrativo.
>
> Agradecemos sinceramente su atención y quedamos a su disposición para cualquier consulta. ¡Muchas gracias!"*

---

### 💡 NOTAS PARA LA GRABACIÓN EN EQUIPO
1. **Transiciones claras:** Pronuncien el nombre del compañero al pasar de diapositiva para que el cambio de voz se escuche coordinado y profesional.
2. **Audio:** Mantener el micrófono en silencio mientras el otro compañero habla.
3. **Puntero:** Si usan Google Meet, Teams o Zoom para grabar la llamada, el que comparte pantalla puede usar el cursor para señalar el código de la diapositiva 4 o la tabla de la diapositiva 6 cuando Hugo o Axel las mencionen.
