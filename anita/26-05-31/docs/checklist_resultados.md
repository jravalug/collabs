# Checklist de resultados a generar en SPSS

Después de correr `spss/analisis.sps` en SPSS, el script **genera automáticamente** 2 archivos a `results/`, y el usuario debe **exportar manualmente** 4 gráficos desde el Visor.

```
26-05-31/
└── results/
    ├── resultados.htm         (Visor exportado, copiar manualmente)
    ├── tablas_analisis.xlsx   (generado por SPSS vía OMS)
    ├── result.png             (gráfico P18, exportado manual)
    ├── result1.png            (gráfico P04, exportado manual)
    ├── result2.png            (gráfico P10, exportado manual)
    └── result3.png            (gráfico P06, exportado manual)
```

## 2 archivos generados automáticamente

| # | Nombre del archivo | Origen | Generado por |
|---|---|---|---|
| 1 | `results/tablas_analisis.xlsx` | Todas las tablas de Frequencies, Reliability, NPar Tests, Descriptives, Crosstabs | BLOQUE 14 (OMS) |
| 2 | `results/resultados.htm` | Visor de SPSS exportado | SPSS (Export del Visor a HTML, manual) |

## 4 gráficos exportados manualmente por el usuario

| # | Nombre del archivo | Origen | Método |
|---|---|---|---|
| 1 | `results/result.png` | Barras cluster P18 | Clic derecho en el Visor > Exportar > PNG |
| 2 | `results/result1.png` | Barras apiladas P04 (actitud) | Clic derecho en el Visor > Exportar > PNG |
| 3 | `results/result2.png` | Barras apiladas P10 (conocimiento crédito) | Clic derecho en el Visor > Exportar > PNG |
| 4 | `results/result3.png` | Barras apiladas P06 (conocimiento ahorro) | Clic derecho en el Visor > Exportar > PNG |

> **Nota**: El archivo principal para análisis posterior es `results/resultados.htm` (Visor de SPSS), que siempre se genera al ejecutar. No se exporta automáticamente a PDF (decisión del usuario).

## Verificación

Después de correr el `.sps`, confirma que `results/` contenga:

```
resultados.htm
tablas_analisis.xlsx
result.png
result1.png
result2.png
result3.png
```

## Si faltan archivos

### `tablas_analisis.xlsx` no se generó
- Revisar el Visor: puede haber un error de sintaxis OMS
- Verificar que SPSS tenga la versión correcta de OMS (v.16+)
- El `OMSEND` debe coincidir con el `OMS`; ya está cableado al final del BLOQUE 11
- Confirmar que la ruta OMS en BLOQUE 14 apunte a `results/`

### Faltan archivos `result.png` / `result1.png` / etc.
- El BLOQUE 15 de auto-export fue deshabilitado en v2.5 (los métodos `SaveAs`/`ExportPicture` no funcionaban en SPSS 26)
- Exportar manualmente desde el Visor: clic derecho sobre cada gráfico > Exportar > PNG
- Los 4 gráficos enfocados están identificados por título en BLOQUE 13: "P18 - Categoría agrupada…", "P04 - Consideras importante…", "P10 - Conoce que es un crédito…", "P06 - Conoce el significado de ahorro…"

### BLOQUE 9 produce una sola tabla Friedman en lugar de dos
- v2.6 debería producir dos tablas: una para Secundaria y otra para Bachillerato
- Si solo aparece una, verificar que el BLOQUE 9 contiene dos `NPAR TESTS /FRIEDMAN=...` consecutivos
- Revisar que `TEMPORARY` y `SELECT IF` están escritos correctamente para cada nivel

## Cuando termines

Avísame con un mensaje como:

> "Ya están los archivos en results/"

Yo los leeré con mis herramientas y redactaré:
- Interpretación de los estadísticos descriptivos (medidas de tendencia central por nivel)
- Lectura de las pruebas de hipótesis (Cronbach, Mann-Whitney, Friedman por nivel)
- Conclusiones por dimensión (Conocimiento, Actitud, Comportamiento)
- Implicaciones para el diseño de cursos de educación financiera
- Sección de resultados del reporte
