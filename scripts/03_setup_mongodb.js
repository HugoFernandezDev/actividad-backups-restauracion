// ==============================================================================
// AGROPACAYALES S.A.C. — SCRIPT DE INICIALIZACIÓN RÁPIDA (MONGODB)
// Ejecutar en MongoDB Compass (en la consola MONGOSH de abajo) o vía terminal
// ==============================================================================

const DB_NAME = 'agropacayales_db';
db = db.getSiblingDB(DB_NAME);

print(`[MONGODB] Inicializando base de datos '${DB_NAME}'...`);

// 1. Eliminar colección previa si existe
if (db.getCollectionNames().includes('supplies')) {
    db.supplies.drop();
    print("  • Colección previa 'supplies' eliminada limpiamente.");
}

// 2. Crear colección con esquema de validación
db.createCollection('supplies');

// 3. Insertar documentos semilla de insumos agrícolas
db.supplies.insertMany([
    {
        _id: "INS-FERT-001",
        nombre: "Nitrato de Calcio Grado Fertirriego",
        tipo_insumo: "Fertilizante",
        stock: 1500,
        unidad_medida: "Kilogramos (kg)",
        precio: 42.50,
        proveedor: "Yara Perú S.A.",
        activo: true,
        fecha_ingreso: new Date()
    },
    {
        _id: "INS-PEST-002",
        nombre: "Abamectina 1.8% EC Acaricida",
        tipo_insumo: "Pesticida",
        stock: 350,
        unidad_medida: "Litros (L)",
        precio: 78.00,
        proveedor: "Syngenta Crop Protection",
        activo: true,
        fecha_ingreso: new Date()
    },
    {
        _id: "INS-HERB-003",
        nombre: "Glifosato 480 SL Sistémico",
        tipo_insumo: "Herbicida",
        stock: 800,
        unidad_medida: "Litros (L)",
        precio: 35.20,
        proveedor: "Bayer CropScience",
        activo: true,
        fecha_ingreso: new Date()
    },
    {
        _id: "INS-BIO-004",
        nombre: "Extracto de Algas Marinas Ascophyllum",
        tipo_insumo: "Bioestimulante",
        stock: 620,
        unidad_medida: "Litros (L)",
        precio: 95.00,
        proveedor: "BioAtlantis Ltd.",
        activo: true,
        fecha_ingreso: new Date()
    },
    {
        _id: "INS-ENR-005",
        nombre: "Ácidos Húmicos y Fúlvicos Granulados",
        tipo_insumo: "Enmienda Orgánica",
        stock: 2200,
        unidad_medida: "Kilogramos (kg)",
        precio: 28.90,
        proveedor: "Tradecorp Internacional",
        activo: true,
        fecha_ingreso: new Date()
    }
]);

print(`[MONGODB] Se insertaron ${db.supplies.countDocuments()} documentos en 'supplies'.`);
