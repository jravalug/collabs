********************************************************************************
*                                                                              *
*  ANÁLISIS ESTADÍSTICO - FACTORES ASOCIADOS AL FORTALECIMIENTO               *
*  DEL CAPITAL SOCIAL EN SOCAPs                                               *
*                                                                              *
*  Fecha:        2026-06-09                                                    *
*  Versión:      1.0                                                           *
*  Software:     IBM SPSS Statistics v.26 o superior                           *
*  Fuente datos: respuestas.csv (15 casos, 23 variables)                      *
*  Encabezados:  UTF-8 con separador ','                                      *
*                                                                              *
*  Ejecución:                                                                  *
*    1. Abrir SPSS                                                             *
*    2. Archivo > Abrir > Sintaxis...                                          *
*    3. Ejecutar > Todo                                                        *
*    4. Los resultados aparecen en el Visor de SPSS                            *
*                                                                              *
*  Bloques (11 total):                                                         *
*    1.  Configuración de rutas                                                *
*    2.  Importación de datos                                                  *
*    3.  Definición de variables y etiquetas                                   *
*    4.  Cálculo de puntajes compuestos por dimensión                          *
*    5.  Frecuencias demográficas                                              *
*    6.  Frecuencias ítems Likert (con moda)                                   *
*    7.  Tablas descriptivas 9 columnas (frecuencias Likert)                   *
*    8.  Consistencia interna - Alfa de Cronbach                               *
*    9.  Concordancia - W de Kendall + Chi-cuadrado                            *
*   10.  Prueba de hipótesis para una muestra (t contra 3)                     *
*   11.  Correlaciones de Spearman                                             *
*   12.  Barras de frecuencia - todos los ítems                                *
*   13.  Verificación final                                                    *
*                                                                              *
********************************************************************************.

********************************************************************************
* BLOQUE 1. CONFIGURACIÓN DE RUTAS
*   Edita la ruta de abajo con la ubicación de tu carpeta "luz".
*   Usa DOBLES barras invertidas \\ en Windows.
********************************************************************************.

FILE HANDLE carpeta /NAME='D:\collabs\26-06-09\luz\data\processed\'.

********************************************************************************
* BLOQUE 2. IMPORTACIÓN DE DATOS
********************************************************************************.

GET DATA  /TYPE=TXT
  /FILE='carpeta\respuestas.csv'
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /VARIABLES=
    Marca_temporal A
    Sexo A
    Edad F
    Escolaridad A
    Antiguedad_funcionario F
    sat_01 F sat_02 F sat_03 F sat_04 F
    cual_01 F cual_02 F cual_03 F cual_04 F
    recom_01 F recom_02 F recom_03 F recom_04 F
    obra_01 F obra_02 F obra_03 F obra_04 F
    cs_01 F cs_02 F.
CACHE.
EXECUTE.

DISPLAY NAMES.

********************************************************************************
* BLOQUE 3. DEFINICIÓN DE VARIABLES Y ETIQUETAS
********************************************************************************.

VARIABLE LABELS
  Sexo                     'Sexo del encuestado'
  Edad                     'Edad del encuestado'
  Escolaridad              'Nivel de escolaridad'
  Antiguedad_funcionario   'Antiguedad como funcionario'
  sat_01                   'Calidad de la atencion al socio'
  sat_02                   'Rapidez en la prestacion de servicios'
  sat_03                   'Solucion de problemas'
  sat_04                   'Profesionalismo del personal'
  cual_01                  'Accesibilidad'
  cual_02                  'Competitividad'
  cual_03                  'Diversidad de productos'
  cual_04                  'Flexibilidad de condiciones'
  recom_01                 'Incentivos economicos'
  recom_02                 'Beneficios preferenciales'
  recom_03                 'Reconocimientos'
  recom_04                 'Programas de fidelizacion'
  obra_01                  'Apoyo educativo'
  obra_02                  'Programas comunitarios'
  obra_03                  'Actividades sociales'
  obra_04                  'Responsabilidad social cooperativa'
  cs_01                    'Disposicion para incrementar aportaciones'
  cs_02                    'Permanencia y crecimiento de socios'.

VALUE LABELS Sexo
  'Femenino' 'Femenino'
  'Masculino' 'Masculino'.

VALUE LABELS Escolaridad
  'Universitaria' 'Universitaria'
  'Maestría' 'Maestría'.

