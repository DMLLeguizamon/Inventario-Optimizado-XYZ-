# 📦 EDA Estratégico de Inventario y Abastecimiento

Este EDA transforma datos operativos (compras, inventario, tiendas y proveedores) en **decisiones de negocio**. El objetivo es responder preguntas concretas como:

* 💰 ¿Dónde se está **inmovilizando capital** (working capital) en inventario?
* 🅰️🅱️🅾️ ¿Qué productos sostienen el negocio (ABC) y cuáles aportan poco pero “consumen” recursos?
* ⚠️ ¿Hay señales de **quiebres**, **sobrestock** o mala asignación entre tiendas?
* 🚚 ¿Cómo se comporta la logística (lead time) y qué tan dependiente es el negocio de ciertos proveedores?

El resultado final es un diagnóstico accionable para **optimizar compras**, **mejorar liquidez** y **reducir riesgo operativo** sin perder revenue.

---

# 🧭 Menú

* [📅 Alcance del período y magnitud del sistema](#alcance-del-periodo-y-magnitud-del-sistema)
* [🧩 Metodología](#metodologia)
* [💵 Hallazgos estratégicos](#hallazgos-estrategicos)
* [✅ Decisiones que habilita este EDA](#decisiones-que-habilita-este-eda)
* [🏢 ¿Por qué es valioso para la empresa?](#por-que-es-valioso-para-la-empresa)
* [⚠️ Limitaciones](#limitaciones)
* [🚀 Posibles mejoras](#posibles-mejoras)

---

## 1) 📅 Alcance del período y magnitud del sistema

El análisis cubre aproximadamente **375 días** (01/01/2016 → 10/01/2017) y dimensiona la operación:

* 🧾 **Productos (SKUs):** 12.261
* 🏬 **Sucursales:** 79–80
* 🛒 **Ventas del período:** 2.451.169 unidades | USD 33.139.375,29
* 📦 **Inventario al cierre:** 4.885.776 unidades | **USD 55.429.569,00** en capital inmovilizado

Esto confirma por qué el inventario es un problema financiero real: hay **más capital en stock** que facturación anual del período analizado.

---

## 2) 🧩 Metodología (en simple)

El EDA se organiza en bloques estratégicos, cada uno construye una parte del diagnóstico:

### Bloque 2 — 🔄 Demanda implícita (sin depender solo de ventas)

En lugar de estimar demanda por ventas, se reconstruye el consumo real del sistema con una lógica contable:

**Consumo = Stock Inicial + Compras − Stock Final**

Resultado clave:

* ✅ No aparecen consumos negativos (consistencia contable).
* 💤 Se detecta una porción del catálogo con consumo cero (productos sin rotación).

---

### Bloque 3 — 🅰️🅱️🅾️ Clasificación ABC (prioridad económica real)

Se estima un **revenue implícito** por SKU:

**Revenue implícito = Consumo × Precio representativo**

Hallazgo estructural (Pareto):

* 🏆 Un porcentaje chico del portafolio (A) sostiene la mayor parte del negocio.
* 🧱 La mayoría (C) tiene impacto marginal.

---

### Bloque 4 — ⚙️ Rotación (eficiencia del inventario)

Se mide qué tan rápido “se convierte en liquidez” el stock:

* Rotación = Consumo / InventarioPromedio
* Días en inventario ≈ 365 / Rotación

Hallazgos:

* 🟢 **Categoría A:** rotación alta, días en inventario bajos (más eficiencia).
* 🟠 **Categoría C:** rotación baja, días en inventario muy altos (capital lento).

---

### Bloque 5 — 🧯 Salud del inventario (riesgo operativo real)

Responde:

* 📉 ¿Perdemos ventas por quiebre?
* 📦 ¿Hay sobrestock?
* 🏬 ¿Las tiendas están balanceadas?

Hallazgos clave:

* ⚠️ **Quiebre operativo:** 1.939 productos (16,86%) con demanda pero stock final 0.

  * 🧾 Impacto: se concentra en productos **C** (bajo impacto económico), por eso el daño a revenue total no es masivo.
* ✅ **Sobrestock extremo:** prácticamente inexistente (solo 1 caso con el criterio definido).
* 🚨 **Riesgo crítico (alto consumo y stock 0):** 52 productos (0,45%).

  * 🧠 Aquí aparecen más A/B → son pocos, pero importantes.
* 🧭 **Tiendas:** la mayoría está equilibrada; los desbalances son puntuales (6 y 6 tiendas en cuadrantes problemáticos).

---

### Bloque 6 — 🚚 Lead time y abastecimiento (riesgo logístico)

Se mide:

* 📆 Lead time promedio por proveedor (PODate → ReceivingDate).
* 📉 Homogeneidad / dispersión.
* 🔗 Dependencia por producto.

Hallazgos fuertes:

* 🧾 **126 proveedores** analizados.
* ⏱️ Lead time típico concentrado en **7–8 días** (sistema homogéneo).
* 🧩 Clasificación: 118 moderados, 5 lentos, 3 rápidos.
* 🧷 **Dependencia alta:** 10.635 productos dependen de un solo proveedor (exclusivos) y solo 29 son “compartidos”.

Traducción a negocio: no hay caos logístico, pero sí **baja redundancia** (riesgo si un proveedor falla).

---

## 3) 💵 Hallazgos estratégicos (con números financieros)

El inventario como capital.

### 3.1 💰 Capital inmovilizado total

* 💵 Capital total inmovilizado (stock valorizado): **USD 55.293.243,91**
* 🧾 Productos valorizables: 9.289
* 🚫 Productos sin costo: 1.176 (excluidos para no distorsionar)

### 3.2 🅰️🅱️🅾️ Distribución del capital por ABC

El capital sigue la lógica del negocio (lo importante concentra inversión):

* 🅰️ **Categoría A:** **63,83%** del capital → ~**USD 35,3M**
* 🅱️ **Categoría B:** **20,65%** → ~**USD 11,42M**
* 🅾️ **Categoría C:** **15,51%** → ~**USD 8,58M**

Interpretación: no es “malo” que A concentre capital; es coherente. El foco está en **qué parte de ese capital vuelve lento**.

### 3.3 🐢 Capital lento (baja rotación)

* 🎯 Umbral: **Rotación ≤ 3**
* 💸 Capital asociado a baja rotación: **USD 17.205.540,44**
* 📌 Participación: **31,12% del capital total**

Esto es el punto más importante: **~1/3 del capital está tardando demasiado en volver a liquidez**.

### 3.4 🅾️🐢 Capital lento dentro de categoría C

* 💸 Capital lento en C: **USD 6.891.428,77**
* 📌 Participación sobre capital total: **12,46%**

Traducción: el “capital lento” no vive solo en C. Hay oportunidades en C, sí, pero también hay capital lento fuera de C.

### 3.5 🏬 Concentración por sucursal

* 🧲 **41 de 80 sucursales** concentran el **80% del capital**.

No es necesariamente un problema: puede reflejar tamaño/ubicación. Pero sirve para priorizar control y auditoría.

---

## 4) ✅ ¿Qué decisiones habilita este EDA?

### 🛍️ Decisiones de compra (sin aumentar gasto total)

* 📉 Reducir progresivamente compras en **C de baja rotación** con capital relevante.
  Beneficios: libera capital, baja permanencia, mejora eficiencia financiera.

### 🎯 Control táctico (sin reestructurar todo)

* 🔎 Monitoreo reforzado para **A y B** en casos puntuales de riesgo crítico (stock 0 con alta demanda).
* 🧭 Ajustes finos en tiendas desbalanceadas:

  * 📈 Alta demanda + bajo stock → riesgo de quiebre
  * 📉 Baja demanda + alto stock → oportunidad financiera

### 🤝 Gestión de proveedores

* ⏱️ El lead time es estable, pero la exclusividad por producto es alta → mejora posible: **redundancia** o planes alternativos para SKUs críticos.

---

## 5) 🏢 ¿Por qué este enfoque es valioso para la empresa?

Porque convierte inventario en una lectura de **working capital**:

* 💰 Permite ver **dónde se inmoviliza dinero**.
* 🧠 Distingue lo importante (A/B) de lo accesorio (C).
* 📏 Reduce decisiones “a ojo” y reemplaza por criterios cuantitativos:

  * rotación,
  * cobertura,
  * quiebre,
  * capital lento,
  * concentración por tienda/proveedor.

---

## 6) ⚠️ Limitaciones (claras y honestas)

* 🔄 La “demanda” se reconstruye por **movimiento de inventario** (consumo implícito).
  Puede absorber pérdidas/roturas/ajustes de stock como si fueran consumo (esto se considera en “mejoras”).
* 💲 Algunos productos no tienen costo representativo → no se valorizan.
* ✂️ Los outliers se recortan solo para visualización (no para modificar resultados).

---

## 7) 🚀 Posibles mejoras (no técnicas, orientadas a negocio)

1. 🧾 **Separar consumo real vs merma/ajustes**
   Incorporar una variable de shrinkage (rotura, pérdida, vencimiento) para no inflar consumo.

2. 🎛️ **Políticas de reabastecimiento por criticidad**
   Definir reglas distintas para A/B/C (frecuencia, cobertura objetivo, mínimos).

3. 🐢💸 **Optimización de capital lento (31,12%)**
   Crear un plan de reducción gradual para productos lentos:

   * bajar frecuencia de compra,
   * consolidar pedidos,
   * racionalizar surtido C de baja rotación.

4. 🔁 **Rebalanceo entre sucursales**
   Si existe movilidad interna, sugerir transferencias entre tiendas (antes de comprar más).

5. 🧷 **Redundancia de proveedores para SKUs críticos**
   Priorizar productos A/B con proveedor exclusivo y construir alternativas (si el negocio lo permite).


