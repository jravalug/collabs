********************************************************************************
*                                                                              *
*  ANÁLISIS ESTADÍSTICO - EDUCACIÓN FINANCIERA EN ADOLESCENTES                 *
*  Autlán de Navarro, Jalisco                                                  *
*                                                                              *
*  Autor:        [Nombre del investigador]                                     *
*  Fecha:        2026-06-06                                                    *
*  Versión:      2.0                                                           *
*  Software:     IBM SPSS Statistics v.26 o superior                           *
*  Fuente datos: data_analisis.csv (656 casos, 30 variables)                  *
*  Encabezados:  UTF-8 con separador ';'                                      *
*                                                                              *
*  Ejecución:                                                                 *
*    1. Abrir SPSS                                                            *
*    2. Archivo > Abrir > Sintaxis...  (seleccionar este archivo .sps)         *
*    3. Ejecutar > Todo                                                       *
*    4. Los resultados aparecen en el Visor de SPSS                           *
*    5. Verificar mensaje BLOQUE 16 al final                                  *
*                                                                              *
*  Bloques (16 total):                                                         *
*    1.  Configuración de rutas                                               *
*    2.  Importación de datos                                                 *
*    3.  Definición de variables y etiquetas                                  *
*    4.  Recodificación de dicotómicas                                        *
*    5.  Cálculo de puntajes compuestos                                       *
*    6.  Frecuencias con medidas de tendencia central                         *
*    7.  Perfil sociodemográfico (Crosstabs)                                 *
*    8.  Consistencia interna - Alfa de Cronbach                              *
*    9.  Test de Friedman (sustituye a W de Kendall)                          *
*   10.  Prueba U de Mann-Whitney (dos colas)                                *
*   11.  P18: preferencias formativas (Crosstabs por subgrupos)              *
*   12.  (Eliminado: exportación PDF; usuario copia resultados.htm)          *
*   13.  Generación de gráficos (4 enfocados)                                 *
*   14.  OMS - Export automático de tablas a Excel                            *
*   15.  Python - Export automático de gráficos a PNG                        *
*   16.  Verificación final de ejecución                                      *
*                                                                              *
********************************************************************************.

********************************************************************************
* BLOQUE 1. CONFIGURACIÓN DE RUTAS
*   Estructura del proyecto:
*     C:\...\26-05-31\
*       data\processed\data_analisis.csv    (entrada SPSS)
*       results\                            (salida SPSS: tablas, graficos)
*   Si mueves la carpeta, edita las 3 rutas de abajo con la nueva ubicacion.
*   Usa DOBLES barras invertidas \\ en Windows.
********************************************************************************.

FILE HANDLE carpeta /NAME='C:\\Users\\jravalug\\OneDrive\\Documents\\Collaborations\\anita\\2026-05-31\\data\\processed\\'.

********************************************************************************
* BLOQUE 2. IMPORTACIÓN DE DATOS
********************************************************************************.

GET DATA  /TYPE=TXT
  /FILE='carpeta\\data_analisis.csv'
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

DISPLAY NAMES.

********************************************************************************
* BLOQUE 3. DEFINICIÓN DE VARIABLES Y ETIQUETAS
********************************************************************************.

VARIABLE LABELS
  nivel_agrupado                  'Nivel educativo agrupado (Secundaria / Bachillerato)'
  sexo                            'Sexo del estudiante'
  tipo_escuela                    'Tipo de financiamiento de la escuela'
  edad                            'Edad en años'
  grado                           'Grado escolar'
  a_convivencia                   'Con quien vive el estudiante'
  b_vivienda                      'Tipo de tenencia de la vivienda'
  c_negocio_familiar              'La familia tiene negocio o empresa'
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

VALUE LABELS  p01_has_escuchado_educacion_financiera
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
* BLOQUE 4. RECODIFICACIÓN DE DICOTÓMICAS A 0/1
*   p07_rec y p17_rec se usan en el cálculo del puntaje de Comportamiento.
*   Las variables p07 y p17 son strings ("Sí" / "No"); el RECODE usa strings.
********************************************************************************.

RECODE p07_tienes_cuenta_ahorro  ('Sí'=1) ('No'=0) INTO p07_rec.
RECODE p17_ahorras_fuera_instituciones ('Sí'=1) ('No'=0) INTO p17_rec.
VARIABLE LABELS  p07_rec  'P07 recodificada (1=Sí, 0=No)'
                /p17_rec 'P17 recodificada (1=Sí, 0=No)'.
EXECUTE.

********************************************************************************
* BLOQUE 5. CÁLCULO DE PUNTAJES COMPUESTOS
*   - Conocimiento: media de 8 ítems Likert (rango 1.00-5.00)
*   - Actitud:      media de 4 ítems Likert (rango 1.00-5.00)
*   - Comportamiento: compuesto normalizado (rango 0.00-1.00)
*   MEAN ignora los casos con valores perdidos por defecto.
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

