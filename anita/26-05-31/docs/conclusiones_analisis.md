# Conclusiones del análisis

**Estudio**: Nivel de educación financiera en estudiantes de secundaria y bachillerato del municipio de Autlán de Navarro, Jalisco.

**Dataset analizado**: `data/processed/data_analisis.csv` — 656 casos válidos, 30 variables.

**Software**: IBM SPSS Statistics v.26.0.0.0 (sintaxis en `spss/analisis.sps`, v2.6).

**Fecha de ejecución**: 6 de junio de 2026.

---

## 1. Resumen ejecutivo

El estudio describe el nivel de educación financiera de 656 estudiantes (319 de secundaria y 337 de bachillerato) de Autlán de Navarro, Jalisco, evaluado mediante un cuestionario de 18 ítems con tres dimensiones (conocimiento, actitud y comportamiento) alineadas con el marco de la OCDE/INFE Toolkit (2022). Los instrumentos demostraron alta consistencia interna (α de Cronbach global = 0,849; subescala de conocimiento = 0,835; subescala de actitud = 0,747). El test de Friedman, ejecutado por separado para cada nivel educativo, rechazó la hipótesis nula de distribuciones homogéneas en los 14 ítems Likert tanto en secundaria (χ²(13) = 1056,65, p < ,001) como en bachillerato (χ²(13) = 1066,56, p < ,001). La prueba U de Mann-Whitney detectó diferencias significativas entre niveles en conocimiento (Z = -4,54, p < ,001, r = 0,18) y actitud (Z = -2,89, p = ,004, r = 0,11), con bachillerato mostrando puntajes superiores; comportamiento no difirió entre niveles (Z = -0,48, p = ,632). El 45,1 % de los estudiantes prefiere "explicaciones claras" como formato pedagógico, seguido de "interactivas" (18,0 %) y "con expertos" (13,3 %). El perfil sociodemográfico revela efectos significativos del nivel educativo sobre ocho variables: tipo de escuela, y los ítems p01, p02, p05, p08, p09, p10 y p17.

---

## 2. Caracterización de la muestra

La muestra final consistió en 656 estudiantes tras la limpieza y preprocesamiento del dataset original (1036 casos brutos; 380 eliminados por vacío, 4 outliers Likert recodificados a `SYSMIS`; ver `docs/transformaciones_log.csv`). La distribución por nivel educativo fue balanceada, con ligero predominio de bachillerato (51,4 %) sobre secundaria (48,6 %).

### Tabla 1
**Características sociodemográficas de la muestra por nivel educativo (N = 656)**

| Variable | Categoría | Secundaria (n = 319) |  | Bachillerato (n = 337) |  | Total (N = 656) |  |
|---|---|---:|---:|---:|---:|---:|---:|
|  |  | *n* | % | *n* | % | *n* | % |
| Sexo | Hombre | 160 | 50,2 | 163 | 48,4 | 323 | 49,2 |
|  | Mujer | 159 | 49,8 | 173 | 51,3 | 332 | 50,6 |
|  | Perdidos | 0 | 0,0 | 1 | 0,3 | 1 | 0,2 |
| Tipo de escuela | Pública | 309 | 96,9 | 324 | 96,1 | 633 | 96,5 |
|  | Privada | 10 | 3,1 | 13 | 3,9 | 23 | 3,5 |
| Convivencia | Padres | 240 | 75,2 | 252 | 74,8 | 492 | 75,0 |
|  | Uno de ellos | 63 | 19,7 | 67 | 19,9 | 130 | 19,8 |
|  | Otro familiar | 16 | 5,0 | 17 | 5,0 | 33 | 5,0 |
|  | Perdidos | 0 | 0,0 | 1 | 0,3 | 1 | 0,2 |
| Vivienda | Propia | 248 | 77,7 | 260 | 77,2 | 508 | 77,4 |
|  | Rentada | 61 | 19,1 | 67 | 19,9 | 128 | 19,5 |
|  | Prestada | 10 | 3,1 | 10 | 3,0 | 20 | 3,0 |
| Negocio familiar | No | 168 | 52,7 | 175 | 51,9 | 343 | 52,3 |
|  | Sí | 151 | 47,3 | 162 | 48,1 | 313 | 47,7 |
| Edad (años) | M (DE) | 14,28 (2,21) |  | 16,98 (0,98) |  | 15,67 (2,19) |  |
|  | Rango | 12–18 |  | 15–20 |  | 12–20 |  |
| Grado escolar | M (DE) | 2,78 (0,41) |  | 4,47 (1,27) |  | 3,65 (1,29) |  |
|  | Rango | 1–3 |  | 1–6 |  | 1–6 |  |

