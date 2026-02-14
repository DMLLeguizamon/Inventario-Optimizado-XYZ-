# 🛠️ Ingeniería de Datos: De la Auditoría a la Automatización

Este repositorio documenta el ciclo de vida de los datos para un sistema de gestión de inventarios, abarcando desde el diagnóstico técnico hasta la implementación de una arquitectura de datos escalable.

## 🔍 1. Auditoría Técnica (Python)
El proyecto inicia con la auditoría de 6 datasets. Utilizando Pandas, se realizó un diagnóstico para identificar cuellos de botella antes de la migración a la nube.

Diagnóstico: Se detectó que las columnas de fechas (como startDate, SalesDate, InvoiceDate, etc.) estaban tipificadas como object (texto).

Decisión Estratégica: En lugar de realizar una limpieza manual, se optó por documentar estas necesidades para automatizarlas mediante un proceso de ETL, garantizando que el sistema sea capaz de procesar nuevas cargas de datos sin intervención humana.

## 📥 Acceso a los Datos
Debido a la alta volumetría de los registros, los archivos originales pueden descargarse para auditoría externa en el siguiente enlace:
https://www.kaggle.com/datasets/bhanupratapbiswas/inventory-analysis-case-study
