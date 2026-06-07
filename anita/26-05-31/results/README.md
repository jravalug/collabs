# `results/` — Salidas de SPSS

Esta carpeta recibe los archivos generados al ejecutar `spss/analisis.sps` en IBM SPSS Statistics v.26+.

## Archivos en esta carpeta (tras la última ejecución v2.6)

| Archivo | Contenido | Generado por |
|---|---|---|
| `tablas_analisis.txt` | Visor completo de SPSS exportado a texto plano (440 KB, 3 140 líneas) | Export manual del Visor (Visor > Exportar > Text) |
| `tablas_analisis.xlsx` | Todas las tablas de Frequencies, Reliability, NPar Tests, Descriptives, Crosstabs (52 KB) | BLOQUE 14 (OMS) |
| `tablas_analisis.png` | Barras cluster P18 (preferencias formativas) | Export manual desde el Visor (clic derecho > Exportar > PNG) |
| `tablas_analisis1.png` | Barras apiladas P04 (importancia educación financiera) | Export manual desde el Visor |
| `tablas_analisis2.png` | Barras apiladas P10 (conoce qué es un crédito) | Export manual desde el Visor |
| `tablas_analisis3.png` | Barras apiladas P06 (conoce el significado de ahorro) | Export manual desde el Visor |

> **Nota**: los nombres `tablas_analisis*.png` provienen de la exportación del Visor de SPSS. El script v2.6 ya no genera nombres fijos (v2.5 usaba `grafico_1.png`…`grafico_4.png`); SPSS asigna el nombre automáticamente al exportar.

## Cambio metodológico importante (v2.6)

- **BLOQUE 9 (Friedman)** ahora se ejecuta por separado para cada nivel educativo usando `TEMPORARY + SELECT IF` en lugar de `SPLIT FILE` (que fallaba con error 4757 por el elevado número de variables de cadena del dataset). El TXT contiene dos tablas "Prueba de Friedman": una para Secundaria (N=317, χ²=1056,646, p<.001) y otra para Bachillerato (N=335, χ²=1066,556, p<.001).
- **BLOQUE 15 y BLOQUE 16** eliminados. La verificación final debe hacerse manualmente revisando el Visor y los archivos generados.

## Archivo principal para análisis

`tablas_analisis.txt` es el archivo que se lee para extraer los valores estadísticos reportados en `docs/conclusiones_analisis.md`. Contiene todas las tablas de salida con sus estadísticos, valores p y notas metodológicas de SPSS.
