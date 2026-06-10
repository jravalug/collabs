********************************************************************************
*                                                                              *
*  ANÁLISIS ESTADÍSTICO - GOBIERNO CORPORATIVO EN PYMES                       *
*  Autlán de Navarro, Jalisco                                                  *
*                                                                              *
*  Autor:        José Raúl Avalos Gutiérrez                                    *
*  Fecha:        2026-06-09                                                    *
*  Versión:      1.0                                                           *
*  Software:     IBM SPSS Statistics v.26 o superior                           *
*  Fuente datos: data_analisis.csv (136 casos, 53 variables)                  *
*  Encabezados:  UTF-8 con separador ';'                                      *
*                                                                              *
*  Ejecución:                                                                 *
*    1. Abrir SPSS                                                            *
*    2. Archivo > Abrir > Sintaxis...  (seleccionar este archivo .sps)         *
*    3. Ejecutar > Todo                                                       *
*    4. Los resultados aparecen en el Visor de SPSS                           *
*                                                                              *
*  Bloques (12 total):                                                         *
 *    1.  Configuración de rutas                                               *
 *    2.  Importación de datos                                                 *
 *    3.  Definición de variables y etiquetas                                  *
 *    4.  Cálculo de puntajes compuestos por dimensión                         *
 *    5.  Frecuencias con medidas de tendencia central (moda)                  *
 *    6.  Perfil sociodemográfico                                              *
 *    7.  Consistencia interna - Alfa de Cronbach                              *
 *    8.  Concordancia - W de Kendall + Chi-cuadrado                           *
 *    9.  Prueba de hipótesis para una muestra (t contra 3)                    *
 *   10.  Gráficos de frecuencia - todos los ítems                             *
 *   11.  OMS - Export automático de tablas a Excel                            *
 *   12.  Verificación final                                                   *
*                                                                              *
********************************************************************************.

********************************************************************************
* BLOQUE 1. CONFIGURACIÓN DE RUTAS
*   Estructura del proyecto:
*     ...\26-06-09\aaron\data\processed\data_analisis.csv  (entrada SPSS)
*     ...\26-06-09\aaron\results\                           (salida SPSS)
*   Edita la ruta de abajo con la ubicación de tu carpeta "aaron".
*   Usa DOBLES barras invertidas \\ en Windows.
********************************************************************************.

FILE HANDLE carpeta /NAME='D:\collabs\26-06-09\aaron\data\processed\'.

********************************************************************************
* BLOQUE 2. IMPORTACIÓN DE DATOS
********************************************************************************.

GET DATA  /TYPE=TXT
  /FILE='carpeta\data_analisis.csv'
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=";"
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /VARIABLES=
    tamano_empresa A
    anos_permanencia A
    responsabilidad A
    edad F
    sexo A
    escolaridad A
    a_01 F a_02 F a_03 F
    b_01 F b_02 F b_03 F b_04 F b_05 F b_06 F b_07 F
    c_01 F c_02 F c_03 F c_04 F c_05 F
    d_01 F d_02 F d_03 F
    e_01 F e_02 F e_03 F e_04 F e_05 F e_06 F e_07 F
    g_01 F g_02 F g_03 F
    h_01 F h_02 F h_03 F
    f_01 F f_02 F f_03 F f_04 F f_05 F f_06 F
    i_01 F i_02 F
    j_01 F j_02 F j_03 F j_04 F
    f_01_inv F f_02_inv F f_03_inv F f_05_inv F.
CACHE.
EXECUTE.

DISPLAY NAMES.

********************************************************************************
* BLOQUE 3. DEFINICIÓN DE VARIABLES Y ETIQUETAS
********************************************************************************.

