🛠️ Ingeniería de Datos: De la Auditoría a la Automatización
Este repositorio documenta el ciclo de vida de los datos para un sistema de gestión de inventarios, abarcando desde el diagnóstico técnico hasta la implementación de una arquitectura de datos escalable.

🔍 1. Auditoría Técnica (Python)
El proyecto inicia con la auditoría de 6 datasets. Utilizando Pandas, se realizó un diagnóstico para identificar cuellos de botella antes de la migración a la nube.

Diagnóstico: Se detectó que las columnas de fechas (como startDate, SalesDate, InvoiceDate, etc.) estaban tipificadas como object (texto).

Decisión Estratégica: En lugar de realizar una limpieza manual, se optó por documentar estas necesidades para automatizarlas mediante un proceso de ETL, garantizando que el sistema sea capaz de procesar nuevas cargas de datos sin intervención humana.

⚙️ 2. Pipeline de Automatización (AWS)
Para transformar los datos de forma eficiente, se implementó una arquitectura de Data Lake en AWS:

S3 Raw: Ingesta de los archivos CSV originales en su estado nativo.

AWS Glue (ETL): Se configuró un motor de procesamiento que realiza la limpieza automática:

Normalización de Tipos: Conversión masiva de formatos de texto a Date/Timestamp.

Calidad de Datos: Filtrado de registros y tratamiento de nulos para asegurar la integridad referencial.

S3 Data Clean (Escalabilidad): Los datos procesados se almacenan en un segundo nivel de S3.

Nota Técnica: Se decidió mantener esta capa de datos limpios en S3 para permitir que el proyecto escale. Esto facilita que, en el futuro, herramientas de Machine Learning o Big Data accedan a la información sin depender de la base de datos SQL.

📥 3. Almacenamiento y Modelado (SQL Server)
Finalmente, los datos curados se sincronizan con una instancia de SQL Server, donde se realiza el modelado relacional:

Consolidación: Unión de los archivos de compras, ventas e inventarios.

Arquitectura Híbrida: El uso de una base de datos local para el consumo final permite un análisis de alta velocidad, optimizado para la creación de reportes y tableros de control.

📥 Acceso a los Datos
Debido a la alta volumetría de los registros, los archivos originales pueden descargarse para auditoría externa en el siguiente enlace:
https://www.kaggle.com/datasets/bhanupratapbiswas/inventory-analysis-case-study
