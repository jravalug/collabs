# Diccionario de Datos

Archivo: `data_analisis.csv`
Filas: 136
Columnas: 53
Generado: 2026-06-09 15:41:37

## Dimensiones

| Dimensión | Ítems | Invertidos |
|---|---|---|
| A: Desempeño y Estrategias | a_01–a_03 | — |
| B: Presupuestación Financiera | b_01–b_07 | — |
| C: Institucionalización | c_01–c_05 | — |
| D: Controles de Riesgos | d_01–d_03 | — |
| E: Prácticas de Ventas | e_01–e_07 | — |
| F: Finanzas Internas | f_01–f_06 | f_01, f_02, f_03, f_05 |
| G: Negociación Financiera | g_01–g_03 | — |
| H: Recursos Humanos | h_01–h_03 | — |
| I: Ventajas Competitivas | i_01–i_02 | — |
| J: Mejores Prácticas E. Familiares | j_01–j_04 | — |

## Variables

| Variable | Tipo | Valores | Descripción | Escala | Notas |
|---|---|---|---|---|---|
| `tamano_empresa` | str | Pequeña \| Mediana | Tamaño de la empresa | Nominal |  |
| `anos_permanencia` | str | 1-5 \| 6-10 \| 11-15 \| 16-20 \| 21-30 \| 31-40 \| 41+ | Años de permanencia en el mercado | Ordinal |  |
| `responsabilidad` | str | Dueño \| Administrador | Responsabilidad o función que realiza | Nominal |  |
| `edad` | int | 19-48 | Edad del encuestado | Razón |  |
| `sexo` | str | Masculino \| Femenino | Sexo del encuestado | Nominal |  |
| `escolaridad` | str | Preparatoria \| Técnica \| Universitaria \| Postgraduada | Nivel de escolaridad | Ordinal | Universataria→Universitaria |
| `a_01` | int | 1-5 | A.1 ¿Posee su plan de negocios? | Likert | Dim: Desempeño y Estrategias |
| `a_02` | int | 1-5 | A.2 ¿Revisa y adecua periódicamente su plan de negocios? | Likert |  |
| `a_03` | int | 1-5 | A.3 ¿Conocen todos los que trabajan el mismo? | Likert |  |
| `b_01` | int | 1-5 | B.1 ¿Realiza proyección de ingresos, gastos y utilidades? | Likert | Dim: Presupuestación Financiera |
| `b_02` | int | 1-5 | B.2 ¿Revisa esta proyección? | Likert |  |
| `b_03` | int | 1-5 | B.3 ¿Proyección mensual? | Likert |  |
| `b_04` | int | 1-5 | B.4 ¿Proyección trimestral? | Likert |  |
| `b_05` | int | 1-5 | B.5 ¿Proyección semestral? | Likert |  |
| `b_06` | int | 1-5 | B.6 ¿Elabora planes de medidas? | Likert |  |
| `b_07` | int | 1-5 | B.7 ¿Analiza el cumplimiento de planes de medidas? | Likert |  |
| `c_01` | int | 1-5 | C.1 ¿Están definidas responsabilidades y roles? | Likert | Dim: Institucionalización |
| `c_02` | int | 1-5 | C.2 ¿Tiene instructivos y manuales? | Likert |  |
| `c_03` | int | 1-5 | C.3 ¿Está definida la estructura empresarial? | Likert |  |
| `c_04` | int | 1-5 | C.4 ¿Estructura delimita responsabilidades y autoridad? | Likert |  |
| `c_05` | int | 1-5 | C.5 ¿Existe separación de funciones? | Likert |  |
| `d_01` | int | 1-5 | D.1 ¿Riesgos identificados? | Likert | Dim: Controles de Riesgos |
| `d_02` | int | 1-5 | D.2 ¿Riesgos jerarquizados por importancia? | Likert |  |
| `d_03` | int | 1-5 | D.3 ¿Medidas para mitigar riesgos? | Likert |  |
| `e_01` | int | 1-5 | E.1 ¿Plan comercial? | Likert | Dim: Prácticas de Ventas |
| `e_02` | int | 1-5 | E.2 ¿Caracterización de clientes? | Likert |  |
| `e_03` | int | 1-5 | E.3 ¿Productos estrella? | Likert |  |
| `e_04` | int | 1-5 | E.4 ¿Identificación de competidores? | Likert |  |
| `e_05` | int | 1-5 | E.5 ¿Promoción de productos? | Likert |  |
| `e_06` | int | 1-5 | E.6 ¿Canales digitales? | Likert |  |
| `e_07` | int | 1-5 | E.7 ¿Alianzas comerciales? | Likert |  |
| `g_01` | int | 1-5 | G.1 ¿Negocia financiamiento a menor costo? | Likert | Dim: Negociación Financiera |
| `g_02` | int | 1-5 | G.2 ¿Negocia reestructuración de deudas? | Likert |  |
| `g_03` | int | 1-5 | G.3 ¿Flujos financieros positivos? | Likert |  |
| `h_01` | int | 1-5 | H.1 ¿Capacitación al personal? | Likert | Dim: Recursos Humanos |
| `h_02` | int | 1-5 | H.2 ¿Motiva al personal? | Likert |  |
| `h_03` | int | 1-5 | H.3 ¿Pagos por resultados? | Likert |  |
| `f_01` | int | 1-5 | F.1 ¿Problemas de liquidez regularmente? | Likert | Dim: Finanzas Internas. Negativo→invertido |
| `f_02` | int | 1-5 | F.2 ¿Dificultades con capital de trabajo? | Likert | Negativo→invertido |
| `f_03` | int | 1-5 | F.3 ¿Problemas en rotación de inventarios? | Likert | Negativo→invertido |
| `f_04` | int | 1-5 | F.4 ¿Cobra con facilidad cuentas pendientes? | Likert | Positivo, sin invertir |
| `f_05` | int | 1-5 | F.5 ¿Dificultades para pagar proveedores? | Likert | Negativo→invertido |
| `f_06` | int | 1-5 | F.6 ¿Negociaciones con proveedores? | Likert | Positivo, sin invertir |
| `i_01` | int | 1-5 | I.1 ¿Revisa portafolio vs competencia? | Likert | Dim: Ventajas Competitivas |
| `i_02` | int | 1-5 | I.2 ¿Adecúa portafolio según revisión? | Likert |  |
| `j_01` | int | 1-5 | J.1 ¿Medidas para armonía familiar? | Likert | Dim: Mejores Prácticas Emp. Familiares |
| `j_02` | int | 1-5 | J.2 ¿Consejo familiar? | Likert |  |
| `j_03` | int | 1-5 | J.3 ¿Planes de sucesión? | Likert |  |
| `j_04` | int | 1-5 | J.4 ¿Capacitación a familiares? | Likert |  |
| `f_01_inv` | int | 1-5 | F.1 invertido (6 - valor original) | Likert | Item negativo recodificado |
| `f_02_inv` | int | 1-5 | F.2 invertido (6 - valor original) | Likert | Item negativo recodificado |
| `f_03_inv` | int | 1-5 | F.3 invertido (6 - valor original) | Likert | Item negativo recodificado |
| `f_05_inv` | int | 1-5 | F.5 invertido (6 - valor original) | Likert | Item negativo recodificado |

## Escala Likert

- 1 = No, nunca, mal
- 2 = Casi nunca, regular
- 3 = No sé, no tengo criterio
- 4 = Casi siempre, bien
- 5 = Sí, siempre, excelente

### Inversión de ítems negativos

Los ítems de la dimensión F (Finanzas Internas) que expresan un problema
se invierten: valor_inv = 6 - valor_original. Así, puntajes altos siempre
indican buen gobierno corporativo.