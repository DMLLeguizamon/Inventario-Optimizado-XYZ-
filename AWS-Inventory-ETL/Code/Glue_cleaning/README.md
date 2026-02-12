Proceso de Transformación (AWS Glue ETL)
Este componente es el corazón del pipeline de datos. Se encarga de transformar los datos crudos (Raw Data) en datos limpios y optimizados (Clear Data) utilizando una arquitectura basada en Metadatos (Metadata-Driven).

1. Arquitectura del Código
El script no procesa archivos de forma aislada, sino que utiliza el AWS Glue Data Catalog. Esto permite que el código sea independiente de la ubicación física de los archivos, consultando la estructura de las tablas directamente desde el diccionario de datos generado por el Crawler.

2. Definición de Contratos (DATA_CONTRACTS)
El código utiliza un diccionario de configuración llamado DATA_CONTRACTS. En este bloque se define el "deber ser" de cada tabla:

Campos Numéricos (int/float): Para cálculos matemáticos.

Campos de Texto (string): Para descripciones y categorías.

Campos de Fecha (date): Para análisis temporal.

Utilidad: Si la estructura de una tabla cambia o se agrega una nueva, solo se modifica este diccionario, no la lógica de las funciones.

3. Fases de Limpieza (Funciones)
A. Tipado de Datos (cast_columns)
Convierte los datos detectados por el Crawler al tipo de dato final. Esto previene errores de "Type Mismatch" al intentar insertar la información en la base de datos SQL.

B. Normalización de Texto (clean_strings)
Aplica trim (elimina espacios innecesarios) y upper (convierte a mayúsculas).

Objetivo: Eliminar la duplicidad de registros causada por errores de carga (ej: "Producto A" vs " producto a").

C. Imputación de Valores Nulos (impute_nulls)
Para no perder filas importantes, se aplica una estrategia de reemplazo:

Numéricos: Se calcula la mediana de la columna. Se prefiere la mediana sobre el promedio porque es más robusta frente a errores de carga extremos.

Texto: Se asigna el valor "UNKNOWN".

Fechas: Se asigna una fecha base "1900-01-01".

D. Tratamiento de Valores Atípicos (treat_outliers)
Utiliza la técnica estadística de Rango Intercuartílico (IQR) para detectar valores que están fuera de la lógica del negocio (ej: un precio de $99.999.999 en un producto de $10).

Acción: Realiza un "Capping" (ajusta el valor al límite máximo permitido) para evitar que los reportes finales se distorsionen.

4. Salida y Optimización
El código guarda los resultados en formato Parquet con modo overwrite.

Parquet: Es un formato de almacenamiento columnar que reduce el peso de los archivos y acelera las consultas de la Lambda de carga y de SQL.

Idempotencia: Al usar overwrite, el proceso se puede re-ejecutar las veces que sea necesario sin duplicar la información en S3.