VARIABLE LABELS
  tamano_empresa           'Tamaño de la empresa'
  anos_permanencia         'Años de permanencia en el mercado'
  responsabilidad          'Responsabilidad o función que realiza'
  edad                     'Edad del encuestado'
  sexo                     'Sexo del encuestado'
  escolaridad              'Nivel de escolaridad'
  a_01                     'A.1 ¿Posee su plan de negocios?'
  a_02                     'A.2 ¿Revisa y adecua su plan de negocios?'
  a_03                     'A.3 ¿Conocen todos los que trabajan el plan?'
  b_01                     'B.1 ¿Realiza proyección de ingresos, gastos y utilidades?'
  b_02                     'B.2 ¿Revisa esta proyección?'
  b_03                     'B.3 ¿Proyección mensual?'
  b_04                     'B.4 ¿Proyección trimestral?'
  b_05                     'B.5 ¿Proyección semestral?'
  b_06                     'B.6 ¿Elabora planes de medidas?'
  b_07                     'B.7 ¿Analiza cumplimiento de planes de medidas?'
  c_01                     'C.1 ¿Están definidas responsabilidades, roles y funciones?'
  c_02                     'C.2 ¿Tiene instructivos y manuales?'
  c_03                     'C.3 ¿Está definida la estructura empresarial?'
  c_04                     'C.4 ¿Estructura delimita responsabilidades y autoridad?'
  c_05                     'C.5 ¿Existe separación de funciones?'
  d_01                     'D.1 ¿Riesgos identificados que afectan la permanencia?'
  d_02                     'D.2 ¿Riesgos jerarquizados por importancia?'
  d_03                     'D.3 ¿Medidas para mitigar riesgos?'
  e_01                     'E.1 ¿Plan comercial?'
  e_02                     'E.2 ¿Caracterización de clientes?'
  e_03                     'E.3 ¿Productos estrella?'
  e_04                     'E.4 ¿Identificación de competidores?'
  e_05                     'E.5 ¿Promoción de productos?'
  e_06                     'E.6 ¿Canales digitales?'
  e_07                     'E.7 ¿Alianzas comerciales?'
  f_01                     'F.1 ¿Problemas de liquidez regularmente? (invertido)'
  f_02                     'F.2 ¿Dificultades con capital de trabajo? (invertido)'
  f_03                     'F.3 ¿Problemas en rotación de inventarios? (invertido)'
  f_04                     'F.4 ¿Cobra con facilidad cuentas pendientes?'
  f_05                     'F.5 ¿Dificultades para pagar proveedores? (invertido)'
  f_06                     'F.6 ¿Negociaciones con proveedores?'
  f_01_inv                 'F.1 invertido (6 - valor original)'
  f_02_inv                 'F.2 invertido (6 - valor original)'
  f_03_inv                 'F.3 invertido (6 - valor original)'
  f_05_inv                 'F.5 invertido (6 - valor original)'
  g_01                     'G.1 ¿Negocia financiamiento a más bajo costo?'
  g_02                     'G.2 ¿Negocia reestructuración de deudas?'
  g_03                     'G.3 ¿Flujos financieros positivos para el negocio?'
  h_01                     'H.1 ¿Capacitación al personal?'
  h_02                     'H.2 ¿Motiva al personal incentivándolo?'
  h_03                     'H.3 ¿Pagos por resultados?'
  i_01                     'I.1 ¿Revisa portafolio vs competencia?'
  i_02                     'I.2 ¿Adecúa portafolio según revisión?'
  j_01                     'J.1 ¿Medidas para no afectar armonía familiar?'
  j_02                     'J.2 ¿Consejo familiar?'
  j_03                     'J.3 ¿Planes de sucesión?'
  j_04                     'J.4 ¿Capacitación a familiares directivos?'.

VALUE LABELS tamano_empresa
  'Pequeña' 'Pequeña'
  'Mediana' 'Mediana'.

VALUE LABELS anos_permanencia
  '1 a 5 años' '1 a 5 años'
  '6 a 10 años' '6 a 10 años'
  '11 a 15 años' '11 a 15 años'
  '16 a 20 años' '16 a 20 años'
  '21 a 30 años' '21 a 30 años'
  '31 a 40 años' '31 a 40 años'
  '41 o más años' '41 o más años'.

VALUE LABELS responsabilidad
  'Dueño' 'Dueño'
  'Administrador' 'Administrador'.

VALUE LABELS sexo
  'Masculino' 'Masculino'
  'Femenino' 'Femenino'.

VALUE LABELS escolaridad
  'Preparatoria' 'Preparatoria'
  'Técnica' 'Técnica'
  'Universitaria' 'Universitaria'
  'Postgraduada' 'Postgraduada'.