* Crear variable numerica para Mann-Whitney (nivel_agrupado es STRING).
RECODE nivel_agrupado ('Secundaria'=1) ('Bachillerato'=2) INTO nivel_num.
VARIABLE LABELS nivel_num 'Nivel educativo (numerico) - 1=Secundaria, 2=Bachillerato'.
VALUE LABELS nivel_num 1 'Secundaria' 2 'Bachillerato'.
EXECUTE.

********************************************************************************
* BLOQUE 14. OMS - EXPORT AUTOMATICO DE TABLAS
*   Enruta todas las tablas a un solo archivo Excel. Debe ir ANTES de los
*   bloques que generan tablas.
********************************************************************************.

OMS
  /SELECT TABLES
  /IF COMMANDS=['Frequencies' 'Reliability' 'NPar Tests' 'Descriptives' 'Crosstabs' 'Examine']
  /DESTINATION FORMAT=XLSX
    OUTFILE='C:\\Users\\jravalug\\OneDrive\\Documents\\Collaborations\\anita\\2026-05-31\\results\\tablas_analisis.xlsx'
  /COLUMNS SEQUENCE=[L1 R1]
  /TAG='export_tablas'.

********************************************************************************
* BLOQUE 6. FRECUENCIAS CON MEDIDAS DE TENDENCIA CENTRAL
*   Para Likert (ordinal): moda, mediana, IQR via percentiles
*   Para puntajes: media, DE, mediana, mín, máx
*   Por subgrupo (nivel educativo): distribución comparada
********************************************************************************.

* Frecuencias con medidas de tendencia central para los 14 ítems Likert.
FREQUENCIES VARIABLES=
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
  /ORDER=ANALYSIS
  /STATISTICS=MODE MEDIAN MEAN STDDEV MIN MAX
  /FORMAT=LIMIT(40).

* Frecuencias de variables dicotómicas y categóricas.
FREQUENCIES VARIABLES=
    p05_definicion_educacion_financiera
    p07_tienes_cuenta_ahorro
    p17_ahorras_fuera_instituciones
    c_negocio_familiar
    a_convivencia
    b_vivienda
  /ORDER=ANALYSIS
  /STATISTICS=MODE
  /FORMAT=LIMIT(40).

* Descriptivos de los 3 puntajes compuestos (global).
DESCRIPTIVES VARIABLES=puntaje_conocimiento puntaje_actitud puntaje_comportamiento
  /STATISTICS=MEAN STDDEV MIN MAX.

* Descriptivos de los 3 puntajes compuestos POR NIVEL EDUCATIVO.
MEANS TABLES=puntaje_conocimiento puntaje_actitud puntaje_comportamiento BY nivel_agrupado
  /CELLS=MEAN STDDEV MIN MAX COUNT.

* Descriptivos de la edad y grado POR NIVEL EDUCATIVO (perfil sociodemográfico).
MEANS TABLES=edad grado BY nivel_agrupado
  /CELLS=MEAN STDDEV MIN MAX COUNT.

* Distribución de respuestas Likert POR NIVEL EDUCATIVO (medidas de tendencia central).
FREQUENCIES VARIABLES=
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p04_consideras_importante_educacion_financiera
    p06_conoces_significado_ahorro
    p10_conoces_que_es_credito
  BY nivel_agrupado
  /ORDER=ANALYSIS
  /STATISTICS=MODE MEDIAN MEAN STDDEV
  /FORMAT=LIMIT(40).

********************************************************************************
* BLOQUE 7. PERFIL SOCIODEMOGRÁFICO - CROSSTABS AMPLIADO
*   15 pruebas chi-cuadrado: asociación entre nivel educativo y variables
*   sociodemográficas, conocimientos, actitudes y prácticas.
********************************************************************************.

CROSSTABS /TABLES=nivel_agrupado BY
    sexo
    tipo_escuela
    a_convivencia
    b_vivienda
    c_negocio_familiar
    p05_definicion_educacion_financiera
    p01_has_escuchado_educacion_financiera
    p02_conoces_significado_educacion_financiera
    p04_consideras_importante_educacion_financiera
    p06_conoces_significado_ahorro
    p07_tienes_cuenta_ahorro
    p08_constante_responsable_ahorrar
    p09_opinion_credito_banco_caja
    p10_conoces_que_es_credito
    p17_ahorras_fuera_instituciones
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT COLUMN.