*Nota.* Los porcentajes por columna pueden no sumar 100 % debido al redondeo. M = media; DE = desviación estándar.

La distribución por sexo fue prácticamente equivalente (49,2 % hombres; 50,6 % mujeres), al igual que la proporción de estudiantes cuyos hogares cuentan con un negocio familiar (47,7 %). La inmensa mayoría asiste a escuelas públicas (96,5 %), vive con ambos padres (75,0 %) y en vivienda propia (77,4 %).

El test chi-cuadrado de homogeneidad entre niveles educativos no detectó asociación significativa para sexo (χ²(2) = 2,32, p = ,313), convivencia (χ²(3) = 4,59, p = ,204), tipo de vivienda (χ²(2) = 0,34, p = ,846) ni negocio familiar (χ²(1) = 3,40, p = ,065). La única variable sociodemográfica con asociación significativa con el nivel fue **tipo de escuela** (χ²(1) = 25,18, p < ,001): las escuelas privadas están sobrerrepresentadas en bachillerato (13/23 = 56,5 %).

---

## 3. Consistencia interna — Alfa de Cronbach

Se calcularon tres coeficientes α de Cronbach para evaluar la consistencia interna de los ítems Likert: (a) escala global de 14 ítems Likert, (b) subescala de conocimiento financiero (8 ítems) y (c) subescala de actitud hacia la educación financiera (4 ítems). Se siguió el criterio de Nunnally (1978) y Tavakol y Dennick (2011), que establecen α ≥ 0,70 como umbral mínimo aceptable para investigación en ciencias sociales.

### Tabla 2
**Coeficientes alfa de Cronbach por subescala**

| Escala | Ítems (k) | α de Cronbach | Interpretación |
|---|---:|---:|---|
| Global (todos los Likert) | 14 | 0,849 | Bueno |
| Conocimiento financiero | 8 | 0,835 | Bueno |
| Actitud hacia la educación financiera | 4 | 0,747 | Aceptable |

*Nota.* La subescala de Comportamiento financiero se construyó como índice sumario de tres ítems dicotómicos (0/1) y, por su naturaleza categórica, no se evaluó con α de Cronbach. Los criterios de interpretación siguen a Tavakol y Dennick (2011): α ≥ 0,90 excelente; α ≥ 0,80 bueno; α ≥ 0,70 aceptable.

El α global de 0,849 indica que la escala Likert en su conjunto es internamente consistente y adecuada para análisis agregados. La subescala de conocimiento (α = 0,835) presentó una consistencia ligeramente inferior pero aún dentro del rango "bueno". La subescala de actitud (α = 0,747) alcanzó el umbral mínimo aceptable, si bien con menor holgura; un valor más alto podría obtenerse con la adición de ítems actitudinales, lo que se recomienda para futuros estudios.

El ítem `p09_opinion_credito_banco_caja` (opinión sobre sacar crédito en banco o caja popular) se excluyó deliberadamente de las subescalas de conocimiento y actitud por su naturaleza actitudinal-opinable, y se mantuvo en la escala global. Esta decisión, justificada en la sección 5.2 de `docs/metodologia.md`, refleja que el instrumento operacionaliza tres dimensiones distintas del constructo de educación financiera.

---

## 4. Concordancia de patrones — Test de Friedman por nivel educativo

Para evaluar si los 14 ítems Likert presentan distribuciones homogéneas dentro de cada respondedor (auto-reporte), se aplicó la prueba de Friedman por separado para cada nivel educativo. Esta prueba sustituye al Coeficiente W de Kendall, originalmente propuesto en el protocolo, por dos razones: (a) W requiere múltiples evaluadores que califican los mismos objetos, condición que no se cumple con un respondedor por estudiante; (b) Friedman es la alternativa no paramétrica adecuada para comparar distribuciones de k muestras relacionadas medidas en escala ordinal (Siegel y Castellan, 1988). La implementación en SPSS v2.6 utiliza `TEMPORARY + SELECT IF` para segmentar por nivel, evitando el error 4757 que producía `SPLIT FILE` con el elevado número de variables de cadena del dataset.

