********************************************************************************
*                                                                              *
*  ANÁLISIS ESTADÍSTICO - EDUCACIÓN FINANCIERA EN ADOLESCENTES                 *
*  Autlán de Navarro, Jalisco                                                  *
*                                                                              *
*  Autor:        [Nombre del investigador]                                     *
*  Fecha:        2026-06-06                                                    *
*  Versión:      1.0                                                           *
*  Software:     IBM SPSS Statistics v.26 o superior                           *
*  Fuente datos: data_analisis.csv (656 casos, 30 variables)                  *
*  Encabezados:  UTF-8 con separador ';'                                      *
*                                                                              *
*  Ejecución:                                                                 *
*    1. Abrir SPSS                                                            *
*    2. Archivo > Abrir > Sintaxis...  (seleccionar este archivo .sps)         *
*    3. Ejecutar > Todo                                                       *
*    4. Los resultados aparecen en el Visor de SPSS                           *
*                                                                              *
*  Bloques:                                                                    *
*    1. Importación de datos                                                   *
*    2. Definición de variables y etiquetas                                   *
*    3. Recodificación de dicotómicas                                          *
*    4. Cálculo de puntajes compuestos                                         *
*    5. Estadística descriptiva                                                *
*    6. Consistencia interna - Alfa de Cronbach                                *
*    7. Test de Friedman (sustituye a W de Kendall)                            *
*    8. Prueba U de Mann-Whitney (dos colas)                                  *
*    9. Análisis de preferencias formativas (P18)                              *
*   10. Exportación de resultados                                              *
*                                                                              *
********************************************************************************.

********************************************************************************
* BLOQUE 1. IMPORTACIÓN DE DATOS
********************************************************************************.

GET DATA  /TYPE=TXT
  /FILE='data_analisis.csv'
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=";"
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /VARIABLES=
    nivel_educativo A
    nivel_agrupado A
    nombre_escuela A
    tipo_escuela A
    sexo A
    edad F
    grado F
    fecha_aplicacion A
    a_convivencia A
    b_vivienda A
    c_negocio_familiar A
    p01_has_escuchado_educacion_financiera F
    p02_conoces_significado_educacion_financiera F
    p03_te_gustaria_aprender_educacion_financiera F
    p04_consideras_importante_educacion_financiera F
    p05_definicion_educacion_financiera A
    p06_conoces_significado_ahorro F
    p07_tienes_cuenta_ahorro A
    p08_constante_responsable_ahorrar F
    p09_opinion_credito_banco_caja F
    p10_conoces_que_es_credito F
    p11_conoces_que_es_presupuesto F
    p12_conoces_tasa_interes F
    p13_comprendes_que_es_inversion F
    p14_entendes_inflacion F
    p15_entendes_devaluacion_dinero F
    p16_diferencias_tarjeta_credito_debito F
    p17_ahorras_fuera_instituciones A
    p18_como_gustarian_clases A
    p18_categoria A.
CACHE.
EXECUTE.

DISPLAY DICTIONARY /VARIABLES=nivel_agrupado sexo tipo_escuela.
DISPLAY NAMES.

********************************************************************************
* BLOQUE 2. DEFINICIÓN DE VARIABLES Y ETIQUETAS
********************************************************************************.