********************************************************************************
* BLOQUE 8. CONSISTENCIA INTERNA - ALFA DE CRONBACH
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
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.

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
* BLOQUE 9. TEST DE FRIEDMAN
*   Sustituye a W de Kendall (no aplicable: 1 respondedor por estudiante).
*   Evalúa si los 14 ítems Likert tienen distribuciones similares dentro
*   de cada respondedor, por separado para cada nivel educativo.
*   Usa SPLIT FILE para segmentar por grupo.
********************************************************************************.

* Ordenar casos y segmentar por nivel educativo.
SORT CASES BY nivel_agrupado.
SPLIT FILE SEPARATE BY nivel_agrupado.

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
  /MISSING ANALYSIS.

* Restaurar la segmentación única.
SPLIT FILE OFF.

********************************************************************************
* BLOQUE 10. PRUEBA U DE MANN-WHITNEY (DOS COLAS)
*   Comparación de los 3 puntajes compuestos entre niveles educativos.
*   H0: las distribuciones son iguales entre Secundaria y Bachillerato.
*   H1: las distribuciones difieren entre los dos grupos.
*   α = 0.05; prueba de dos colas (conservadora, defendible).
********************************************************************************.

NPAR TESTS
  /M-W= puntaje_conocimiento puntaje_actitud puntaje_comportamiento BY nivel_num(1 2)
  /MISSING ANALYSIS
  /STATISTICS=DESCRIPTIVES.

********************************************************************************
* BLOQUE 11. P18 - PREFERENCIAS FORMATIVAS
*   Frecuencias + Crosstabs por subgrupos demográficos.
********************************************************************************.

* Frecuencias de P18 con medidas de tendencia central.
FREQUENCIES VARIABLES=p18_categoria
  /ORDER=ANALYSIS
  /STATISTICS=MODE.

* Listado verbatim de P18 con su frecuencia.
FREQUENCIES VARIABLES=p18_como_gustarian_clases
  /ORDER=ANALYSIS
  /FORMAT=LIMIT(100).

* Crosstabs P18 por subgrupos demográficos (4 pruebas).
CROSSTABS /TABLES=p18_categoria BY
    nivel_agrupado
    sexo
    tipo_escuela
    c_negocio_familiar
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT COLUMN.

* Cierre del OMS (después de todas las tablas).
OMSEND.

********************************************************************************
* BLOQUE 13. GENERACIÓN DE GRÁFICOS (4 ENFOCADOS)
*   Solo los gráficos que aportan visualmente al documento:
*     1. Barras cluster de P18 (preferencias formativas)
*     2. Barras apiladas de P04 (actitud: importancia de la EF)
*     3. Barras apiladas de P10 (conocimiento: crédito)
*     4. Barras apiladas de P06 (conocimiento: ahorro)
*   El usuario debe exportar manualmente cada gráfico como PNG:
*     clic derecho sobre el gráfico > Exportar > PNG
*     guardar en la carpeta de trabajo.
********************************************************************************.

* --- Gráfico 1: Barras cluster de P18 por nivel ---.
GRAPH /BAR(GROUPED)=COUNT BY p18_categoria BY nivel_agrupado
  /TITLE='Preferencias formativas (P18) por nivel educativo'
  /MISSING=REPORT.

* --- Gráfico 2: Barras apiladas de P04 (actitud) ---.
GRAPH /BAR(STACK)=PCT BY p04_consideras_importante_educacion_financiera BY nivel_agrupado
  /TITLE='P04 - Considera importante la educacion financiera (%)'
  /MISSING=REPORT.

* --- Gráfico 3: Barras apiladas de P10 (conocimiento crédito) ---.
GRAPH /BAR(STACK)=PCT BY p10_conoces_que_es_credito BY nivel_agrupado
  /TITLE='P10 - Conoce que es un credito (%)'
  /MISSING=REPORT.

* --- Gráfico 4: Barras apiladas de P06 (conocimiento ahorro) ---.
GRAPH /BAR(STACK)=PCT BY p06_conoces_significado_ahorro BY nivel_agrupado
  /TITLE='P06 - Conoce el significado de ahorro (%)'
  /MISSING=REPORT.

********************************************************************************
* BLOQUE 15. PYTHON - EXPORT AUTOMATICO DE GRAFICOS A PNG
*   Recorre el Visor de SPSS, identifica cada grafico y lo exporta como PNG.
*   Requiere SPSS con Python Essentials (incluido por defecto v.22+).
*   Nombres generados: grafico_1.png, grafico_2.png, ..., grafico_N.png
********************************************************************************.

BEGIN PROGRAM PYTHON.
import SpssClient
import os

outputPath = r'C:\Users\jravalug\OneDrive\Documents\Collaborations\anita\2026-05-31\results'
count = 0
errors = 0