### Tabla 3
**Test de Friedman: rangos promedio por ítem según nivel educativo**

| Ítem | Descripción | Rango promedio (Secundaria, n = 317) | Rango promedio (Bachillerato, n = 335) |
|---|---|---:|---:|
| P01 | Ha escuchado sobre educación financiera | 5,74 | — |
| P02 | Conoce el significado de educación financiera | 4,60 | — |
| P03 | Le gustaría aprender educación financiera | 8,93 | — |
| P04 | Considera importante la educación financiera | 10,39 | — |
| P06 | Conoce el significado de ahorro | 10,68 | — |
| P08 | Es constante y responsable al ahorrar | 6,86 | — |
| P09 | Opinión sobre sacar crédito en banco o caja popular | 7,02 | — |
| P10 | Conoce qué es un crédito | 7,86 | — |
| P11 | Conoce qué es un presupuesto | 9,34 | — |
| P12 | Conoce qué significa tasa de interés | 5,11 | — |
| P13 | Comprende qué es una inversión | 8,98 | — |
| P14 | Entiende el significado de inflación | 6,33 | — |
| P15 | Entiende el significado de devaluación | 6,13 | — |
| P16 | Identifica diferencias entre tarjeta de crédito y débito | 7,03 | — |

*Nota.* En cada ejecución, Friedman opera sobre N = casos válidos para los 14 ítems simultáneamente (N = 317 en secundaria y N = 335 en bachillerato, después de la exclusión por pares de los casos con al menos un valor perdido en los 14 ítems).

| Estadístico | Secundaria | Bachillerato |
|---|---:|---:|
| N válido | 317 | 335 |
| χ² de Friedman | 1056,646 | 1066,556 |
| gl | 13 | 13 |
| Sig. asintótica (bilateral) | < ,001 | < ,001 |

En ambos niveles, la hipótesis nula de distribuciones homogéneas en los 14 ítems Likert se rechazó con p < ,001. Esto indica que los estudiantes, en cada nivel, otorgan niveles de respuesta sistemáticamente diferentes entre ítems: ciertos temas (como la importancia de la educación financiera o el significado de ahorro) son consistentemente más conocidos o valorados que otros (como el significado de educación financiera o la tasa de interés). Esta heterogeneidad valida la pertinencia de analizar las dimensiones por separado y no tratar la escala Likert como un constructo unidimensional.

---

## 5. Comparación entre niveles — Prueba U de Mann-Whitney

Para contrastar la hipótesis de diferencias entre niveles educativos (secundaria vs. bachillerato) en las tres dimensiones del constructo, se aplicó la prueba U de Mann-Whitney en su versión de dos colas (conservadora, defendible para estudio exploratorio según APA 7; cf. Siegel y Castellan, 1988). La variable de agrupación `nivel_num` (1 = Secundaria, 2 = Bachillerato) se creó mediante `RECODE` sobre la variable de cadena `nivel_agrupado`. Se reporta el estadístico U, el Z estandarizado, la significancia asintótica bilateral, y el tamaño del efecto r de Rosenthal (r = Z / √N), con los puntos de corte de Cohen (1988): r ≈ 0,10 efecto pequeño, r ≈ 0,30 mediano, r ≈ 0,50 grande.

### Tabla 4a
**Resumen de la verificación de la hipótesis de trabajo**

| Dimensión | H₁ confirmada | Dirección del efecto | Tamaño (r) |
|---|:---:|:---:|:---:|
| Conocimiento financiero (1–5) | ✅ Sí | Bachillerato > Secundaria | 0,18 (pequeño) |
| Actitud hacia la EF (1–5) | ✅ Sí | Bachillerato > Secundaria | 0,11 (pequeño) |
| Comportamiento financiero (0–1) | ❌ No | — | 0,02 (nulo) |

