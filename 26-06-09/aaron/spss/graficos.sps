********************************************************************************
* graficos.sps — Aaron (Gobierno Corporativo en PYMES)
*   Segunda fase: gráficos selectivos para ilustrar las conclusiones.
*   Basado en docs/conclusiones.md §9.
*
*   Exportar: Visor > clic derecho sobre el gráfico > Exportar > PNG → results/.
*   Nombrar secuencialmente: grafico01.png .. grafico06.png.
********************************************************************************.

FILE HANDLE carpeta /NAME='D:\collabs\26-06-09\aaron\data\processed\'.

GET FILE='carpeta\data_analisis.sav'.
DATASET NAME main WINDOW=FRONT.

* ==============================================================================
* Gráfico 1: Jerarquía de dimensiones (medias).
*   Objetivo: visualizar fortalezas (C, E, H) vs. debilidades (J, B).
*   Tipo: barras simples.
* ==============================================================================.
GRAPH /BAR(SIMPLE)=MEAN(dim_a dim_b dim_c dim_d dim_e dim_f dim_g dim_h dim_i dim_j)
  /TITLE='Medias por dimensión de gobierno corporativo'
  /FOOTNOTE='Escala: 1 (Muy en desacuerdo) a 5 (Muy de acuerdo). Línea roja = punto neutro (3).'.

* ==============================================================================
* Gráfico 2: Institucionalización (dim C) — ítems individuales.
*   Objetivo: mostrar qué prácticas de institucionalización tienen mayor
*   puntaje. Dimensión con media más alta (4.45) y mayor concordancia (W=0.310).
*   Tipo: barras simples de medias.
* ==============================================================================.
GRAPH /BAR(SIMPLE)=MEAN(c_01 c_02 c_03 c_04 c_05)
  /TITLE='Ítems de Institucionalización (dimensión C)'
  /FOOTNOTE='c_01=Roles definidos  c_02=Manuales  c_03=Segregación  c_04=Delegación  c_05=Reglamento'.

* ==============================================================================
* Gráfico 3: Presupuestación Financiera (dim B) — ítems individuales.
*   Objetivo: identificar prácticas financieras menos desarrolladas.
*   Segunda dimensión más baja (media=3.60).
*   Tipo: barras simples de medias.
* ==============================================================================.
GRAPH /BAR(SIMPLE)=MEAN(b_01 b_02 b_03 b_04 b_05 b_06 b_07)
  /TITLE='Ítems de Presupuestación Financiera (dimensión B)'
  /FOOTNOTE='b_01=Meta ingresos  b_02=Proyección gastos  b_03=Corregir desviaciones  b_04=Equilibrio  b_05=Meta utilidad  b_06=Revisar presupuesto  b_07=Comparar real vs. presupuesto'.

* ==============================================================================
* Gráfico 4: Mejores Prácticas Empresas Familiares (dim J) — ítems.
*   Objetivo: visualizar la dimensión más baja (media=3.50), con énfasis en
*   sucesión y consejo familiar.
*   Tipo: barras simples de medias.
* ==============================================================================.
GRAPH /BAR(SIMPLE)=MEAN(j_01 j_02 j_03 j_04)
  /TITLE='Ítems de Mejores Prácticas Familiares (dimensión J)'
  /FOOTNOTE='j_01=Consejo familiar  j_02=Plan sucesión  j_03=Diferencia intereses  j_04=Directivos no familiares'.

* ==============================================================================
* Gráfico 5: Mejores prácticas familiares por tamaño de empresa.
*   Objetivo: comparar dim_j entre pequeñas (119) y medianas (17).
*   Tipo: barras agrupadas.
* ==============================================================================.
GRAPH /BAR(GROUPED)=MEAN(dim_j) BY tamano_empresa
  /TITLE='Mejores prácticas familiares por tamaño de empresa'
  /FOOTNOTE='Pequeña (n=119)  Mediana (n=17).'

* ==============================================================================
* Gráfico 6: Presupuestación financiera por años de permanencia.
*   Objetivo: explorar si empresas con más años presupuestan más.
*   Tipo: barras simples.
* ==============================================================================.
GRAPH /BAR(SIMPLE)=MEAN(dim_b) BY anos_permanencia
  /TITLE='Presupuestación financiera por años de permanencia'
  /FOOTNOTE='Años de operación de la empresa.'

* ==============================================================================
* FIN — Exportar gráficos 1-6 como PNG desde el Visor.
* ==============================================================================.
ECHO "Gráficos generados. Exportar desde el Visor como PNG → results/ (grafico01.png .. grafico06.png).".
ECHO "Ejecutar sync.sh después de exportar para sincronizar con repositorio".
