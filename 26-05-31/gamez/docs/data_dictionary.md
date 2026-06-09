# Diccionario de Datos

Archivo: `data/processed/data_analisis.csv`  
Filas: 656  
Columnas: 30  
Generado: 2026-06-06 13:46:34

## Tabla de variables

| Variable | Tipo | Valores validos | Pregunta / descripcion | Escala | Notas |
|---|---|---|---|---|---|
| `nivel_educativo` | str | Secundaria \| Telesecundaria \| Preparatoria | Nivel educativo del estudiante | Nominal |  |
| `nivel_agrupado` | str | Secundaria \| Bachillerato | Nivel agrupado (secundaria+telesecundaria vs preparatoria) para Mann-Whitney U | Nominal | Derivada de nivel_educativo |
| `nombre_escuela` | str | 13 escuelas | Nombre de la escuela (no del alumno) | Nominal |  |
| `tipo_escuela` | str | Publica \| Privada | Tipo de financiamiento | Nominal |  |
| `sexo` | str | Hombre \| Mujer | Sexo del estudiante | Nominal | 1 vacio |
| `edad` | int | 12-51 | Edad en anos | Razon | Outlier 51 conservado por decision del usuario |
| `grado` | int | 1-6 | Grado escolar. En secundaria/telesecundaria: 1-3. En preparatoria: 1-6 | Ordinal | 3B en secundaria reparado a 3 |
| `fecha_aplicacion` | str | DD/MM/YYYY | Fecha de aplicacion del cuestionario | Fecha | Formato D/M/Y; 6/3/2025 (outlier 3/1/1900 reemplazado por la moda de su escuela, 13/14 registros) |
| `a_convivencia` | str | Padres \| Uno de ellos \| Otro familiar | Con quien vive el estudiante | Nominal | 1 vacio |
| `b_vivienda` | str | Propia \| Rentada \| Prestada | Tipo de tenencia de la vivienda | Nominal |  |
| `c_negocio_familiar` | str | Si \| No | La familia tiene negocio o empresa | Dicotomica | Reinterpretado: 1->Si, 5->No |
| `p01_has_escuchado_educacion_financiera` | int | 1-5 | Has escuchado hablar de Educacion Financiera? | Likert | 1=No, nunca 5=Si, mucho |
| `p02_conoces_significado_educacion_financiera` | int | 1-5 | Conoces que significa Educacion Financiera? | Likert |  |
| `p03_te_gustaria_aprender_educacion_financiera` | int | 1-5 | Te gustaria aprender diversos temas de Educacion Financiera? | Likert |  |
| `p04_consideras_importante_educacion_financiera` | int | 1-5 | Consideras que es importante y necesaria la Educacion Financiera? | Likert |  |
| `p05_definicion_educacion_financiera` | str | a) ... \| b) ... \| c) Ninguna \| d) No se | Cual de las definiciones describe mejor la Educacion Financiera | Nominal |  |
| `p06_conoces_significado_ahorro` | int | 1-5 | Sabes que significa ahorro? | Likert | Outlier 54 -> NaN |
| `p07_tienes_cuenta_ahorro` | str | Si \| No | Tienes cuenta de ahorro en algun banco o Caja Popular? | Dicotomica |  |
| `p08_constante_responsable_ahorrar` | int | 1-5 | Eres constante y responsable al ahorrar? | Likert |  |
| `p09_opinion_credito_banco_caja` | int | 1-5 | Consideras que sacar un credito en un banco o Caja Popular es? | Likert |  |
| `p10_conoces_que_es_credito` | int | 1-5 | Sabes lo que es un credito? | Likert |  |
| `p11_conoces_que_es_presupuesto` | int | 1-5 | Sabes lo que es un presupuesto? | Likert | Outlier 42 -> NaN |
| `p12_conoces_tasa_interes` | int | 1-5 | Conoces que significa tasa de interes? | Likert | Outlier 55 -> NaN |
| `p13_comprendes_que_es_inversion` | int | 1-5 | Comprendes que es una inversion? | Likert |  |
| `p14_entendes_inflacion` | int | 1-5 | Entiendes el significado de la palabra inflacion? | Likert | Outlier 23 -> NaN |
| `p15_entendes_devaluacion_dinero` | int | 1-5 | Entiendes el significado de devaluacion del dinero? | Likert |  |
| `p16_diferencias_tarjeta_credito_debito` | int | 1-5 | Identificas las diferencias entre una tarjeta de credito y una de debito? | Likert |  |
| `p17_ahorras_fuera_instituciones` | str | Si \| No | Ahorras fuera de las instituciones financieras (alcancía)? | Dicotomica |  |
| `p18_como_gustarian_clases` | str | 34 categorias verbatim | Como te gustaria que fueran las clases de educacion financiera? | Texto libre | Caracteres acentuados perdidos en fuente original |
| `p18_categoria` | str | 7 grupos | Categoria agrupada de p18 para analisis cuantitativo | Nominal | Derivada: Interactivas \| Con expertos \| Explicaciones claras \| Con practica \| En equipo \| Ahorro/inversion \| Otro |

## Escalas

### Likert (1-5)
- 1 = No, nunca, muy malo
- 2 = Muy poco, casi nunca, malo
- 3 = Algo, a veces
- 4 = Casi siempre, bueno
- 5 = Si, mucho, siempre, muy bueno

### Dicotomica
- Si / No

## Categorias de p18_categoria

| Grupo | Descripcion |
|---|---|
| Interactivas | Videos, juegos, dinamicas, interactivas, en linea, divertidas |
| Con expertos | Expertos en el tema, talleres, cursos, tutoriales |
| Explicaciones claras | Explicacion, claras, didacticas, sencillas, exposiciones, lenguaje cotidiano |
| Con practica | Practicas, ejemplos, formularios, investigaciones, tareas |
| En equipo | Trabajos en equipo, propuestas, metas |
| Ahorro/inversion | Metodos de ahorro, inflacion, devaluacion |
| Otro | No se, sin comentarios, respuestas miscelaneas |

## Cambios respecto a `data/processed/data_normalizado.csv`

- 4 outliers Likert -> NaN (p06=54, p11=42, p12=55, p14=23)
- 1 reparacion: grado '3B' en secundaria -> grado=3
- 1 reemplazo: fecha 3/1/1900 -> 6/3/2025 (moda de escuela Salvador Esquer Apodaca)
- Columna `grupo` eliminada (no relevante para el estudio)
- Columna `nivel_agrupado` anadida (Secundaria vs Bachillerato)
- Columna `p18_categoria` anadida (7 grupos)
- Likert convertidas de string a int
- `edad` y `grado` convertidas a int donde aplica

## Trazabilidad

Ver `transformaciones_log.csv` (en esta misma carpeta `docs/`) para el detalle de cada modificacion.