# Ingesta de Datos (Lambda Ingestion)

Este componente es el punto de entrada de la plataforma. Su función es extraer datos de una API externa y depositarlos de forma segura en la capa de almacenamiento inicial (S3 Raw).

## 1. Funcionamiento del Script

La Lambda actúa como un puente (Bridge). Realiza una petición GET autenticada a la API configurada y guarda la respuesta completa en formato JSON sin aplicar ninguna transformación. Esto garantiza que tengamos un respaldo fiel de la información original (Principio de Inmutabilidad).

## 2. Puntos Clave del Código
   
Autenticación: Utiliza encabezados con Bearer Token para asegurar la comunicación con el proveedor de datos.

Control de Errores: Incluye un manejo de excepciones que valida el código de estado de la respuesta (solo acepta 200 OK) y captura errores de conexión o tiempo de espera.

Trazabilidad: Genera nombres de archivos únicos basados en un timestamp (fecha y hora exacta), lo que evita que los datos nuevos pisen a los anteriores y permite auditorías históricas.

## 3. Configuración (Variables de Entorno)
   
Para que el código sea seguro y reutilizable, utiliza variables de entorno en AWS:

API_URL: Dirección del endpoint de datos.

API_KEY: Llave de acceso secreta (evita dejar credenciales escritas en el código).

DESTINATION_BUCKET: Nombre del bucket S3 donde se deposita la información.

## 4. Flujo de Salida
Destino: s3://[bucket-name]/raw-data/

Formato: JSON

Estructura de archivo: data_YYYYMMDD_HHMMSS.json