VALUE LABELS
  sat_01 sat_02 sat_03 sat_04
  cual_01 cual_02 cual_03 cual_04
  recom_01 recom_02 recom_03 recom_04
  obra_01 obra_02 obra_03 obra_04
  cs_01 cs_02
  1 'Totalmente en desacuerdo'
  2 'En desacuerdo'
  3 'Ni de acuerdo ni en desacuerdo'
  4 'De acuerdo'
  5 'Totalmente de acuerdo'.

VARIABLE LEVEL
  sat_01 sat_02 sat_03 sat_04
  cual_01 cual_02 cual_03 cual_04
  recom_01 recom_02 recom_03 recom_04
  obra_01 obra_02 obra_03 obra_04
  cs_01 cs_02 (ORDINAL).

EXECUTE.

********************************************************************************
* BLOQUE 4. CÁLCULO DE PUNTAJES COMPUESTOS POR DIMENSIÓN
*   Cada dimensión = media de sus ítems.
********************************************************************************.

* Satisfaccion por el servicio recibido (4 items).
COMPUTE SATISFACCION = MEAN(sat_01, sat_02, sat_03, sat_04).

* Cualidades de los productos financieros (4 items).
COMPUTE CUALIDADES = MEAN(cual_01, cual_02, cual_03, cual_04).

* Programas de recompensas (4 items).
COMPUTE RECOMPENSAS = MEAN(recom_01, recom_02, recom_03, recom_04).

* Beneficios de obra social (4 items).
COMPUTE OBRA_SOCIAL = MEAN(obra_01, obra_02, obra_03, obra_04).

* Capital social (2 items) - VARIABLE DEPENDIENTE.
COMPUTE CAPITAL_SOCIAL = MEAN(cs_01, cs_02).

VARIABLE LEVEL SATISFACCION CUALIDADES RECOMPENSAS OBRA_SOCIAL
  CAPITAL_SOCIAL (SCALE).

VARIABLE LABELS
  SATISFACCION    'Satisfaccion por el servicio recibido'
  CUALIDADES      'Cualidades de los productos financieros'
  RECOMPENSAS     'Programas de recompensas'
  OBRA_SOCIAL     'Beneficios de obra social'
  CAPITAL_SOCIAL  'Capital social (VD)'.

EXECUTE.

********************************************************************************
* BLOQUE 5. FRECUENCIAS - DEMOGRÁFICAS
********************************************************************************.

FREQUENCIES VARIABLES=Sexo Edad Escolaridad Antiguedad_funcionario
  /ORDER=ANALYSIS
  /STATISTICS=MEAN MEDIAN MODE STDDEV MIN MAX.

********************************************************************************
* BLOQUE 6. FRECUENCIAS - ÍTEMS LIKERT (TODOS CON MODA)
********************************************************************************.

FREQUENCIES VARIABLES=
    sat_01 sat_02 sat_03 sat_04
    cual_01 cual_02 cual_03 cual_04
    recom_01 recom_02 recom_03 recom_04
    obra_01 obra_02 obra_03 obra_04
    cs_01 cs_02
  /ORDER=ANALYSIS
  /STATISTICS=MODE MEDIAN MEAN STDDEV MIN MAX
  /FORMAT=LIMIT(40).

********************************************************************************
* BLOQUE 7. DESCRIPTIVOS - PUNTAJES DIMENSIONALES
********************************************************************************.

DESCRIPTIVES VARIABLES=SATISFACCION CUALIDADES RECOMPENSAS OBRA_SOCIAL
  CAPITAL_SOCIAL
  /STATISTICS=MEAN STDDEV MIN MAX.

********************************************************************************
* BLOQUE 8. CONSISTENCIA INTERNA - ALFA DE CRONBACH
*   Umbral de aceptacion: alfa >= 0.70 (Tavakol & Dennick, 2011)
*   Para Capital Social (2 items) se reporta ademas correlacion inter-item.
********************************************************************************.

* --- Dimension 1: Satisfaccion (4 items) ---.
RELIABILITY
  /VARIABLES=sat_01 sat_02 sat_03 sat_04
  /SCALE('Satisfaccion') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

* --- Dimension 2: Cualidades (4 items) ---.
RELIABILITY
  /VARIABLES=cual_01 cual_02 cual_03 cual_04
  /SCALE('Cualidades') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

* --- Dimension 3: Recompensas (4 items) ---.
RELIABILITY
  /VARIABLES=recom_01 recom_02 recom_03 recom_04
  /SCALE('Recompensas') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

* --- Dimension 4: Obra social (4 items) ---.
RELIABILITY
  /VARIABLES=obra_01 obra_02 obra_03 obra_04
  /SCALE('Obra_social') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

* --- Dimension 5: Capital social (2 items - VD) ---.
RELIABILITY
  /VARIABLES=cs_01 cs_02
  /SCALE('Capital_social') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