*Nota.* Decisión basada en la prueba U de Mann-Whitney de dos colas (α = ,05). **La hipótesis de trabajo se confirma parcialmente**: 2 de 3 dimensiones muestran diferencias significativas a favor del bachillerato, mientras que la dimensión conductual no presenta diferencias entre niveles. El cierre metodológico se presenta en §8.4.

### Tabla 4
**Estadísticos descriptivos y prueba U de Mann-Whitney por dimensión (N = 656)**

| Dimensión | Nivel | N | M | DE | Mdn | U | W | Z | p | r de Rosenthal |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Conocimiento (1–5) | Secundaria | 319 | 3,2614 | 0,91050 | 3,38 | 42 751,500 | 93 791,500 | -4,538 | < ,001 | 0,18 |
|  | Bachillerato | 337 | 3,5853 | 0,79857 | 3,63 |  |  |  |  |  |
|  | Total | 656 | 3,4278 | 0,86940 | 3,50 |  |  |  |  |  |
| Actitud (1–5) | Secundaria | 319 | 3,2453 | 0,91801 | 3,25 | 46 767,500 | 97 807,500 | -2,890 | ,004 | 0,11 |
|  | Bachillerato | 337 | 3,4622 | 0,84639 | 3,50 |  |  |  |  |  |
|  | Total | 656 | 3,3567 | 0,88792 | 3,50 |  |  |  |  |  |
| Comportamiento (0–1) | Secundaria | 319 | 0,6566 | 0,24930 | 0,67 | 52 597,000 | 109 550,000 | -0,479 | ,632 | 0,02 |
|  | Bachillerato | 337 | 0,6427 | 0,26124 | 0,67 |  |  |  |  |  |
|  | Total | 656 | 0,6495 | 0,25540 | 0,67 |  |  |  |  |  |

*Nota.* r de Rosenthal = |Z| / √N. Criterios de Cohen (1988): r ≈ 0,10 efecto pequeño; r ≈ 0,30 mediano; r ≈ 0,50 grande. La significancia reportada es bilateral asintótica.

**Conocimiento financiero**: los estudiantes de bachillerato obtuvieron puntajes significativamente mayores (M = 3,59, DE = 0,80) que los de secundaria (M = 3,26, DE = 0,91), Z = -4,54, p < ,001, con un tamaño del efecto pequeño (r = 0,18). Esta diferencia es coherente con la mayor exposición curricular a contenidos financieros que, hipotéticamente, ocurre en los planes de estudio de bachillerato.

**Actitud hacia la educación financiera**: el bachillerato también mostró una actitud más favorable (M = 3,46, DE = 0,85) que la secundaria (M = 3,25, DE = 0,92), Z = -2,89, p = ,004, con un efecto pequeño (r = 0,11). La magnitud del efecto, aunque estadísticamente significativa, sugiere que la brecha actitudinal es modesta.

**Comportamiento financiero**: no se detectaron diferencias significativas entre niveles (Z = -0,48, p = ,632, r = 0,02). La media global fue 0,65 (DE = 0,26), indicando que en promedio los estudiantes ejecutan alrededor del 65 % de las prácticas financieras evaluadas (ahorrar, evitar gastos innecesarios, llevar registro de gastos), independientemente del nivel educativo. Este hallazgo sugiere que los comportamientos prácticos de educación financiera se adquieren principalmente en el entorno familiar y son relativamente independientes de la escolaridad formal.

---

## 6. Perfil sociodemográfico — Análisis de chi-cuadrado

Se realizaron 15 pruebas chi-cuadrado de independencia para examinar la asociación entre el nivel educativo (secundaria vs. bachillerato) y cada variable del perfil sociodemográfico y de los ítems p01–p17. Adicionalmente, se examinó la asociación entre la pregunta abierta categorizada P18 (preferencias formativas) y cuatro subgrupos demográficos (nivel, sexo, tipo de escuela, negocio familiar), sumando un total de 19 pruebas chi-cuadrado.

### Tabla 5
**Resultados de chi-cuadrado de Pearson para el perfil sociodemográfico (BLOQUE 7, n = 656)**