VALUE LABELS
  a_01 a_02 a_03
  b_01 b_02 b_03 b_04 b_05 b_06 b_07
  c_01 c_02 c_03 c_04 c_05
  d_01 d_02 d_03
  e_01 e_02 e_03 e_04 e_05 e_06 e_07
  f_01 f_02 f_03 f_04 f_05 f_06
  f_01_inv f_02_inv f_03_inv f_05_inv
  g_01 g_02 g_03
  h_01 h_02 h_03
  i_01 i_02
  j_01 j_02 j_03 j_04
  1 'No, nunca, mal'
  2 'Casi nunca, regular'
  3 'No sé, no tengo criterio'
  4 'Casi siempre, bien'
  5 'Sí, siempre, excelente'.

EXECUTE.

********************************************************************************
* BLOQUE 4. CÁLCULO DE PUNTAJES COMPUESTOS POR DIMENSIÓN
*   Cada dimensión = media de sus ítems.
*   Los ítems f_01, f_02, f_03, f_05 se invirtieron en clean.py
*   para que puntajes altos siempre = buen gobierno corporativo.
********************************************************************************.

COMPUTE dim_a = MEAN(a_01, a_02, a_03).
COMPUTE dim_b = MEAN(b_01, b_02, b_03, b_04, b_05, b_06, b_07).
COMPUTE dim_c = MEAN(c_01, c_02, c_03, c_04, c_05).
COMPUTE dim_d = MEAN(d_01, d_02, d_03).
COMPUTE dim_e = MEAN(e_01, e_02, e_03, e_04, e_05, e_06, e_07).
COMPUTE dim_f = MEAN(f_01_inv, f_02_inv, f_03_inv, f_04, f_05_inv, f_06).
COMPUTE dim_g = MEAN(g_01, g_02, g_03).
COMPUTE dim_h = MEAN(h_01, h_02, h_03).
COMPUTE dim_i = MEAN(i_01, i_02).
COMPUTE dim_j = MEAN(j_01, j_02, j_03, j_04).

COMPUTE dim_global = MEAN(dim_a, dim_b, dim_c, dim_d, dim_e, dim_f, dim_g, dim_h, dim_i, dim_j).

VARIABLE LABELS
  dim_a       'Dimensión A - Desempeño y Estrategias de Negocios'
  dim_b       'Dimensión B - Presupuestación Financiera Interna'
  dim_c       'Dimensión C - Institucionalización'
  dim_d       'Dimensión D - Controles de Riesgos'
  dim_e       'Dimensión E - Prácticas de Ventas'
  dim_f       'Dimensión F - Finanzas Internas'
  dim_g       'Dimensión G - Negociación Financiera'
  dim_h       'Dimensión H - Recursos Humanos'
  dim_i       'Dimensión I - Ventajas Competitivas'
  dim_j       'Dimensión J - Mejores Prácticas Empresas Familiares'
  dim_global  'Puntaje global de gobierno corporativo'.

EXECUTE.

********************************************************************************
* OMS - EXPORT AUTOMÁTICO DE TABLAS
*   Enruta todas las tablas a un solo archivo Excel.
*   Debe ir ANTES de los bloques que generan tablas.
********************************************************************************.

OMS
  /SELECT TABLES
  /IF COMMANDS=['Frequencies' 'Reliability' 'NPar Tests' 'Descriptives' 'T-Test']
  /DESTINATION FORMAT=XLSX
    OUTFILE='D:\collabs\26-06-09\aaron\results\tablas_analisis.xlsx'
  /COLUMNS SEQUENCE=[L1 R1]
  /TAG='export_tablas'.

********************************************************************************
* BLOQUE 5. FRECUENCIAS CON MEDIDAS DE TENDENCIA CENTRAL (MODA)
*   Para todos los 43 ítems Likert: frecuencia, moda, mediana, media, DE.
********************************************************************************.

* Frecuencias con estadísticos para los 43 ítems Likert.
FREQUENCIES VARIABLES=
    a_01 a_02 a_03
    b_01 b_02 b_03 b_04 b_05 b_06 b_07
    c_01 c_02 c_03 c_04 c_05
    d_01 d_02 d_03
    e_01 e_02 e_03 e_04 e_05 e_06 e_07
    f_01 f_02 f_03 f_04 f_05 f_06
    f_01_inv f_02_inv f_03_inv f_05_inv
    g_01 g_02 g_03
    h_01 h_02 h_03
    i_01 i_02
    j_01 j_02 j_03 j_04
  /ORDER=ANALYSIS
  /STATISTICS=MODE MEDIAN MEAN STDDEV MIN MAX
  /FORMAT=LIMIT(40).

