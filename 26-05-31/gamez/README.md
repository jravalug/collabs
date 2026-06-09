# Educación Financiera en Adolescentes — Autlán de Navarro

Estudio descriptivo-comparativo sobre el nivel de educación financiera en estudiantes de secundaria y bachillerato del municipio de Autlán de Navarro, Jalisco. Cuestionario estructurado con 14 ítems Likert + 4 ítems demográficos, aplicado a 656 adolescentes.

## Estructura del proyecto

```
26-05-31/
├── README.md                       Este archivo (navegación)
├── CHANGELOG.md                    Historial de versiones del SPSS
│
├── data/                           Datos del estudio
│   ├── raw/
│   │   └── data.csv                Base original (1036 filas, 32 cols) — NO modificar
│   └── processed/
│       ├── data_normalizado.csv    Primera limpieza (columnas, encoding)
│       └── data_analisis.csv       Base final para SPSS (656 filas, 30 cols)
│
├── src/                            Scripts de preprocesamiento Python
│   ├── normalizar.py               Etapa 1: normalización de columnas
│   └── segunda_pasada.py           Etapa 2: limpieza, recodificación, derivadas
│
├── spss/                           Scripts de análisis estadístico
│   ├── analisis.sps                Script principal SPSS (16 bloques)
│   └── changelog/                  Versiones anteriores del .sps (trazabilidad)
│
├── docs/                           Documentación del estudio
│   ├── cuestionario.md             Instrumento original
│   ├── data_dictionary.md          Diccionario de las 30 variables
│   ├── metodologia.md              Metodología completa (10 secciones)
│   ├── ejecucion_spss.md           Cómo ejecutar el .sps en SPSS
│   ├── checklist_resultados.md     Archivos esperados al ejecutar SPSS
│   ├── conclusiones_analisis.md     Conclusiones del estudio (estructura académica + APA)
│   └── transformaciones_log.csv    Bitácora auditable de cambios
│
├── results/                        Salidas de SPSS (se llenan al ejecutar)
│   ├── resultados.htm              Visor de SPSS (archivo principal)
│   ├── tablas_analisis.xlsx        Tablas en Excel (vía OMS)
│   ├── tablas_analisis.txt         Visor exportado a texto plano
│   ├── tablas_analisis.png         Cluster P18
│   ├── tablas_analisis1.png        Apiladas P04 (actitud)
│   ├── tablas_analisis2.png        Apiladas P10 (crédito)
│   └── tablas_analisis3.png        Apiladas P06 (ahorro)
│
└── archive/                        Respaldos históricos (NO usar)
    ├── data_normalizado.backup_*.csv
    └── metodologia.backup_*.md
```

## Flujo de trabajo

```
data/raw/data.csv
       │
       ▼ (python src/normalizar.py)
data/processed/data_normalizado.csv
       │
       ▼ (python src/segunda_pasada.py)
data/processed/data_analisis.csv  +  docs/data_dictionary.md  +  docs/transformaciones_log.csv
       │
       ▼ (SPSS: abrir spss/analisis.sps y ejecutar)
results/resultados.htm  +  results/tablas_analisis.xlsx  +  results/grafico_*.png
```

## Cómo usar este proyecto

### 1. Re-procesar datos desde cero
```bash
cd <raíz del proyecto>
python src/normalizar.py
python src/segunda_pasada.py
```

### 2. Ejecutar análisis en SPSS
1. Abrir SPSS Statistics v.26+
2. **Archivo > Abrir > Sintaxis** → seleccionar `spss/analisis.sps`
3. **Ejecutar > Todo** (Ctrl+A, Ctrl+R)
4. Al terminar, copiar `results/resultados.htm` a la carpeta de trabajo
5. Avisarme para que redacte las conclusiones

Detalles completos en [`docs/ejecucion_spss.md`](docs/ejecucion_spss.md).

## Resumen del estudio

- **Población**: estudiantes de secundaria (319) y bachillerato (337) en Autlán de Navarro
- **Instrumento**: cuestionario con 14 ítems Likert (5 opciones) + 4 ítems demográficos + 1 pregunta abierta
- **Dimensiones evaluadas**:
  - **Conocimiento financiero** (8 ítems): ahorro, crédito, presupuesto, inversión, inflación, tarjeta
  - **Actitud hacia la EF** (4 ítems): exposición, significado, interés, importancia
  - **Comportamiento financiero** (2 ítems dicotómicos + 1 Likert): cuenta de ahorro, ahorro informal
- **Análisis estadístico**:
  - Frecuencias y medidas de tendencia central por nivel
  - 15 chi-cuadrado (perfil sociodemográfico) + 4 chi-cuadrado (P18 × subgrupos)
  - Alfa de Cronbach (global + subescalas)
  - Test de Friedman con `TEMPORARY + SELECT IF` por nivel (sustituye a W de Kendall)
  - Mann-Whitney U (2 colas) para comparar puntajes entre niveles
  - Mann-Whitney U (2 colas) para comparar puntajes entre niveles

## Referencias metodológicas

- New Taipei City Financial Literacy Study (Chen & Volpe, 1998, 2002)
- FLSADO - Financial Literacy Scale for Adolescents (Amagir et al., 2018)
- BBVA Edufin - Encuesta de educación financiera
- OCDE/INFE Toolkit 2022 - 3 dimensiones
- PISA Financial Literacy framework

## Estado del proyecto

| Componente | Estado |
|---|---|
| Preprocesamiento de datos | ✅ Completado (656 casos, 30 variables) |
| Metodología | ✅ Reescrita y revisada |
| Script SPSS | ✅ Versión 2.6 (13 bloques; BLOQUE 9 con `TEMPORARY+SELECT IF`; 15 y 16 eliminados) |
| Ejecución SPSS | ✅ Completada (v2.6) |
| Conclusiones | ✅ Redactadas en `docs/conclusiones_analisis.md` |

## Contacto

Para preguntas o colaboración: ver carpeta de trabajo original del proyecto.