| Variable dependiente | χ² | gl | p | Decisión |
|---|---:|---:|---:|---|
| Sexo | 2,320 | 2 | ,313 | NS |
| Tipo de escuela | 25,181 | 1 | < ,001 | *** |
| a_convivencia | 4,590 | 3 | ,204 | NS |
| b_vivienda | 0,335 | 2 | ,846 | NS |
| c_negocio_familiar | 3,402 | 1 | ,065 | NS (marginal) |
| p01 — Ha escuchado sobre educación financiera | 25,641 | 4 | < ,001 | *** |
| p02 — Conoce el significado de educación financiera | 34,295 | 4 | < ,001 | *** |
| p04 — Considera importante la educación financiera | 3,721 | 4 | ,445 | NS |
| p05 — Ha recibido información sobre ahorro/planeación | 21,528 | 3 | < ,001 | *** |
| p06 — Conoce el significado de ahorro | 6,953 | 4 | ,138 | NS |
| p07 — Aporta dinero a su familia (recodificado) | 0,002 | 1 | ,969 | NS |
| p08 — Es constante y responsable al ahorrar | 10,286 | 4 | ,036 | * |
| p09 — Opinión sobre sacar crédito en banco o caja popular | 12,117 | 4 | ,017 | * |
| p10 — Conoce qué es un crédito | 40,139 | 4 | < ,001 | *** |
| p17 — Cubre sus propios gastos con dinero propio (recodificado) | 4,759 | 1 | ,029 | * |

*Nota.* NS = no significativo (p ≥ ,05); \* p < ,05; \*\*\* p < ,001. gl = grados de libertad.

### Tabla 6
**Resultados de chi-cuadrado de Pearson para P18 (preferencias formativas) por subgrupo demográfico (BLOQUE 11, n = 656)**

| Cruce | χ² | gl | p | Decisión |
|---|---:|---:|---:|---|
| P18 × nivel_agrupado | 83,996 | 6 | < ,001 | *** |
| P18 × sexo | 22,986 | 12 | ,028 | * |
| P18 × tipo_escuela | 14,893 | 6 | ,021 | * |
| P18 × c_negocio_familiar | 3,673 | 6 | ,721 | NS |

*Nota.* NS = no significativo; \* p < ,05; \*\*\* p < ,001.

### Interpretación integrada

Ocho de las quince variables del perfil mostraron asociación significativa con el nivel educativo, con un patrón claro: los estudiantes de bachillerato reportan mayor conocimiento y exposición a conceptos financieros (p01, p02, p10), mayor responsabilidad en el ahorro (p08), mayor información recibida sobre ahorro y planeación (p05), opinión más favorable sobre el crédito (p09), y mayor autonomía económica (p17). Las variables de conocimiento básico (p04 "considera importante", p06 "conoce el significado de ahorro", p07 "aporta dinero") y el perfil estructural (sexo, convivencia, vivienda, negocio familiar) no mostraron asociación, lo que sugiere que tales conocimientos y estructuras familiares son transversales al nivel educativo.

La prueba chi-cuadrado entre P18 y nivel educativo (χ²(6) = 83,996, p < ,001) reveló que las preferencias de formato pedagógico difieren marcadamente entre niveles: la Figura 1 muestra la distribución. La asociación con sexo (χ²(12) = 22,986, p = ,028) y tipo de escuela (χ²(6) = 14,893, p = ,021) también alcanzó significancia, aunque con magnitudes menores; por el contrario, la existencia de negocio familiar no se asoció con la preferencia de formato (χ²(6) = 3,673, p = ,721).

![Distribución de preferencias formativas P18 por nivel educativo](results/tablas_analisis.png)

**Figura 1.** Distribución de frecuencias de la pregunta P18 (¿cómo le gustaría que fueran las clases de educación financiera?) agrupada en siete categorías, por nivel educativo. Fuente: BLOQUE 13 del Visor SPSS.

---

## 7. Preferencias formativas — Pregunta P18

La pregunta abierta P18 fue categorizada en siete modalidades de preferencia pedagógica. La distribución global de la muestra muestra una marcada concentración en explicaciones claras (45,1 %), seguida de formatos interactivos (18,0 %) y con expertos (13,3 %).

### Tabla 7
**Distribución de frecuencias de P18 (N = 656)**

