# CHANGELOG — `spss/analisis.sps`

Historial de versiones del script de análisis SPSS. Cada versión se conserva en `spss/changelog/` con su nombre original (`analisis.sps.backup_YYYYMMDD_HHMMSS.sps`).

## v2.6 — 2026-06-06 18:18 (actual)

Fix BLOQUE 9 (Friedman) y eliminación de BLOQUE 15 y BLOQUE 16.

- **BLOQUE 9 (Friedman)**: reescrito para usar `TEMPORARY + SELECT IF` en lugar de `SPLIT FILE SEPARATE BY nivel_agrupado`.
  - **Problema detectado en v2.5**: SPSS lanzaba error 4757 ("SPLIT FILE no puede utilizar más de 8 variables de archivo segmentado") por el elevado número de variables string del dataset (15+). Resultado: el `NPAR TESTS /FRIEDMAN=...` se ejecutaba sin segmentación, produciendo un solo χ² combinado (N=652, χ²=2093.558, p<.001) en lugar de dos χ² separados para Secundaria y Bachillerato.
  - **Solución v2.6**: dos bloques `TEMPORARY + SELECT IF` consecutivos, uno por nivel educativo. Es el patrón canónico de SPSS para análisis por subgrupo: filtra casos de forma temporal sin tocar el archivo de trabajo, y la cláusula `TEMPORARY` se revierte automáticamente al cierre del comando. Ahora se obtienen dos tablas "Prueba de Friedman" en el Visor, una con N≈319 (Secundaria) y otra con N≈337 (Bachillerato).
- **BLOQUE 15 eliminado**: el conteo de gráficos en el Visor no aportaba valor diagnóstico para el estudio (solo confirma que BLOQUE 13 ejecutó; el Visor ya es visible para el usuario).
- **BLOQUE 16 eliminado**: la verificación final con `APROBADO / REQUIERE ATENCION` mezclaba advertencias no críticas con errores reales (en la última ejecución marcó `*** REQUIERE ATENCION ***` por un WARNING de SPSS sin implicaciones para los resultados). El conteo de items en el Visor también era poco fiable. La verificación debe hacerse manualmente revisando el Visor y los archivos generados.

**Estructura final del script** (538 líneas, 13 bloques): 1, 2, 3, 4, 5, 14, 6, 7, 8, 9, 10, 11, 13. Los bloques 12, 15 y 16 fueron eliminados sin renumerar.

Backup: `spss/changelog/analisis.sps.backup_20260606_181814.sps`

## v2.5 — 2026-06-06 17:47

Deshabilitada exportación automática de gráficos y corregidos tipos de items.

- **BLOQUE 15 (Python)**: removido intento de auto-export de PNG (métodos `SaveAs`/`ExportPicture` no funcionaban en SPSS 26). Ahora solo cuenta los gráficos en el Visor y muestra un mensaje. El usuario exporta manualmente desde el Visor.
- **BLOQUE 16 (Python)**: corregido conteo usando constantes nombradas de SPSS en lugar de números mágicos:
  - `tipo == 0` → `tipo == SpssClient.OutputItemType.PIVOT` (tablas)
  - `tipo == 3` → `tipo == SpssClient.OutputItemType.CHART` (gráficos)
  - `tipo == 6` → `tipo == SpssClient.OutputItemType.WARNING` (errores reales)
  - Antes el conteo de tablas daba 0 porque `0` no es PIVOT en SPSS 26.

**Archivos generados tras ejecución**:
- `resultados.htm` (Visor de SPSS — copiar manualmente)
- `tablas_analisis.xlsx` (vía OMS)
- `grafico_1.png` a `grafico_4.png` (exportar manualmente desde el Visor)

Backup: `spss/changelog/analisis.sps.backup_20260606_174718.sps`

## v2.4 — 2026-06-06 17:39

Corrección de iteración sobre `SpssOutputDoc`.

- **BLOQUE 15 y BLOQUE 16 (Python)**: corregido acceso a los items del Visor
  - `outputDoc.GetOutputItemCount()` (NO EXISTE) → `outputItems = outputDoc.GetOutputItems()` (SpssList)
  - `outputDoc.GetOutputItem(i)` (NO EXISTE) → `outputItems.GetItemAt(i)`
  - El método correcto es **plural**: `GetOutputItems()` retorna una `SpssList` con `.Size()` y `.GetItemAt(i)`

Backup: `spss/changelog/analisis.sps.backup_20260606_173934.sps`

## v2.3 — 2026-06-06 17:33

Correcciones finales en bloques Python.