* Frecuencias de variables demográficas.
FREQUENCIES VARIABLES=
    tamano_empresa
    anos_permanencia
    responsabilidad
    sexo
    escolaridad
    edad
  /ORDER=ANALYSIS
  /STATISTICS=MODE MEDIAN MEAN STDDEV
  /FORMAT=LIMIT(40).

********************************************************************************
* BLOQUE 6. PERFIL SOCIODEMOGRÁFICO
*   Descriptivos de los puntajes por dimensión (global).
********************************************************************************.

DESCRIPTIVES VARIABLES=dim_a dim_b dim_c dim_d dim_e dim_f dim_g dim_h dim_i dim_j dim_global
  /STATISTICS=MEAN STDDEV MIN MAX.

********************************************************************************
* BLOQUE 7. CONSISTENCIA INTERNA - ALFA DE CRONBACH
*   Umbral de aceptación: α ≥ 0.70 (Tavakol & Dennick, 2011)
********************************************************************************.

* --- Alfa global: 43 ítems Likert ---.
RELIABILITY
  /VARIABLES=
    a_01 a_02 a_03
    b_01 b_02 b_03 b_04 b_05 b_06 b_07
    c_01 c_02 c_03 c_04 c_05
    d_01 d_02 d_03
    e_01 e_02 e_03 e_04 e_05 e_06 e_07
    f_01_inv f_02_inv f_03_inv f_04 f_05_inv f_06
    g_01 g_02 g_03
    h_01 h_02 h_03
    i_01 i_02
    j_01 j_02 j_03 j_04
  /SCALE('Cronbach Global - 43 items') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión A: Desempeño y Estrategias (3) ---.
RELIABILITY
  /VARIABLES=a_01 a_02 a_03
  /SCALE('Dim A - Desempeno y Estrategias') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión B: Presupuestación Financiera (7) ---.
RELIABILITY
  /VARIABLES=b_01 b_02 b_03 b_04 b_05 b_06 b_07
  /SCALE('Dim B - Presupuestacion Financiera') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión C: Institucionalización (5) ---.
RELIABILITY
  /VARIABLES=c_01 c_02 c_03 c_04 c_05
  /SCALE('Dim C - Institucionalizacion') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión D: Controles de Riesgos (3) ---.
RELIABILITY
  /VARIABLES=d_01 d_02 d_03
  /SCALE('Dim D - Controles de Riesgos') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión E: Prácticas de Ventas (7) ---.
RELIABILITY
  /VARIABLES=e_01 e_02 e_03 e_04 e_05 e_06 e_07
  /SCALE('Dim E - Practicas de Ventas') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión F: Finanzas Internas (6, con invertidos) ---.
RELIABILITY
  /VARIABLES=f_01_inv f_02_inv f_03_inv f_04 f_05_inv f_06
  /SCALE('Dim F - Finanzas Internas') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión G: Negociación Financiera (3) ---.
RELIABILITY
  /VARIABLES=g_01 g_02 g_03
  /SCALE('Dim G - Negociacion Financiera') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión H: Recursos Humanos (3) ---.
RELIABILITY
  /VARIABLES=h_01 h_02 h_03
  /SCALE('Dim H - Recursos Humanos') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión I: Ventajas Competitivas (2) ---.
RELIABILITY
  /VARIABLES=i_01 i_02
  /SCALE('Dim I - Ventajas Competitivas') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

* --- Dimensión J: Mejores Prácticas E. Familiares (4) ---.
RELIABILITY
  /VARIABLES=j_01 j_02 j_03 j_04
  /SCALE('Dim J - Mejores Practicas E. Familiares') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

********************************************************************************
* BLOQUE 8. CONCORDANCIA - W DE KENDALL + CHI-CUADRADO
*   W de Kendall mide la concordancia entre las respuestas dentro de cada
*   dimensión. Se valora junto con chi-cuadrado y significación p.
********************************************************************************.

* --- Dimensión A ---.
NPAR TESTS /KENDALL=a_01 a_02 a_03 /MISSING ANALYSIS.

* --- Dimensión B ---.
NPAR TESTS /KENDALL=b_01 b_02 b_03 b_04 b_05 b_06 b_07 /MISSING ANALYSIS.

* --- Dimensión C ---.
NPAR TESTS /KENDALL=c_01 c_02 c_03 c_04 c_05 /MISSING ANALYSIS.