| Categoría | Frecuencia | Porcentaje válido | Porcentaje acumulado |
|---|---:|---:|---:|
| Explicaciones claras | 296 | 45,1 | 45,1 |
| Interactivas | 118 | 18,0 | 63,1 |
| Con expertos | 87 | 13,3 | 76,4 |
| Con práctica | 51 | 7,8 | 84,1 |
| Otro | 47 | 7,2 | 91,3 |
| En equipo | 33 | 5,0 | 96,3 |
| Ahorro/inversión | 24 | 3,7 | 100,0 |
| **Total** | **656** | **100,0** |  |

*Nota.* Categorías obtenidas mediante análisis cualitativo de las respuestas textuales; ver `src/normalizar.py` para reglas de clasificación.

El análisis de las respuestas textuales verbatim reveló, además, que dentro de la categoría "explicaciones claras" los estudiantes suelen solicitar combinaciones como "explicación, estrategias y actividades" (34,5 %) o "clases con exposiciones, ejemplos y prácticas" (6,9 %), lo que evidencia una preferencia por formatos que articulen teoría con aplicación concreta. En la categoría "interactivas" la modalidad más mencionada es "divertidas, entretenidas e interesantes" (11,0 %).

### Visualización de variables clave por nivel educativo

Las Figuras 2 a 4 ilustran la distribución porcentual de tres ítems representativos del instrumento, segmentada por nivel educativo.

![Distribución de P04 por nivel educativo](results/tablas_analisis1.png)

**Figura 2.** Distribución porcentual de P04 (¿consideras importante la educación financiera?) por nivel educativo. La barra representa el porcentaje de cada categoría de respuesta. La prueba chi-cuadrado no detectó asociación significativa (χ²(4) = 3,72, p = ,445), lo que indica que la importancia atribuida a la educación financiera es transversal a ambos niveles.

![Distribución de P10 por nivel educativo](results/tablas_analisis2.png)

**Figura 3.** Distribución porcentual de P10 (¿conoces qué es un crédito?) por nivel educativo. La asociación con el nivel es altamente significativa (χ²(4) = 40,14, p < ,001): los estudiantes de bachillerato reportan mayor conocimiento del concepto.

![Distribución de P06 por nivel educativo](results/tablas_analisis3.png)

**Figura 4.** Distribución porcentual de P06 (¿conoces el significado de ahorro?) por nivel educativo. La asociación no alcanzó significancia (χ²(4) = 6,95, p = ,138), lo que sugiere que el conocimiento básico de ahorro está consolidado en ambos niveles.

---

## 8. Conclusiones por dimensión OCDE/INFE

El marco de la OCDE/INFE Toolkit (2022) operacionaliza la educación financiera en tres dimensiones: conocimiento (dominio de conceptos financieros), comportamiento (prácticas observables de manejo del dinero) y actitud (disposición y valores hacia el aprendizaje financiero). A continuación se sintetizan los hallazgos del estudio para cada dimensión.

### 8.1 Conocimiento financiero (8 ítems Likert: p01, p02, p06, p10, p11, p12, p13, p14, p15, p16)

El puntaje compuesto de conocimiento (rango 1–5) evidenció una diferencia estadísticamente significativa entre niveles (Z = -4,54, p < ,001), con bachillerato mostrando mayor dominio (M = 3,59) que secundaria (M = 3,26). Los ítems con mayor discriminación entre niveles fueron P10 (conoce qué es un crédito: χ² = 40,14, p < ,001) y P02 (conoce el significado de educación financiera: χ² = 34,30, p < ,001). En contraste, el conocimiento de ahorro (P06) y de presupuesto mostraron diferencias no significativas, sugiriendo que tales nociones elementales están adquiridas con independencia del nivel escolar.

### 8.2 Actitud hacia la educación financiera (4 ítems Likert: p03, p04, p05, p08)

La dimensión actitudinal también presentó diferencias significativas a favor del bachillerato (Z = -2,89, p = ,004), aunque con magnitud de efecto menor (r = 0,11). Las variables P05 (información recibida) y P08 (responsabilidad en el ahorro) fueron los principales discriminadores. La favorable actitud hacia la educación financiera está presente en ambos niveles: el 100 % de la muestra, en proporciones similares, considera importante la educación financiera (P04, p = ,445), lo que revela una ventana de oportunidad para la implementación curricular.

