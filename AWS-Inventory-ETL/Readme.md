# 🚀 AWS Inventory ETL Pipeline

## 📊 Descripción del Proyecto
En este proyecto se implementó una arquitectura de procesamiento de datos en la nube utilizando servicios de AWS, organizada en etapas de ingesta, almacenamiento, transformación y consumo.

---

## 🏗️ Arquitectura y Flujo de Datos

### 📉 Diagrama de Arquitectura
![Diagrama de flujo AWS](Img/Diagrama%20de%20flujo%20AWS.png)

---

### Ingesta (Capa Raw)
Se utilizan distintas fuentes de datos (clientes, ERP, servidores). Mediante una función AWS Lambda en Python, se consumen APIs para extraer la información y almacenarla en Amazon S3 (Raw Data) en su estado original.

* **📂 Ver Código:** [Lambda_ingesta](./Code/Lambda_ingesta)

![Ingesta](Img/1_Ingesta%20(Lambda).png)

---

### Catalogación (Metadatos)
AWS Glue Crawler analiza los archivos en S3 y detecta automáticamente su estructura. Los metadatos (columnas, tipos de datos, esquemas) se registran en AWS Glue Data Catalog.

![Catalogación](Img/2_Catalogación%20(CrawlerCatalog).png)

---

### Transformación (ETL)
Mediante AWS Glue Jobs, se aplican reglas de limpieza:
* Validación y manejo de nulos.
* Ajuste de tipos de datos.
* Corrección de inconsistencias.
Los datos limpios se depositan en Amazon S3 (Clear Data).

* **📂 Ver Código:** [Glue_cleaning](./Code/Glue_cleaning)

![Calidad](Img/3_Calidad%20%28S3%20Clear%29.png)

---

### Carga y Normalización (Capa SQL)
Una segunda AWS Lambda detecta los datos en la capa Clear y ejecuta un proceso de carga hacia SQL Database mediante scripts predefinidos, automatizando la carga que anteriormente era manual.

* **📂 Ver Código:** [Lambda_to_sql](./Code/Lambda_to_sql)

![Carga SQL](Img/4_Carga%20(LambdaSQL).png)

### Carga y Normalización (Capa SQL)

Una segunda AWS Lambda detecta los datos en la capa Clear y ejecuta un proceso de carga hacia SQL Database mediante scripts predefinidos, automatizando la carga que anteriormente era manual.

* **📂 Ver Código:** [Lambda_to_sql](https://www.google.com/search?q=./Code/Lambda_to_sql)
* **🖼️ Ver Imagen:** [4_Carga (LambdaSQL).png](https://www.google.com/search?q=Img/4_Carga%2520(LambdaSQL).png)
