# De S3 a SQL Server

Este proyecto contiene el código automático (**AWS Lambda**) encargado de llevar los datos que ya están limpios en el depósito de la nube (S3) hacia las tablas finales de nuestra base de datos en **SQL Server**.

El objetivo es poblar el modelo de datos de la empresa respetando la estructura y las relaciones entre las tablas.

### ¿Cómo funciona este proceso?

El código actúa como un organizador que sigue un orden lógico para no romper nada. No carga todo de golpe, sino que lo hace en **6 etapas secuenciales**:

---

## 1. El Puente de Conexión
El proceso empieza conectándose a la base de datos usando las llaves de seguridad (usuario y contraseña). Una vez que la puerta está abierta, se prepara para recibir los archivos uno por uno.

## 2. Las Tablas de Paso (El Borrador)
Para cada archivo que viene de la nube, el código crea una **"tabla temporal"** en la base de datos. Se usa como un espacio de trabajo para volcar la información del archivo antes de decidir qué se guarda definitivamente y qué no.

## 3. El Filtro de "No Repetidos"
Esta es la parte más importante. Para cada dato nuevo, el código hace una pregunta: **"¿Este registro ya existe en mi tabla final?"**.

* **Si ya existe:** Lo ignora (así no tenemos datos duplicados).
* **Si es nuevo:** Lo guarda en su estante correspondiente.

---

## Las 6 Cargas en Orden
Para que la base de datos funcione bien, el código sigue este orden de llenado:

1.  **Proveedores:** Se cargan primero para saber a quién le compramos.
2.  **Tiendas (Stores):** Se cargan para saber dónde ocurre la actividad.
3.  **Marcas (Brands):** Se carga el catálogo de productos con sus precios y descripciones.
4.  **Inventario:** Aquí el código toma **dos archivos** (lo que había al inicio y lo que quedó al final), los une en la mesa de trabajo y crea una sola ficha completa por producto.
5.  **Detalle de Ventas:** Se registran todos los movimientos de salida de mercadería.
6.  **Compras:** Se registran las entradas de productos, incluyendo datos clave como el **flete** y la **aprobación**.

---

## Seguridad y Cierre

* **Guardado Automático:** Una vez que las 6 tablas terminan de cargarse, el código da la orden de **"Confirmar"** para que los cambios queden grabados permanentemente.
* **Protocolo de Error:** Si algún archivo viene mal o se corta la conexión, el código se detiene automáticamente y avisa qué falló para evitar que entren datos incompletos.
* **Limpieza:** Al terminar, se borran todas las tablas temporales (los borradores) para que la base de datos quede reluciente y solo con la información que importa.

