# 🗄️ Documentación de Base de Datos: ManufacturingCompany

Este repositorio contiene el diseño lógico, físico y los scripts de carga para el sistema de gestión de inventarios, ventas y compras en **SQL Server**.

## 📍 Índice de Navegación
* [Parte 1: Configuración del Entorno](#parte-1-configuración-del-entorno)
* [Parte 2 y 3: Diseño de Tablas y Relaciones (DER)](#parte-2-y-3-diseño-de-tablas-y-relaciones-der)
* [Parte 4: Carga de Catálogos (Maestras)](#parte-4-carga-de-catálogos-maestras)
* [Parte 5: Carga Transaccional Masiva](#parte-5-carga-transaccional-masiva)
* [Parte 6: Resumen de Verificación](#parte-6-resumen-de-verificación)

---

##  Parte 1: Configuración del Entorno
Se inicializa la base de datos `ManufacturingCompany`. El script asegura la creación limpia del entorno y ajusta el modelo de recuperación a `SIMPLE` para permitir cargas masivas de alta velocidad sin saturar el log de transacciones.

---

##  Parte 2 y 3: Diseño de Tablas y Relaciones (DER)
El sistema utiliza una arquitectura relacional normalizada. Se definen las Primary Keys y Foreign Keys para garantizar que cada venta o compra esté vinculada a un producto y tienda existentes.



**Tablas Principales:**
* **Maestras:** `Proveedor`, `Stores`, `Brands`.
* **Transaccionales:** `Inventory`, `Purchases`, `SalesDetail`.

---

##  Parte 4: Carga de Catálogos (Maestras)
En esta sección se pueblan las tablas descriptivas. El código utiliza tablas temporales para procesar los archivos CSV originales:
1.  **Proveedor:** Extrae nombres únicos mediante `GROUP BY`.
2.  **Stores:** Normaliza los datos de las sucursales.
3.  **Brands:** Realiza un casteo seguro (`TRY_CAST`) de precios y volúmenes, vinculando cada producto con su proveedor.

---

##  Parte 5: Carga Transaccional Masiva
Es el núcleo técnico del script. Procesa más de 3.8 millones de registros utilizando:
* **Full Outer Join:** Para consolidar el inventario inicial y final.
* **Batch Processing:** Inserciones en bloques de 25,000 a 50,000 registros para evitar el bloqueo de tablas y optimizar la memoria.
* **Limpieza al vuelo:** Uso de `COALESCE` y `NULLIF` para manejar datos faltantes en los archivos fuente.



---

##  Parte 6: Resumen de Verificación
Al final de la ejecución, el script imprime un resumen detallado con el conteo de registros por tabla. Esto permite validar visualmente que la carga coincide con los archivos origen y que no hubo pérdida de información durante las transformaciones.

---

### 🚀 Instrucciones de Uso
1.  Verificar que los archivos CSV se encuentren en `C:\ManufacturingCompany\DATASET INVENTORY\`.
2.  Ejecutar el script en SSMS.
3.  Monitorear los mensajes de impresión (`PRINT`) para ver el progreso de los lotes de ventas y compras.
