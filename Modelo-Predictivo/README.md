# 📦 Stock Intelligence Engine 

Este proyecto implementa un **motor inteligente de decisiones para inventario** cuyo objetivo principal es responder tres preguntas clave del negocio:

* **¿Cuándo tengo que comprar?**
* **¿Qué productos representan mayor riesgo si no compro?**
* **¿Cuánta plata puedo perder si el stock se quiebra?**

A diferencia de un modelo tradicional de predicción de ventas, este motor no intenta adivinar el futuro del mercado. En cambio, utiliza datos reales de consumo, stock y tiempos de entrega para anticipar riesgos operativos y financieros relacionados con el inventario.

En pocas palabras:
👉 No predice cuánto se va a vender.
👉 Predice **cuándo una decisión de compra se vuelve crítica para evitar pérdidas**.

---

## 🎯 Objetivo del modelo

El motor transforma datos operativos en decisiones accionables para el área de compras y abastecimiento:

* Detecta productos con riesgo de quiebre de stock.
* Calcula días de cobertura según consumo histórico.
* Estima unidades que podrían perderse si el producto se queda sin stock.
* Traduce ese riesgo a **impacto económico estimado**.
* Prioriza qué comprar primero según importancia del producto y pérdida potencial.

Esto permite pasar de una gestión reactiva del inventario a una estrategia basada en datos.

---

## ⚙️ ¿Cómo funciona a nivel conceptual?

El modelo cruza información de:

* Inventarios iniciales y finales.
* Consumo histórico.
* Clasificación ABC.
* Tiempos de entrega de proveedores.
* Métricas económicas del producto.

A partir de esto calcula:

* Cuántos días dura el stock actual.
* Si el proveedor llega antes o después de que el producto se agote.
* Cuántos días de quiebre podrían ocurrir.
* Cuántas unidades y dinero podrían perderse.

El resultado final es una recomendación clara:

* **COMPRAR YA** → Existe riesgo real de perder ventas o ingresos.
* **OK** → El stock actual es suficiente.

---

## 🧩 ¿Por qué se eligió un modelo no entrenado?

Se optó por un enfoque determinístico y transparente por varias razones:

* No contamos con datos históricos limpios para entrenar modelos complejos.
* Las decisiones de compra requieren explicabilidad.
* El negocio necesita respuestas claras y rápidas, no predicciones abstractas.

Este motor funciona como un **sistema de inteligencia operativa**, donde cada cálculo tiene una lógica visible y auditable.

---

## 🤝 ¿Por qué trabajar a nivel Producto–Proveedor (Brand–Vendor)?

El modelo está diseñado sobre la relación producto–proveedor porque:

* Permite escalar fácilmente si una marca empieza a trabajar con más de un proveedor.
* Facilita comparar tiempos de entrega y riesgo operativo entre proveedores.
* Prepara la estructura para análisis futuros de negociación o optimización de abastecimiento.

Aunque hoy muchos productos tengan un solo proveedor, el diseño ya contempla escenarios más complejos sin necesidad de rehacer el modelo.

---

## 💼 ¿Qué beneficios aporta a la empresa?

✔ Reduce pérdidas por quiebres de stock.
✔ Prioriza compras basadas en impacto económico real.
✔ Permite anticipar riesgos antes de que ocurran.
✔ Mejora la planificación sin depender de estimaciones manuales.
✔ Genera outputs listos para dashboards y reporting ejecutivo.

En lugar de comprar por intuición, el equipo puede enfocarse en productos que realmente afectan ingresos.

---

## 📊 Resultados del motor

El sistema genera dos salidas principales:

* **Top productos en riesgo**: lista priorizada para decisiones operativas.
* **Impacto financiero por proveedor**: vista estratégica para análisis de abastecimiento.

Estas salidas están pensadas para integrarse directamente en herramientas de visualización como Power BI.

---

## 🔮 Posibles mejoras futuras

Este proyecto fue diseñado para ser funcional y claro, pero puede evolucionar en varias direcciones:

* Incorporar ventas reales para reemplazar el consumo estimado por inventario.
* Ajustar el cálculo de consumo diario usando estacionalidad o tendencias.
* Separar el stock por proveedor cuando existan múltiples abastecedores por producto.
* Integrar datos de promociones o eventos comerciales.
* Automatizar actualizaciones periódicas del motor.
* Incorporar simulaciones de escenarios (“qué pasa si no compro hoy”).

Estas mejoras permitirían pasar de un motor operativo a un sistema aún más predictivo y estratégico.

---

## 🚀 Conclusión

Este proyecto no busca reemplazar la planificación humana, sino potenciarla.

El motor convierte datos dispersos en señales claras:

👉 qué comprar
👉 cuándo comprar
👉 cuánto riesgo financiero existe si no se hace

Es una herramienta diseñada para tomar decisiones más inteligentes con el inventario, priorizando impacto real sobre complejidad innecesaria.

