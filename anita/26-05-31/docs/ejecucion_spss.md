# Instrucciones de ejecución del análisis SPSS

## Archivo
`spss/analisis.sps` — Sintaxis para IBM SPSS Statistics v.26 o superior.

## Requisitos
- SPSS v.26+ instalado
- Estructura de proyecto tal como se describe en el [README raíz](../README.md)
- Archivo `data/processed/data_analisis.csv` accesible
- Codificación UTF-8 del CSV
- El CSV usa separador `;` (punto y coma)
- SPSS con Python Essentials (incluido por defecto v.22+)

## Pasos para ejecutar

1. Abrir el archivo `spss/analisis.sps` con un editor de texto plano (Bloc de notas, Notepad++ o VSCode)
2. Verificar las **3 rutas** de la cabecera (FILE HANDLE, OMS, Python) coincidan con la nueva estructura:
   - **Entrada** (FILE HANDLE): `C:\...\26-05-31\data\processed\`
   - **Salida tablas** (OMS): `C:\...\26-05-31\results\tablas_analisis.xlsx`
   - **Salida gráficos** (Python): `C:\...\26-05-31\results\`
3. Si la carpeta está en otra ubicación, editar esas 3 líneas con la nueva ruta (recordar dobles barras invertidas `\\` en Windows)
4. Guardar el `.sps`
5. Abrir SPSS Statistics
6. **Archivo > Abrir > Sintaxis...** y seleccionar `spss/analisis.sps`
7. **Ejecutar > Todo** (o `Ctrl + A` y luego `Ctrl + R`)
8. Los resultados aparecen en el **Visor de SPSS**
9. Al final se exportan automáticamente las tablas a `results/tablas_analisis.xlsx` y los gráficos a `results/grafico_1.png`...`results/grafico_4.png`

## Bloques que ejecuta (13 en total)

| # | Bloque | Produce |
|---|---|---|
| 1 | Configuración | Define `FILE HANDLE` con la ruta de la carpeta |
| 2 | Importación | Carga el CSV (656 casos, 30 variables) |
| 3 | Etiquetas | Asigna etiquetas y valores a las variables |
| 4 | Recodificación | Crea `p07_rec` y `p17_rec` (0/1) a partir de strings |
| 5 | Puntajes | Crea `puntaje_conocimiento`, `puntaje_actitud`, `puntaje_comportamiento` |
| 6 | Frecuencias | Medidas de tendencia central (moda, mediana, media, DE, mín, máx) por nivel |
| 7 | Crosstabs | 15 chi-cuadrado del perfil sociodemográfico |
| 8 | Cronbach | α global (14 Likert) + α Conocimiento (8) + α Actitud (4) |
| 9 | Friedman | **Dos** ejecuciones con `TEMPORARY + SELECT IF`: una para Secundaria y otra para Bachillerato (sustituye a W de Kendall) |
| 10 | Mann-Whitney | 2 colas para los 3 puntajes compuestos entre niveles |
| 11 | P18 | Frecuencias + 4 Crosstabs por subgrupos demográficos |
| 12 | (Eliminado) | Exportación a PDF deshabilitada (no se usa); usuario copia `resultados.htm` |
| 13 | Gráficos | 4 gráficos enfocados (P18, P04, P10, P06) |
| 14 | OMS | Enruta tablas a `results/tablas_analisis.xlsx` |
| 15 | (Eliminado) | Conteo de gráficos en el Visor (no aportaba valor diagnóstico) |
| 16 | (Eliminado) | Verificación APROBADO/REQUIERE ATENCION (mezclaba advertencias no críticas con errores reales) |

**Orden de ejecución interno**: el script está numerado por orden lógico, pero el bloque OMS (14) se inserta donde se necesita: se abre antes de los análisis para enrutar las tablas y se cierra al final del BLOQUE 11 con `OMSEND`. Los gráficos (13) se generan al final como material visual complementario.

**Cambio importante en BLOQUE 9 (v2.6)**: la segmentación por nivel se implementa con `TEMPORARY + SELECT IF` en lugar de `SPLIT FILE`. SPSS lanzaba error 4757 con `SPLIT FILE` por el límite de 8 variables de archivo segmentado, agotado por las 15+ variables string del dataset. Con `TEMPORARY + SELECT IF` se obtienen dos tablas "Prueba de Friedman" separadas, una por nivel educativo.

## Resultados esperados (referencia)

### Mann-Whitney (BLOQUE 10)
- **U** y **Z** entregados por SPSS
- **Tamaño del efecto r de Rosenthal**: `r = Z / √N`
- Interpretación: r ≈ 0.10 efecto pequeño, ≈ 0.30 mediano, ≈ 0.50 grande (Cohen, 1988)
- **2 colas** (conservadora, defendible para estudio exploratorio)

### Cronbach (BLOQUE 8)
- α ≥ 0.70 aceptable
- α ≥ 0.80 bueno
- α ≥ 0.90 excelente (Tavakol & Dennick, 2011)

### Friedman (BLOQUE 9)
- H₀: las distribuciones de los 14 ítems Likert son similares entre respondedores
- p < 0.05 indica que al menos un ítem tiene distribución diferente
- **v2.6 produce dos tablas** (Secundaria y Bachillerato), no una combinada

## Solución de problemas

**Error de encoding**: verificar que el CSV esté en UTF-8 y que `ENCODING='UTF8'` esté correcto.

**"Variable not found"**: confirmar que la ruta del CSV en `GET DATA` es correcta y que el archivo tiene 30 columnas con los nombres esperados.

**Error 2269 "No se puede abrir el archivo"**: la ruta en `FILE HANDLE carpeta` no apunta a la carpeta correcta. Editar esa línea en el `.sps` con la ruta absoluta de `data/processed/`.

**"Warning: no se puede calcular Friedman con N pequeña"**: si un nivel educativo tiene menos de ~30 casos válidos en los 14 ítems, SPSS puede omitir la prueba. En este estudio: Secundaria=319 y Bachillerato=337, ambos suficientes.

**Variable de Mann-Whitney**: el script crea automáticamente `nivel_num` (numérica 1=Secundaria, 2=Bachillerato) a partir de `nivel_agrupado` (string). Si el bloque 10 falla por variable de cadena, verificar que el bloque 5 (cómputo de puntajes) terminó sin errores antes de llegar a Mann-Whitney.

**Friedman produce solo una tabla en lugar de dos (v2.6)**: verificar que el bloque 9 se ejecutó completo (debe contener dos `NPAR TESTS /FRIEDMAN=...` consecutivos). Si solo aparece una, revisar que ningún `TEMPORARY` quedó huérfano de su `NPAR TESTS` correspondiente.

## Cómo compartir los resultados conmigo (después de correr el .sps)

El script genera automáticamente dos archivos en la carpeta `results/`:

- `results/resultados.htm` (Visor de SPSS exportado; archivo principal para verificar los análisis)
- `results/tablas_analisis.xlsx` (todas las tablas en Excel, vía OMS)

El usuario debe exportar **manualmente** los 4 gráficos enfocados (P18, P04, P10, P06) desde el Visor: clic derecho sobre cada gráfico > Exportar > PNG, y guardarlos como `result.png`, `result1.png`, `result2.png`, `result3.png` en `results/`.

Después de correr el script, simplemente avísame con un mensaje como:

> "Ya están los archivos en la carpeta"

Yo los leeré con mis herramientas y redactaré las conclusiones. Ver `checklist_resultados.md` (en la misma carpeta `docs/`) para los detalles.

## Si SPSS no está disponible

Como respaldo, los mismos análisis pueden ejecutarse en Python:

```python
import pandas as pd
from scipy import stats

df = pd.read_csv('../data/processed/data_analisis.csv', sep=';', encoding='utf-8')
# ... análisis equivalentes ...
```

Script de respaldo disponible bajo solicitud.