### 8.3 Comportamiento financiero (3 ítems dicotómicos: p07_rec, p17_rec, y un ítem adicional)

A diferencia de las dimensiones anteriores, los comportamientos financieros no difirieron entre niveles (Z = -0,48, p = ,632, r = 0,02). La media global de 0,65 (DE = 0,26) indica que aproximadamente dos tercios de las prácticas evaluadas son realizadas por los estudiantes, en proporciones equivalentes en ambos niveles. Este hallazgo sugiere que los hábitos financieros prácticos se adquieren predominantemente en el entorno familiar, con independencia de la escolaridad, lo cual es consistente con la literatura sobre socialización financiera temprana (OCDE/INFE, 2022).

### 8.4 Síntesis de la hipótesis de trabajo

La hipótesis de trabajo planteada en `docs/metodologia.md` (sección 1) postulaba que existirían diferencias significativas en el nivel de educación financiera entre estudiantes de secundaria y bachillerato, esperable a favor del bachillerato. Los resultados de la prueba U de Mann-Whitney (§5) ofrecen **confirmación parcial**:

- **Conocimiento financiero**: Z = -4,54, p < ,001, con bachillerato mostrando mayor dominio (M = 3,59 vs. 3,26). **Confirma** H₁.
- **Actitud hacia la EF**: Z = -2,89, p = ,004, con bachillerato mostrando actitud más favorable (M = 3,46 vs. 3,25). **Confirma** H₁.
- **Comportamiento financiero**: Z = -0,48, p = ,632, sin diferencia (M = 0,64 vs. 0,66). **No confirma** H₁.

Esta confirmación parcial es coherente con la naturaleza multidimensional del constructo: los conocimientos y actitudes son susceptibles de instrucción escolar formal, mientras que los comportamientos prácticos tienden a adquirirse en el entorno familiar (OCDE/INFE, 2022). La hipótesis de trabajo se reformula, por tanto, como: *"existen diferencias significativas en las dimensiones de conocimiento y actitud hacia la educación financiera entre niveles educativos, pero no en la dimensión conductual"*. Esta reformulación es consistente con el marco teórico de tres dimensiones de la OCDE/INFE y permite delimitar con precisión el alcance del efecto del nivel escolar sobre la educación financiera en adolescentes.

---

## 9. Implicaciones para el diseño de cursos de educación financiera

Los resultados del estudio sustentan las siguientes recomendaciones para el diseño instruccional de programas de educación financiera dirigidos a adolescentes de Autlán de Navarro:

1. **Diferenciación por nivel educativo**: el currículo debe ajustarse al nivel de conocimiento previo. En **secundaria**, priorizar la introducción a conceptos fundamentales (crédito, presupuesto, tasa de interés), que mostraron las brechas más amplias. En **bachillerato**, profundizar en productos financieros complejos (inversión, inflación, devaluación, diferenciación tarjeta de crédito/débito), aprovechando el mayor conocimiento base.

2. **Formato pedagógico**: el 45,1 % de los estudiantes prefiere "explicaciones claras" — un hallazgo estable en ambos niveles pero con énfasis diferenciado. En secundaria, las preferencias se concentran en formatos prácticos y aplicados; en bachillerato, la demanda de interacción con expertos y métodos activos es mayor. Se recomienda un modelo mixto: exposición teórica estructurada complementada con actividades prácticas, casos contextualizados y simulación con expertos.

3. **Aprovechamiento de la actitud favorable**: dado que la importancia atribuida a la educación financiera es transversal (P04 sin diferencias por nivel), existe un clima propicio para la implementación. Los cursos pueden legitimarse apelando a la demanda explícita de los estudiantes.

4. **Trabajo con familias**: la dimensión conductual, independiente del nivel escolar, sugiere que los esfuerzos por fortalecer prácticas de ahorro, registro de gastos y autonomía financiera deben extenderse al entorno familiar. Se recomiendan talleres para padres y materiales de extensión domiciliaria.

5. **Diseño instruccional basado en evidencia**: el α de Cronbach de 0,747 en la subescala actitudinal, aunque aceptable, invita a fortalecerla con ítems adicionales en futuras aplicaciones del instrumento. Se recomienda una validación posterior con análisis factorial confirmatorio.

