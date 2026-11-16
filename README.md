# Estrategias de Backup y Restauración de Base de Datos
## Demostración Técnica: Microsoft SQL Server y MongoDB
### Empresa / Proyecto: Agropacayales S.A.C.

![Arquitectura](https://img.shields.io/badge/Arquitectura-Pol%C3%ADglota-blue.svg)
![SQL Server](https://img.shields.io/badge/SQL%20Server-Relacional%20ACID-red.svg)
![MongoDB](https://img.shields.io/badge/MongoDB-NoSQL%20Documental-green.svg)
![Continuidad](https://img.shields.io/badge/RPO%20%3C%2015min-RTO%20%3C%2030min-orange.svg)

---

## 👥 Integrantes del Equipo de Proyecto
* **Hugo Fernandez** (Líder / Motor Relacional SQL Server)
* **Ana** (Arquitectura Políglota / Motor No Relacional MongoDB)
* **Axel** (Análisis Comparativo, Ciberseguridad y Cierre)

---

## 📌 Objetivo de la Actividad
Diseñar, implementar y validar de manera práctica y didáctica los procedimientos estandarizados de **Copia de Seguridad (Backup)** y **Restauración (Restore)** para una arquitectura de datos políglota, garantizando la recuperación de la información ante fallos o errores operativos:
- **Base de Datos Relacional:** Microsoft SQL Server (vía SQL Server Management Studio y T-SQL).
- **Base de Datos No Relacional:** MongoDB (vía MongoDB Compass y herramientas nativas CLI).

### 🎯 Métricas de Continuidad de Negocio
* **RPO (Recovery Point Objective):** `< 15 minutos` (Tolerancia máxima a la pérdida de datos).
* **RTO (Recovery Time Objective):** `< 30 minutos` (Tiempo máximo de reactivación del sistema).

---

## 📂 Estructura del Repositorio

```text
actividad-backups-restauracion/
├── docs/
│   ├── MANUAL_PASO_A_PASO_COMPAÑEROS.md   # Guía práctica para que Ana y Axel repliquen todo en sus PCs
│   ├── GUION_PRESENTACION_SLIDES.md      # Guion de sustentación dividido para Hugo, Ana y Axel
│   ├── GUION_VIDEO_DEMOSTRACION.md       # Guion para la grabación del video demostrativo (3 a 5 min)
│   ├── DOCUMENTACION_TECNICA.md          # Informe técnico exhaustivo para entrega académica
│   └── DOCUMENTACION_TECNICA.html        # Plantilla estilizada lista para copiar a Google Docs
├── scripts/
│   ├── 01_setup_database_sqlserver.sql   # Inicializa agropacayales_db y tabla cultivos en SQL Server
│   ├── 02_backup_restore_sqlserver.sql   # T-SQL completo (Backup Full, simulación y Restore con WITH REPLACE)
│   ├── 03_setup_mongodb.js               # Inicializa agropacayales_db y colección supplies en MongoDB
│   └── 04_backup_restore_mongodb.bat     # Automatización CLI de mongodump y mongorestore
├── .gitignore                             # Ignora archivos binarios pesados (.bak, .dump, pdf)
└── README.md                              # Documentación general del repositorio
```

---

## 🚀 Guía Rápida de Ejecución

### 1. Preparar Entorno Local
Crea la carpeta de respaldo en la raíz de tu disco C:
```powershell
mkdir C:\Backups
```

### 2. SQL Server (Relacional)
1. Abre **SSMS** y ejecuta `scripts/01_setup_database_sqlserver.sql` para crear la base `agropacayales_db` y la tabla `cultivos`.
2. Ejecuta `scripts/02_backup_restore_sqlserver.sql` o sigue los menús en SSMS (*Tasks ➔ Back Up...* y *Restore Database...*).

### 3. MongoDB (No Relacional)
1. Abre **MongoDB Compass**, conecta a `mongodb://localhost:27017` y corre `scripts/03_setup_mongodb.js` en la consola `_MONGOSH`.
2. Para respaldar, haz clic en **Export Data ➔ Export full collection** en formato JSON hacia `C:\Backups\supplies_backup.json`.
3. Para restaurar, haz clic en **Add Data ➔ Import JSON or CSV file** y selecciona el archivo de respaldo.

---

## 📚 Documentación de Apoyo
* Para que tus compañeros repliquen la práctica paso a paso en sus computadoras: consulta [`docs/MANUAL_PASO_A_PASO_COMPAÑEROS.md`](docs/MANUAL_PASO_A_PASO_COMPAÑEROS.md).
* Para la sustentación con diapositivas dividida por turnos: consulta [`docs/GUION_PRESENTACION_SLIDES.md`](docs/GUION_PRESENTACION_SLIDES.md).
* Para el video demostrativo subido a Google Drive: consulta [`docs/GUION_VIDEO_DEMOSTRACION.md`](docs/GUION_VIDEO_DEMOSTRACION.md).