VARIABLE LABELS
  nivel_agrupado                  'Nivel educativo agrupado (Secundaria / Bachillerato)'
  sexo                            'Sexo del estudiante'
  tipo_escuela                    'Tipo de financiamiento de la escuela'
  p01_has_escuchado_educacion_financiera  'P01 - Ha escuchado sobre educación financiera'
  p02_conoces_significado_educacion_financiera  'P02 - Conoce el significado de educación financiera'
  p03_te_gustaria_aprender_educacion_financiera  'P03 - Le gustaría aprender educación financiera'
  p04_consideras_importante_educacion_financiera  'P04 - Considera importante la educación financiera'
  p05_definicion_educacion_financiera  'P05 - Definición que mejor describe la educación financiera'
  p06_conoces_significado_ahorro  'P06 - Conoce el significado de ahorro'
  p07_tienes_cuenta_ahorro        'P07 - Tiene cuenta de ahorro en banco o caja popular'
  p08_constante_responsable_ahorrar  'P08 - Es constante y responsable al ahorrar'
  p09_opinion_credito_banco_caja  'P09 - Opinión sobre sacar crédito en banco o caja popular'
  p10_conoces_que_es_credito      'P10 - Conoce qué es un crédito'
  p11_conoces_que_es_presupuesto  'P11 - Conoce qué es un presupuesto'
  p12_conoces_tasa_interes        'P12 - Conoce qué significa tasa de interés'
  p13_comprendes_que_es_inversion 'P13 - Comprende qué es una inversión'
  p14_entendes_inflacion          'P14 - Entiende el significado de inflación'
  p15_entendes_devaluacion_dinero 'P15 - Entiende el significado de devaluación'
  p16_diferencias_tarjeta_credito_debito  'P16 - Identifica diferencias entre tarjeta de crédito y débito'
  p17_ahorras_fuera_instituciones 'P17 - Ahorra fuera de instituciones financieras'
  p18_como_gustarian_clases       'P18 - Cómo le gustaría que fueran las clases de educación financiera'
  p18_categoria                   'P18 - Categoría agrupada de preferencias formativas'.

VALUE LABELS  nivel_agrupado
  1 'Secundaria'
  2 'Bachillerato'.

VALUE LABELS  sexo
  1 'Hombre'
  2 'Mujer'.

VALUE LABELS  tipo_escuela
  1 'Pública'
  2 'Privada'.

VALUE LABELS  /p01_has_escuchado_educacion_financiera
  p02_conoces_significado_educacion_financiera
  p03_te_gustaria_aprender_educacion_financiera
  p04_consideras_importante_educacion_financiera
  p06_conoces_significado_ahorro
  p08_constante_responsable_ahorrar
  p09_opinion_credito_banco_caja
  p10_conoces_que_es_credito
  p11_conoces_que_es_presupuesto
  p12_conoces_tasa_interes
  p13_comprendes_que_es_inversion
  p14_entendes_inflacion
  p15_entendes_devaluacion_dinero
  p16_diferencias_tarjeta_credito_debito
  1 'No, nunca / Muy malo'
  2 'Muy poco / Malo'
  3 'Algo / A veces'
  4 'Casi siempre / Bueno'
  5 'Sí, mucho / Muy bueno'.

VALUE LABELS  p07_tienes_cuenta_ahorro
  p17_ahorras_fuera_instituciones
  1 'Sí'
  2 'No'.

VALUE LABELS  a_convivencia
  1 'Padres'
  2 'Uno de ellos'
  3 'Otro familiar'.

VALUE LABELS  b_vivienda
  1 'Propia'
  2 'Rentada'
  3 'Prestada'.

VALUE LABELS  c_negocio_familiar
  1 'Sí'
  2 'No'.

VALUE LABELS  p18_categoria
  1 'Interactivas'
  2 'Con expertos'
  3 'Explicaciones claras'
  4 'Con práctica'
  5 'En equipo'
  6 'Ahorro / inversión'
  7 'Otro'.

EXECUTE.

********************************************************************************
* BLOQUE 3. RECODIFICACIÓN DE DICOTÓMICAS A 0/1
*   p07_rec y p17_rec se usan en el cálculo del puntaje de Comportamiento
********************************************************************************.

RECODE p07_tienes_cuenta_ahorro  (1=1) (2=0) INTO p07_rec.
RECODE p17_ahorras_fuera_instituciones (1=1) (2=0) INTO p17_rec.
VARIABLE LABELS  p07_rec  'P07 recodificada (1=Sí, 0=No)'
                /p17_rec 'P17 recodificada (1=Sí, 0=No)'.
EXECUTE.

********************************************************************************
* BLOQUE 4. CÁLCULO DE PUNTAJES COMPUESTOS
*   - Conocimiento: media de 8 ítems Likert (rango 1.00-5.00)
*   - Actitud:      media de 4 ítems Likert (rango 1.00-5.00)
*   - Comportamiento: compuesto normalizado (rango 0.00-1.00)
*   Nota: MEAN ignora los casos con valores perdidos por defecto.
********************************************************************************.

