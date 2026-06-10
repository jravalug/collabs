# Diccionario de Datos

Archivo: `respuestas.csv`
Filas: 15
Columnas: 23
Generado: 2026-06-09 21:55:28

## Dimensiones

| Dimensión | Ítems | Descripción |
|---|---|---|
| Satisfacción por el servicio recibido | sat_01, sat_02, sat_03, sat_04 | Satisfacción por el servicio recibido |
| Cualidades de los productos financieros | cual_01, cual_02, cual_03, cual_04 | Cualidades de los productos financieros |
| Programas de recompensas | recom_01, recom_02, recom_03, recom_04 | Programas de recompensas |
| Beneficios de obra social | obra_01, obra_02, obra_03, obra_04 | Beneficios de obra social |
| Capital social | cs_01, cs_02 | Capital social |

## Variables

| Variable | Tipo | Valores | Descripción | Escala | Notas |
|---|---|---|---|---|---|
| `Marca_temporal` | str | Fecha/hora | Marca de tiempo de la respuesta | Nominal |  |
| `Sexo` | str | Femenino \| Masculino | Sexo del encuestado | Nominal |  |
| `Edad` | int | 41-58 | Edad del encuestado en años | Razón | Normalizada a entero |
| `Escolaridad` | str | Universitaria \| Maestría | Nivel educativo máximo | Nominal | Normalizada sin paréntesis |
| `Antiguedad_funcionario` | int | 12-28 | Años de experiencia como funcionario | Razón | Normalizada a entero |
| `sat_01` | int | 1-5 | Calidad de la atención al socio | Likert | Dim: Satisfacción por el servicio recibido |
| `sat_02` | int | 1-5 | Rapidez en la prestación de servicios | Likert | Dim: Satisfacción por el servicio recibido |
| `sat_03` | int | 1-5 | Solución de problemas | Likert | Dim: Satisfacción por el servicio recibido |
| `sat_04` | int | 1-5 | Profesionalismo del personal | Likert | Dim: Satisfacción por el servicio recibido |
| `cual_01` | int | 1-5 | Accesibilidad | Likert | Dim: Cualidades de los productos financieros |
| `cual_02` | int | 1-5 | Competitividad | Likert | Dim: Cualidades de los productos financieros |
| `cual_03` | int | 1-5 | Diversidad de productos | Likert | Dim: Cualidades de los productos financieros |
| `cual_04` | int | 1-5 | Flexibilidad de condiciones | Likert | Dim: Cualidades de los productos financieros |
| `recom_01` | int | 1-5 | Incentivos económicos | Likert | Dim: Programas de recompensas |
| `recom_02` | int | 1-5 | Beneficios preferenciales | Likert | Dim: Programas de recompensas |
| `recom_03` | int | 1-5 | Reconocimientos | Likert | Dim: Programas de recompensas |
| `recom_04` | int | 1-5 | Programas de fidelización | Likert | Dim: Programas de recompensas |
| `obra_01` | int | 1-5 | Apoyo educativo | Likert | Dim: Beneficios de obra social |
| `obra_02` | int | 1-5 | Programas comunitarios | Likert | Dim: Beneficios de obra social |
| `obra_03` | int | 1-5 | Actividades sociales | Likert | Dim: Beneficios de obra social |
| `obra_04` | int | 1-5 | Responsabilidad social cooperativa | Likert | Dim: Beneficios de obra social |
| `cs_01` | int | 1-5 | Disposición para incrementar aportaciones de los socios | Likert | Dim: Capital social |
| `cs_02` | int | 1-5 | Permanencia y crecimiento de socios | Likert | Dim: Capital social |

## Escala Likert

- 1 = Totalmente en desacuerdo
- 2 = En desacuerdo
- 3 = Ni de acuerdo ni en desacuerdo
- 4 = De acuerdo
- 5 = Totalmente de acuerdo

### Notas

- Todos los ítems están redactados en sentido positivo; no se requirió inversión.
- Edad y Antigüedad se normalizaron eliminando sufijos textuales ("años", "AÑOS").
- Escolaridad se normalizó extrayendo la categoría base antes del primer paréntesis.