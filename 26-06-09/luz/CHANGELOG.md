# Changelog

## [2026-06-09]

- Created directory structure following project template.
- Ingested raw files (.xlsx → `data/raw/`, .docx → `data/raw/`).
- Converted .xlsx → `data/raw/respuestas.csv`, .docx → `docs/metodologia.md`.
- Created `src/clean.py`: normalizes edad/antigüedad, standardizes categories, auto-generates `docs/data_dictionary.md` and `docs/transformaciones_log.csv`.
- Wrote `docs/metodologia.md` (descriptive-correlational design, 3 hypotheses H₁/H₂/H₃).
- Created `docs/instrumento.md` with full questionnaire transcription.
- Created `docs/marco_teorico.md` with 8 academic references.
- Created `spss/analisis.sps` with 13 analysis blocks (frecuencias, Cronbach, W de Kendall, t-test, Spearman, /BARCHART FREQ).
- Copied `docs/normas_editoriales/` from aaron project.
- Wrote `README.md` and `CHANGELOG.md`.
- Jose ran `analisis.sps` → exported `results/resutl.txt` + 21 PNGs.
- Reviewed SPSS results: all α > .70, all dimensions > neutro (p ≤ .004), Kendall's W only significativo for Satisfacción, Spearman ρ .516–.729 with CS (p ≤ .049), high inter-dimension correlations (ρ > .77).
- Rewrote `docs/conclusiones.md` based on results (9 sections).
- Created `spss/graficos.sps` with 7 selective graphs (box-plot, bar charts).
- Removed Mann-Whitney U from all files (no hypothesis justification).
- Rewrote graficos.sps v2.0: 3 selective graphs (box-plot, means bar, correlations bar).
- Compiled output/reporte_final.md with full IMRyD structure, 8 tables, 3 figures.
- Converted to output/reporte_final.docx via pandoc + formatear_tablas.py (booktabs style).
- Updated CHANGELOG.