try:
    SpssClient.StartClient()
    outputDocs = SpssClient.GetOutputDocuments()
    if outputDocs.Size() == 0:
        print('No hay documentos de salida')
    else:
        outputDoc = outputDocs.GetItemAt(0)
        outputDoc.Activate()
        for i in range(outputDoc.GetOutputItemCount()):
            item = outputDoc.GetOutputItem(i)
            if item.GetType() == 3:
                count += 1
                try:
                    chart = item.GetSpecificType()
                    filename = 'grafico_%d.png' % count
                    filepath = os.path.join(outputPath, filename)
                    saved = False
                    if hasattr(chart, 'SaveAs'):
                        chart.SaveAs(filepath)
                        saved = True
                    elif hasattr(chart, 'ExportPicture'):
                        chart.ExportPicture(filepath)
                        saved = True
                    if saved:
                        print('  Exportado: ' + filename)
                    else:
                        print('  Grafico %d: metodo de export no encontrado' % count)
                        errors += 1
                except Exception as e:
                    print('  Error en grafico %d: %s' % (count, str(e)))
                    errors += 1
    SpssClient.StopClient()
except Exception as e:
    print('Error general de Python: ' + str(e))

print('--- Total graficos exportados: %d | Errores: %d ---' % (count, errors))
END PROGRAM.

********************************************************************************
* BLOQUE 16. VERIFICACION FINAL DE EJECUCION
*   Comprueba que el script se ejecuto correctamente:
*     - Variables clave creadas (puntajes compuestos, recodificaciones)
*     - Tablas estadisticas presentes (Cronbach, Mann-Whitney, Friedman, etc.)
*     - Graficos generados en el Visor
*     - Sin errores criticos en el output
*   Muestra un mensaje de APROBADO o REQUIERE ATENCION al final.
********************************************************************************.

BEGIN PROGRAM PYTHON.
errores = []
advertencias = []
ok_items = []

try:
    SpssClient.StartClient()

    dataDoc = SpssClient.GetActiveDataDoc()
    if dataDoc is None:
        errores.append('No hay documento de datos activo')
    else:
        varList = dataDoc.GetVariableList()
        existing_vars = []
        for i in range(varList.Size()):
            existing_vars.append(varList.GetItemAt(i).GetName())

        variables_requeridas = [
            'puntaje_conocimiento',
            'puntaje_actitud',
            'puntaje_comportamiento',
            'p07_rec',
            'p17_rec',
            'nivel_agrupado',
            'nivel_num'
        ]
        for v in variables_requeridas:
            if v in existing_vars:
                ok_items.append('Variable creada: ' + v)
            else:
                errores.append('Variable FALTANTE: ' + v)

    outputDocs = SpssClient.GetOutputDocuments()
    if outputDocs.Size() == 0:
        errores.append('No hay documento de salida activo')
    else:
        outputDoc = outputDocs.GetItemAt(0)
        tablas = 0
        graficos = 0
        errores_output = 0

        for i in range(outputDoc.GetOutputItemCount()):
            item = outputDoc.GetOutputItem(i)
            tipo = item.GetType()
            if tipo == 0:
                tablas += 1
            elif tipo == 3:
                graficos += 1
            elif tipo == 6:
                errores_output += 1

        if tablas >= 30:
            ok_items.append('Tablas en Visor: ' + str(tablas))
        else:
            advertencias.append('Pocas tablas en Visor: ' + str(tablas) + ' (esperaba >= 30)')

        if graficos >= 4:
            ok_items.append('Graficos en Visor: ' + str(graficos))
        else:
            advertencias.append('Pocos graficos en Visor: ' + str(graficos) + ' (esperaba >= 4)')

        if errores_output > 0:
            errores.append('Errores detectados en el Visor: ' + str(errores_output))

    SpssClient.StopClient()

except Exception as e:
    errores.append('Excepcion en verificacion: ' + str(e))

print('')
print('=' * 70)
print('  VERIFICACION FINAL DE EJECUCION')
print('=' * 70)

if not errores:
    print('')
    print('  ***  APROBADO  ***')
    print('')
    print('  La ejecucion del script finalizo correctamente.')
    print('  Items verificados: ' + str(len(ok_items)))
    print('')
    for item in ok_items:
        print('    [OK]  ' + item)
else:
    print('')
    print('  ***  REQUIERE ATENCION  ***')
    print('')
    print('  Se encontraron ' + str(len(errores)) + ' error(es):')
    print('')
    for error in errores:
        print('    [ERROR]  ' + error)
    print('')
    print('  Revisar el Visor de SPSS para mas detalles.')

if advertencias:
    print('')
    print('  Advertencias (' + str(len(advertencias)) + '):')
    print('')
    for adv in advertencias:
        print('    [WARN]  ' + adv)

print('')
print('=' * 70)
print('')
END PROGRAM.

* --- Fin del script ---.
