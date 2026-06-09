# AGENTS.md — collabs

Refer to the user as **Jose**.

Academic collaboration monorepo, organized by date (`YYYY-MM-DD/project-name/`).

## Repository conventions

- **Language:** `AGENTS.md` → English. All project documents (`README.md`, `docs/`, reports) → **academic-cientific Spanish**.
- **Tabular data** → `.csv`. Word docs → convert `.docx` → `.md` (`pandoc file.docx -o file.md`). Final deliverables → `.md` → `.docx` (`pandoc file.md -o file.docx`). XLSX → CSV via Excel export.
- **Python scripts** in `src/` → stdlib only (no pip, no pandas, no requirements.txt).
- **All projects must follow the template structure below.**

## Standard workflow

```
1. Ingest   → data/raw/ (original .xlsx, .docx)
2. Convert  → .xlsx→.csv (Excel), .docx→.md (pandoc)
3. Process  → src/*.py (stdlib) → data/processed/.csv
4. Analyze  → draft spss/analisis.sps from data dictionary
5. Execute  → Jose runs SPSS locally, copies results to results/
6. Conclude → docs/conclusiones.md
7. Deliver  → pandoc → output/reporte_final.docx
```

## Project template

```
YYYY-MM-DD/project-name/
├── README.md            Academic overview (ES)
├── CHANGELOG.md         Script and analysis version history
├── data/
│   ├── raw/             Original files: .xlsx, .docx, .csv (immutable)
│   └── processed/       Cleaned data: .csv, .sav
├── docs/                Academic docs in ES: .md
├── src/                 Processing scripts: .py (stdlib only)
├── spss/                SPSS syntax: .sps
├── results/             SPSS output: .txt, .xlsx, .png, .spv
├── output/              Final deliverables: .md → .docx
└── archive/             Historical backups
```
