🚀 AWS Inventory ETL Pipeline

📊 Descripción del Proyecto

🏗️ Arquitectura y Flujo de Datos
En este proyecto se implementó una arquitectura de procesamiento de datos en la nube utilizando servicios de AWS, organizada en etapas de ingesta, almacenamiento, transformación y consumo.

Ingesta (Capa Raw): Se utilizan distintas fuentes de datos (clientes, ERP, servidores). Mediante una función AWS Lambda en Python, se consumen APIs para extraer la información y almacenarla en Amazon S3 (Raw Data) en su estado original.

Catalogación (Metadatos):
AWS Glue Crawler analiza los archivos en S3 y detecta automáticamente su estructura. Los metadatos (columnas, tipos de datos, esquemas) se registran en AWS Glue Data Catalog.

Transformación (ETL):
Mediante AWS Glue Jobs, se aplican reglas de limpieza:

Validación y manejo de nulos.

Ajuste de tipos de datos.

Corrección de inconsistencias.
Los datos limpios se depositan en Amazon S3 (Clear Data).

Carga y Normalización (Capa SQL):
Una segunda AWS Lambda detecta los datos en la capa Clear y ejecuta un proceso de carga hacia SQL Database mediante scripts predefinidos, automatizando la carga que anteriormente era manual.