********************************************************************************
* BLOQUE 9. CONCORDANCIA - W DE KENDALL + CHI-CUADRADO
*   W de Kendall: mide concordancia entre encuestados dentro de cada dimension.
*   Se evalua junto con chi-cuadrado y significacion p.
********************************************************************************.

* --- Satisfaccion (4 items) ---.
NPAR TESTS /KENDALL=sat_01 sat_02 sat_03 sat_04 /MISSING ANALYSIS.

* --- Cualidades (4 items) ---.
NPAR TESTS /KENDALL=cual_01 cual_02 cual_03 cual_04 /MISSING ANALYSIS.

* --- Recompensas (4 items) ---.
NPAR TESTS /KENDALL=recom_01 recom_02 recom_03 recom_04 /MISSING ANALYSIS.

* --- Obra social (4 items) ---.
NPAR TESTS /KENDALL=obra_01 obra_02 obra_03 obra_04 /MISSING ANALYSIS.

* --- Capital social (2 items) ---.
NPAR TESTS /KENDALL=cs_01 cs_02 /MISSING ANALYSIS.

********************************************************************************
* BLOQUE 10. PRUEBA DE HIPÓTESIS PARA UNA MUESTRA (t contra 3)
*   H0: la media de la dimension = 3 (neutro: "Ni de acuerdo ni en desacuerdo").
*   H1: la media de la dimension != 3.
*   alfa = 0.05, prueba de dos colas.
********************************************************************************.

T-TEST
  /TESTVAL=3
  /VARIABLES=SATISFACCION CUALIDADES RECOMPENSAS OBRA_SOCIAL CAPITAL_SOCIAL.

********************************************************************************
* BLOQUE 11. CORRELACIONES - SPEARMAN
*   Coeficiente rho de Spearman entre dimensiones independientes y VD.
*   No parametrico, adecuado para datos ordinales y n pequena.
********************************************************************************.

NONPAR CORR /VARIABLES=SATISFACCION CUALIDADES RECOMPENSAS OBRA_SOCIAL
  CAPITAL_SOCIAL
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.

********************************************************************************
* BLOQUE 12. BARRAS DE FRECUENCIA - TODOS LOS ÍTEMS
*   Exportar desde el Visor: clic derecho > Exportar > PNG.
********************************************************************************.

* Barras de frecuencia para items Likert (18 items).
FREQUENCIES VARIABLES=
    sat_01 sat_02 sat_03 sat_04
    cual_01 cual_02 cual_03 cual_04
    recom_01 recom_02 recom_03 recom_04
    obra_01 obra_02 obra_03 obra_04
    cs_01 cs_02
  /BARCHART FREQ
  /ORDER=ANALYSIS.

* Barras de frecuencia para variables demograficas.
FREQUENCIES VARIABLES=Sexo Edad Escolaridad Antiguedad_funcionario
  /BARCHART FREQ
  /ORDER=ANALYSIS.

********************************************************************************
* BLOQUE 14. VERIFICACIÓN FINAL
********************************************************************************.

ECHO "==============================================".
ECHO "ANALISIS COMPLETADO - 13 BLOQUES EJECUTADOS".
ECHO "==============================================".
ECHO "".
ECHO "Exportar graficos de frecuencia desde el Visor:".
ECHO "  (cada item Likert + demografico tiene su barra de frecuencia)".
ECHO "  Clic derecho en cada grafico > Exportar > PNG -> results/".
ECHO "".
ECHO "Exportar tablas como TXT:".
ECHO "  Archivo > Exportar > Tipo: Texto -> results/tablas_analisis.txt".
ECHO "".
ECHO "Bloques ejecutados:".
ECHO "  1. Configuracion de rutas".
ECHO "  2. Importacion de datos (23 variables, 15 casos)".
ECHO "  3. Definicion de variables y etiquetas".
ECHO "  4. Calculo de puntajes compuestos (5 dimensiones)".
ECHO "  5. Frecuencias demograficas".
ECHO "  6. Frecuencias items Likert (con moda)".
ECHO "  7. Descriptivos dimensionales".
ECHO "  8. Consistencia interna - Alfa de Cronbach (5 analisis)".
ECHO "  9. Concordancia - W de Kendall + Chi-cuadrado (5 analisis)".
ECHO " 10. Prueba t para una muestra vs 3 (5 analisis)".
ECHO " 11. Correlaciones de Spearman (5 variables)".
ECHO " 12. Barras de frecuencia para todos los items (Likert + demografico)".
ECHO " 13. Verificacion final".

* --- Fin del script ---.