COMPUTE puntaje_conocimiento = MEAN(
    p06_conoces_significado_ahorro,
    p10_conoces_que_es_credito,
    p11_conoces_que_es_presupuesto,
    p12_conoces_tasa_interes,
    p13_comprendes_que_es_inversion,
    p14_entendes_inflacion,
    p15_entendes_devaluacion_dinero,
    p16_diferencias_tarjeta_credito_debito).
COMPUTE puntaje_actitud = MEAN(
    p01_has_escuchado_educacion_financiera,
    p02_conoces_significado_educacion_financiera,
    p03_te_gustaria_aprender_educacion_financiera,
    p04_consideras_importante_educacion_financiera).
COMPUTE puntaje_comportamiento =
    (p07_rec + (p08_constante_responsable_ahorrar / 5) + p17_rec) / 3.

VARIABLE LABELS
  puntaje_conocimiento     'Puntaje compuesto - Conocimiento financiero (1-5)'
  puntaje_actitud          'Puntaje compuesto - Actitud hacia EF (1-5)'
  puntaje_comportamiento   'Puntaje compuesto - Comportamiento financiero (0-1)'.

EXECUTE.

DESCRIPTIVES VARIABLES=puntaje_conocimiento puntaje_actitud puntaje_comportamiento
  /STATISTICS=MEAN STDDEV MIN MAX.

********************************************************************************
* BLOQUE 5. ESTADÍSTICA DESCRIPTIVA
*   Frecuencias de todos los ítems + tablas cruzadas por nivel_agrupado
********************************************************************************.

FREQUENCIES VARIABLES=
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p03_te_gustaria_aprender_educacion_financiera
    p04_consideras_importante_educacion_financiera
    p05_definicion_educacion_financiera
    p06_conoces_significado_ahorro
    p07_tienes_cuenta_ahorro
    p08_constante_responsable_ahorrar
    p09_opinion_credito_banco_caja
    p10_conoces_que_es_credito
    p11_conoces_que_es_presupuesto
    p12_conoces_tasa_interes
    p13_comprendes_que_es_inversion
    p14_entendes_inflacion
    p15_entendes_devaluacion_dinero
    p16_diferencias_tarjeta_credito_debito
    p17_ahorras_fuera_instituciones
    p18_categoria
  /ORDER=ANALYSIS
  /STATISTICS=MODE
  /FORMAT=LIMIT(40).

CROSSTABS /TABLES=nivel_agrupado BY sexo tipo_escuela
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT COLUMN.

CROSSTABS /TABLES=nivel_agrupado BY
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p06_conoces_significado_ahorro
    p07_tienes_cuenta_ahorro
    p10_conoces_que_es_credito
    p17_ahorras_fuera_instituciones
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT COLUMN.

********************************************************************************
* BLOQUE 6. CONSISTENCIA INTERNA - ALFA DE CRONBACH
*   Umbral de aceptación: α ≥ 0.70 (Tavakol & Dennick, 2011)
********************************************************************************.

* --- Alfa global: 14 ítems Likert ---.
RELIABILITY
  /VARIABLES=
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p03_te_gustaria_aprender_educacion_financiera
    p04_consideras_importante_educacion_financiera
    p06_conoces_significado_ahorro
    p08_constante_responsable_ahorrar
    p09_opinion_credito_banco_caja
    p10_conoces_que_es_credito
    p11_conoces_que_es_presupuesto
    p12_conoces_tasa_interes
    p13_comprendes_que_es_inversion
    p14_entendes_inflacion
    p15_entendes_devaluacion_dinero
    p16_diferencias_tarjeta_credito_debito
  /SCALE('Cronbach Global - 14 Likert') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL MEANS VARIANCE.

