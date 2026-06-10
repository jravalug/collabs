# Changelog

## [Unreleased]

- Initial project setup: directory structure created, raw files ingested.

## [2026-06-09]

- Added AGENTS.md with project conventions and 9-step workflow.
- Created `.gitignore` and `template/` directory skeleton.
- Converted .docx instrument → `docs/instrumento.md`.
- Converted .xlsx responses → `data/raw/respuestas.csv`.
- Created `src/clean.py`: fixes misaligned rows, standardizes categories, reverse-codes 4 items, auto-generates `docs/data_dictionary.md`.
- Created `docs/metodologia.md` with 10 sections.
- Created `spss/analisis.sps` with 12 analysis blocks (exhaustive, +/BARCHART FREQ).
- Created `spss/graficos.sps` with 6 selective graphs.
- Created `sync.sh` at repo root.
- Updated paths in .sps files from `C:\Users\...` to `D:\collabs\...`.
- Jose ran `analisis.sps` in SPSS: 49 bar PNGs, `tablas_analisis.txt`, `.xlsx`, `.spv`.
- Moved `data.sav` from `results/` to `data/processed/`.
- Wrote `docs/conclusiones.md` with 9 sections (incl. plan de acción, limitaciones, gráficos).
- Jose ran `graficos.sps`: 6 chart PNGs + `graficos.txt`.
- Created `docs/normas_editoriales/estudios_gerenciales.md` and `jbe.md`.
- Researched academic references for marco teórico.
- Wrote `docs/marco_teorico.md` (14 references, 3 pp).
- Compiled `output/reporte_final.md` (IMRyD, APA 6.ª, 5 tablas, 6 figuras).
- Converted `output/reporte_final.docx` via pandoc (TNR 12, interlineado 1.5, márgenes 3 cm, carta).
- Synced all deliverables to `/mnt/d/collabs/`.