* --- Dimensión D ---.
NPAR TESTS /KENDALL=d_01 d_02 d_03 /MISSING ANALYSIS.

* --- Dimensión E ---.
NPAR TESTS /KENDALL=e_01 e_02 e_03 e_04 e_05 e_06 e_07 /MISSING ANALYSIS.

* --- Dimensión F (usar invertidos) ---.
NPAR TESTS /KENDALL=f_01_inv f_02_inv f_03_inv f_04 f_05_inv f_06 /MISSING ANALYSIS.

* --- Dimensión G ---.
NPAR TESTS /KENDALL=g_01 g_02 g_03 /MISSING ANALYSIS.

* --- Dimensión H ---.
NPAR TESTS /KENDALL=h_01 h_02 h_03 /MISSING ANALYSIS.

* --- Dimensión I ---.
NPAR TESTS /KENDALL=i_01 i_02 /MISSING ANALYSIS.

* --- Dimensión J ---.
NPAR TESTS /KENDALL=j_01 j_02 j_03 j_04 /MISSING ANALYSIS.

********************************************************************************
* BLOQUE 9. PRUEBA DE HIPÓTESIS PARA UNA MUESTRA (t contra 3)
*   H0: la media de la dimensión = 3 (neutro: "No sé, no tengo criterio").
*   H1: la media de la dimensión ≠ 3.
*   α = 0.05, prueba de dos colas.
*   Si media > 3 significativamente → la práctica está presente.
*   Si media < 3 significativamente → la práctica está ausente.
********************************************************************************.

T-TEST
  /TESTVAL=3
  /VARIABLES=dim_a dim_b dim_c dim_d dim_e dim_f dim_g dim_h dim_i dim_j dim_global.

********************************************************************************
* BLOQUE 10. GRÁFICOS DE FRECUENCIA - TODOS LOS ÍTEMS
*   Genera barras de frecuencia para cada pregunta. Exportar desde el
*   Visor: clic derecho > Exportar > PNG → results/.
*   Si las conclusiones requieren gráficos específicos adicionales,
*   crearlos en spss/graficos.sps.
********************************************************************************.

* Barras de frecuencia para todos los ítems Likert (43 + 4 invertidos).
FREQUENCIES VARIABLES=a_01 TO j_04
  /BARCHART FREQ
  /ORDER=ANALYSIS.

* Barras de frecuencia para variables demográficas.
FREQUENCIES VARIABLES=tamano_empresa anos_permanencia responsabilidad sexo escolaridad edad
  /BARCHART FREQ
  /ORDER=ANALYSIS.

********************************************************************************
* BLOQUE 11. CIERRE OMS
********************************************************************************.

OMSEND.

********************************************************************************
* BLOQUE 12. VERIFICACIÓN FINAL
********************************************************************************.

ECHO "==============================================".
ECHO "ANÁLISIS COMPLETADO - 12 BLOQUES EJECUTADOS".
ECHO "==============================================".
ECHO "Revisar en results/tablas_analisis.xlsx".
ECHO "".
ECHO "Exportar gráficos de frecuencia desde el Visor:".
ECHO "  (cada ítem Likert + demográfico tiene su barra de frecuencia)".
ECHO "  Clic derecho en cada gráfico > Exportar > PNG → results/".
ECHO "".
ECHO "Exportar tablas como TXT:".
ECHO "  Archivo > Exportar > Tipo: Texto → results/tablas_analisis.txt".
ECHO "".
ECHO "Bloques ejecutados:".
ECHO "  1. Configuración de rutas".
ECHO "  2. Importación de datos (53 variables, 136 casos)".
ECHO "  3. Definición de variables y etiquetas".
ECHO "  4. Cálculo de puntajes compuestos (10 dimensiones + global)".
ECHO "  5. Frecuencias con moda y tendencia central".
ECHO "  6. Perfil sociodemográfico".
ECHO "  7. Consistencia interna - Alfa de Cronbach (11 análisis)".
ECHO "  8. Concordancia - W de Kendall + Chi-cuadrado (10 análisis)".
ECHO "  9. Prueba t para una muestra vs 3 (11 análisis)".
ECHO " 10. Barras de frecuencia para todos los ítems (Likert + demo)".
ECHO " 11. OMS - Exportación a Excel".
ECHO " 12. Verificación final".

* --- Fin del script ---.
