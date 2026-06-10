********************************************************************************
*                                                                              *
*  GRÁFICOS SELECTIVOS - FACTORES ASOCIADOS AL FORTALECIMIENTO               *
*  DEL CAPITAL SOCIAL EN SOCAPs                                               *
*                                                                              *
*  Fecha:        2026-06-09                                                    *
*  Versión:      2.0                                                           *
*  Software:     IBM SPSS Statistics v.26 o superior                           *
*  Fuente datos: respuestas.csv (15 casos, 23 variables)                      *
*                                                                              *
*  Instrucciones:                                                               *
*    1. Abrir SPSS                                                             *
*    2. Archivo > Abrir > Sintaxis...                                          *
*    3. Ejecutar > Todo                                                        *
*    4. Exportar cada gráfico como PNG desde el Visor                          *
*       (clic derecho > Exportar > PNG -> results/)                            *
*                                                                              *
*  Gráficos (3 total):                                                         *
*    1. Box-plot comparativo de las 5 dimensiones                              *
*    2. Medias dimensionales con línea de neutro (H₁)                         *
*    3. Correlaciones de Spearman con Capital Social (H₃)                    *
*                                                                              *
********************************************************************************.

FILE HANDLE carpeta /NAME='D:\collabs\26-06-09\luz\data\processed\'.

********************************************************************************
* BLOQUE 1. IMPORTACIÓN DE DATOS
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
  recomend_02              'Beneficios preferenciales'
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
* CÁLCULO DE PUNTAJES COMPUESTOS POR DIMENSIÓN
********************************************************************************.

COMPUTE SATISFACCION = MEAN(sat_01, sat_02, sat_03, sat_04).
COMPUTE CUALIDADES = MEAN(cual_01, cual_02, cual_03, cual_04).
COMPUTE RECOMPENSAS = MEAN(recom_01, recom_02, recom_03, recom_04).
COMPUTE OBRA_SOCIAL = MEAN(obra_01, obra_02, obra_03, obra_04).
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
* GRÁFICO 1. BOX-PLOT COMPARATIVO DE LAS 5 DIMENSIONES
*   Propósito: visualizar distribución, mediana, variabilidad y efecto techo
*   en cada dimensión. Las puntuaciones máximas (techo) son visibles cuando
*   la caja se concentra en valores altos de la escala.
********************************************************************************.

EXAMINE VARIABLES=SATISFACCION CUALIDADES RECOMPENSAS OBRA_SOCIAL CAPITAL_SOCIAL
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS NONE
  /NOTOTAL.

********************************************************************************
* GRÁFICO 2. MEDIAS DIMENSIONALES (H₁)
*   Propósito: visualizar la jerarquía de medias por dimensión y la línea de
*   neutro (3 = "Ni de acuerdo ni en desacuerdo"). Todas las dimensiones
*   superan significativamente el punto neutro (p ≤ .004). Recompensas
*   presenta la media más baja (3.80), área de oportunidad principal.
********************************************************************************.

GRAPH /BAR(SIMPLE)=MEAN(SATISFACCION CUALIDADES RECOMPENSAS OBRA_SOCIAL
  CAPITAL_SOCIAL)
  /TITLE='Medias dimensionales - Factores asociados al capital social en SOCAPs'
  /FOOTNOTE='Escala 1-5. Todas las dimensiones superan el punto neutro (3) con p < .01. Recompensas = area de oportunidad (media=3.80).'.

********************************************************************************
* GRÁFICO 3. CORRELACIONES DE SPEARMAN CON CAPITAL SOCIAL (H₃)
*   Propósito: visualizar la fuerza de asociación (rho de Spearman) entre
*   cada dimensión independiente y el capital social. Cualidades presenta la
*   correlación más fuerte (rho = 0.729, p = .002); Recompensas la más
*   moderada (rho = 0.516, p = .049).
********************************************************************************.

DATA LIST FREE /dimension (A30) rho (F5.3).
BEGIN DATA
'Satisfaccion'       0.551
'Cualidades'         0.729
'Recompensas'        0.516
'Obra social'        0.604
END DATA.
VARIABLE LABELS dimension 'Dimension' / rho 'Rho de Spearman'.
VALUE LABELS rho ''.
EXECUTE.

GRAPH /BAR(SIMPLE)=MEAN(rho) BY dimension
  /TITLE='Correlacion de Spearman con Capital Social (H3)'
  /FOOTNOTE='Todas las correlaciones son significativas (p < .05). n = 15.'.

* --- Fin del script de gráficos ---.