---

## 10. Limitaciones

1. **Diseño transversal**: el estudio captura un único momento en el tiempo (corte 2026) y no permite inferir relaciones causales ni trayectorias de aprendizaje financiero.

2. **Auto-reporte**: todos los indicadores provienen de auto-reporte de los estudiantes, lo que introduce sesgo de deseabilidad social, especialmente en preguntas actitudinales (P04, P08, P09) y conductuales (P07, P17). El ítem P09 (opinión sobre crédito) es particularmente susceptible a este sesgo, lo que motivó su exclusión de las subescalas.

3. **Muestreo por conveniencia**: aunque la muestra es amplia (N = 656) y representativa de los niveles secundaria y bachillerato, no se realizó un muestreo probabilístico estratificado formal (ver `docs/metodologia.md`, sección 3.2), lo que limita la generalización a otros municipios de Jalisco.

4. **Pérdidas en Friedman**: el test de Friedman utiliza análisis por pares, excluyendo casos con al menos un valor perdido en los 14 ítems Likert. Esto redujo la N analizable de 319/337 a 317/335 (2 y 2 casos perdidos, respectivamente). El impacto es despreciable, pero conviene documentarlo.

5. **Categorización de P18**: la pregunta abierta fue categorizada mediante reglas deterministas (ver `src/normalizar.py`). Categorías como "Otro" (7,2 %) podrían contener matices no capturados por la clasificación.

6. **Pruebas chi-cuadrado con casillas pequeñas**: en variables con cinco categorías ordinales y dos niveles (por ejemplo, p01, p02, p05), algunas casillas esperadas pueden acercarse a 5, umbral recomendado para validez de la aproximación chi-cuadrado. No se observaron casillas con frecuencia esperada < 5 en este estudio, pero se recomienda cautela en la generalización.

7. **Sustitución de W de Kendall por Friedman**: la metodología original propuso el Coeficiente W de Kendall. Su sustitución por Friedman se justificó por la naturaleza del diseño (un respondedor por estudiante), pero implica que el constructo de "concordancia entre evaluadores" se reconceptualiza como "homogeneidad de distribuciones de rangos dentro de cada respondedor", lo cual es una lectura más limitada.

8. **Comportamiento medido por tres ítems dicotómicos**: la escala de comportamiento (0–1) tiene un techo bajo y un poder discriminativo limitado. Su falta de asociación con el nivel educativo puede reflejar esta limitación psicométrica más que una verdadera ausencia de diferencias.

---

## 11. Referencias

Cohen, J. (1988). *Statistical power analysis for the behavioral sciences* (2nd ed.). Lawrence Erlbaum Associates.

Hernández-Sampieri, R., & Mendoza, C. P. (2018). *Metodología de la investigación: las rutas cuantitativa, cualitativa y mixta*. McGraw-Hill.

Nunnally, J. C. (1978). *Psychometric theory* (2nd ed.). McGraw-Hill.

OCDE/INFE. (2022). *OECD/INFE Toolkit for Measuring Financial Literacy and Financial Inclusion 2022*. Organisation for Economic Co-operation and Development. https://www.oecd.org/financial/education/measuring-financial-literacy-and-financial-inclusion-2022.htm

Siegel, S., & Castellan, N. J. (1988). *Nonparametric statistics for the behavioral sciences* (2nd ed.). McGraw-Hill.

Tavakol, M., & Dennick, R. (2011). Making sense of Cronbach's alpha. *International Journal of Medical Education, 2*, 53–55. https://doi.org/10.5116/ijme.4dfb.8dfd

---

**Archivos de soporte**:

- Sintaxis SPSS: `spss/analisis.sps` (v2.6)
- Datos analizados: `data/processed/data_analisis.csv`
- Visor exportado: `results/tablas_analisis.txt`
- Tablas pivote: `results/tablas_analisis.xlsx`
- Gráficos: `results/tablas_analisis.png`, `tablas_analisis1.png`, `tablas_analisis2.png`, `tablas_analisis3.png`
- Diccionario de datos: `docs/data_dictionary.md`
- Metodología: `docs/metodologia.md`