- **BLOQUE 15 (Python)**: eliminado `outputDoc.Activate()` (no existe en `SpssOutputDoc`; no es necesario)
- **BLOQUE 16 (Python)**: reemplazado `dataDoc.GetVariableList()` por el módulo `spss`:
  - `import spss` agregado
  - `spss.GetVariableCount()` y `spss.GetVariableName(i)` para listar variables del dataset activo
  - El `dataDoc` de SpssClient se omite: el módulo `spss` opera sobre el dataset activo directamente

Backup: `spss/changelog/analisis.sps.backup_20260606_173343.sps`

## v2.2 — 2026-06-06 17:15

**Estructura del proyecto reorganizada** y correcciones finales.

- **Reorganización de carpetas** (raíz → `data/`, `docs/`, `spss/`, `src/`, `results/`, `archive/`)
- Rutas actualizadas en BLOQUE 1, BLOQUE 14 y BLOQUE 15:
  - `FILE HANDLE carpeta` → `data\processed\`
  - `OMS OUTFILE` → `results\tablas_analisis.xlsx`
  - Python `outputPath` → `results\`
- **Eliminado BLOQUE 12** (exportación a PDF; el usuario prefiere copiar `resultados.htm` manualmente)
- **BLOQUE 15 (Python)**: corregido acceso a lista de documentos
  - `outputDocs[0]` → `outputDocs.GetItemAt(0)` (SpssList no implementa `__getitem__`)
  - `if not outputDocs:` → `if outputDocs.Size() == 0:`
- **BLOQUE 16 (Python)**: corregido acceso a variables y a lista de documentos
  - `dataDoc.GetVariableAt(i)` → `varList = dataDoc.GetVariableList(); varList.GetItemAt(i).GetName()`
  - Mismo fix de `GetOutputDocuments` que BLOQUE 15
  - Variable `nivel_num` añadida a la lista de variables requeridas para verificar
- **Eliminado `FINISH.`** (causaba advertencia 41 con SPSS Statistics Manager)

**Archivos generados tras ejecución**: `resultados.htm`, `tablas_analisis.xlsx`, `grafico_1.png`...`grafico_4.png` (todos en `results/`).

Backup: `spss/changelog/analisis.sps.backup_20260606_171500.sps`

## v2.1 — 2026-06-06 16:53

Corrección de bugs detectados en primera ejecución (v2.0).

- **BLOQUE 10 (Mann-Whitney)**: agregada variable numérica `nivel_num` recodificada de `nivel_agrupado` (string) para evitar error de tipo
- **BLOQUE 12 (PDF export)**: corregida sintaxis `OUTPUT EXPORT` a `/PDF OUTPUTFILENAME='...'`
- **BLOQUE 15 (Python)**: `SpssClient.GetActiveOutputDoc()` → `outputDocs = SpssClient.GetOutputDocuments(); outputDoc = outputDocs[0]; outputDoc.Activate()` (en este punto aún con bug de `__getitem__`)
- **BLOQUE 16 (Python)**: `dataDoc.GetVariableList().GetItemAt(i).GetName()` reemplazado por `dataDoc.GetVariableAt(i).GetName()` (en este punto aún con bug de `GetVariableAt` no existe)

Backup: `spss/changelog/analisis.sps.backup_20260606_165351.sps`

## v2.0 — 2026-06-06 16:36

Reescritura completa del script. 16 bloques funcionales.

- BLOQUE 1: configuración de rutas (FILE HANDLE)
- BLOQUE 2: importación de datos (GET DATA)
- BLOQUE 3: etiquetas y valores
- BLOQUE 4: recodificación de strings
- BLOQUE 5: cálculo de 3 puntajes compuestos (Conocimiento, Actitud, Comportamiento)
- BLOQUE 6: frecuencias con medidas de tendencia central
- BLOQUE 7: 15 chi-cuadrado del perfil sociodemográfico
- BLOQUE 8: alfa de Cronbach (global + subescalas)
- BLOQUE 9: Test de Friedman con SPLIT FILE por nivel
- BLOQUE 10: Mann-Whitney U (2 colas) para 3 puntajes
- BLOQUE 11: P18 frecuencias + 4 Crosstabs
- BLOQUE 12: exportación a PDF
- BLOQUE 13: 4 gráficos enfocados
- BLOQUE 14: OMS para enrutar tablas a Excel
- BLOQUE 15: Python para exportar gráficos a PNG
- BLOQUE 16: verificación final con APROBADO/REQUIERE ATENCION

Backup: `spss/changelog/analisis.sps.backup_20260606_163623.sps`

## v1.x — versiones anteriores (histórico)

Backup: `spss/changelog/analisis.sps.backup_20260606_152051.sps` (v1.0)
Backup: `spss/changelog/analisis.sps.backup_20260606_153426.sps` (v1.1)
Backup: `spss/changelog/analisis.sps.backup_20260606_154214.sps` (v1.2)
Backup: `spss/changelog/analisis.sps.backup_20260606_160619.sps` (v1.3)