* --- Subescala Conocimiento: 8 ítems ---.
RELIABILITY
  /VARIABLES=
    p06_conoces_significado_ahorro
    p10_conoces_que_es_credito
    p11_conoces_que_es_presupuesto
    p12_conoces_tasa_interes
    p13_comprendes_que_es_inversion
    p14_entendes_inflacion
    p15_entendes_devaluacion_dinero
    p16_diferencias_tarjeta_credito_debito
  /SCALE('Conocimiento - 8 items') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Subescala Actitud: 4 ítems ---.
RELIABILITY
  /VARIABLES=
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p03_te_gustaria_aprender_educacion_financiera
    p04_consideras_importante_educacion_financiera
  /SCALE('Actitud - 4 items') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

********************************************************************************
* BLOQUE 7. TEST DE FRIEDMAN
*   Sustituye a W de Kendall (no aplicable: 1 respondedor por estudiante).
*   Evalúa si los 14 ítems Likert tienen distribuciones similares dentro
*   de cada respondedor, por separado para cada nivel educativo.
********************************************************************************.

* --- Friedman: Secundaria (nivel_agrupado = 1) ---.
NPAR TESTS
  /FRIEDMAN=
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p03_te_gustaria_aprender_educacion_financiera
    p04_consideras_importante_educacion_financiera
    p06_conoces_significado_ahorro
    p08_constante_responsable_ahorrar
    p09_opinion_credito_banco_caja
    p10_conoces_que_es_credito
    p11_conoces_que_es_presupuesto
    p12_conoces_tasa_interes
    p13_comprendes_que_es_inversion
    p14_entendes_inflacion
    p15_entendes_devaluacion_dinero
    p16_diferencias_tarjeta_credito_debito
    WITH nivel_agrupado(1)
  /MISSING ANALYSIS.

* --- Friedman: Bachillerato (nivel_agrupado = 2) ---.
NPAR TESTS
  /FRIEDMAN=
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p03_te_gustaria_aprender_educacion_financiera
    p04_consideras_importante_educacion_financiera
    p06_conoces_significado_ahorro
    p08_constante_responsable_ahorrar
    p09_opinion_credito_banco_caja
    p10_conoces_que_es_credito
    p11_conoces_que_es_presupuesto
    p12_conoces_tasa_interes
    p13_comprendes_que_es_inversion
    p14_entendes_inflacion
    p15_entendes_devaluacion_dinero
    p16_diferencias_tarjeta_credito_debito
    WITH nivel_agrupado(2)
  /MISSING ANALYSIS.

********************************************************************************
* BLOQUE 8. PRUEBA U DE MANN-WHITNEY (DOS COLAS)
*   Comparación de los 3 puntajes compuestos entre niveles educativos.
*   H0: las distribuciones son iguales entre Secundaria y Bachillerato.
*   H1: las distribuciones difieren entre los dos grupos.
*   α = 0.05; prueba de dos colas (conservadora, defendible).
********************************************************************************.

NPAR TESTS
  /M-W= puntaje_conocimiento puntaje_actitud puntaje_comportamiento BY nivel_agrupado(1 2)
  /MISSING ANALYSIS
  /STATISTICS=DESCRIPTIVES.

********************************************************************************
* BLOQUE 9. ANÁLISIS DE PREFERENCIAS FORMATIVAS (P18)
*   Frecuencias de p18_categoria (7 grupos) y listado verbatim.
********************************************************************************.

FREQUENCIES VARIABLES=p18_categoria
  /ORDER=ANALYSIS
  /STATISTICS=MODE.

* Listado verbatim de P18 con su frecuencia.
FREQUENCIES VARIABLES=p18_como_gustarian_clases
  /ORDER=ANALYSIS
  /FORMAT=LIMIT(100).

********************************************************************************
* BLOQUE 10. EXPORTACIÓN DE RESULTADOS
*   Genera un archivo .spv con todos los resultados del análisis.
*   Modificar la ruta si se desea guardar en otra ubicación.
********************************************************************************.

OUTPUT EXPORT
  /CONTENTS EXPORT=VISIBLE
  /FORMAT=PDF
  /OUTFILE='resultados_analisis.pdf'.

* --- Fin del script ---.

FINISH.
