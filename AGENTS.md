# AGENTS.md — collabs

## Guiding principle: scientific rigor

All research in this repository must be governed by scientific rigor as a
fundamental, cross-cutting principle. Scientific rigor demands:

1. **Strict application of the scientific method** — robust and reproducible
   design, explicit and justified methodology, sound statistical analysis
   (effect size, power, assumptions), and unbiased interpretation of results.

2. **Validity and reliability** — ensure content validity (the instrument
   covers the construct), criterion validity (predictive), and construct
   validity (theoretical coherence). Report and discuss reliability
   (Cronbach's alpha, internal consistency) and document any deviation
   from accepted thresholds.

3. **Transparency and reproducibility** — document every methodological
   decision (cleaning, transformations, exclusion criteria), report
   complete results (including non-significant ones), and provide
   sufficient detail for any independent researcher to reproduce the
   analysis.

4. **Intellectual honesty** — explicitly acknowledge and discuss
   limitations (sample size, biases, design, missing data), avoid logical
   fallacies (confirmation bias, spurious causality), and report negative
   or contradictory findings. Limitations do not invalidate a study, but
   they must be declared.

5. **Epistemological coherence** — align research question, objectives,
   design, statistical methods, and conclusions. The methodology must be
   appropriate to the variable types, measurement scale, and the question
   being answered.

6. **Pertinence and relevance** — research must be contextualized within
   existing literature, justify its contribution to knowledge, and be
   grounded in prior evidence (systematic literature review at project
   outset).

These principles apply to every stage of the workflow: ingestion,
conversion, cleaning, analysis, interpretation, and report writing.

---

Refer to the user as **Jose**.

Academic collaboration monorepo, organized by date (`YYYY-MM-DD/project-name/`).

## Repository conventions

- **Language:** `AGENTS.md` → English. All project documents (`README.md`, `docs/`, reports) → **academic Spanish**.
- **Tabular data** → `.csv`. Word docs → convert `.docx` → `.md` (`pandoc file.docx -o file.md`). Final deliverables → `.md` → `.docx` (`pandoc file.md -o file.docx`). XLSX → CSV via Excel export or Python stdlib script (zipfile + xml).
- **Python analysis scripts** → managed with `uv`. Run `uv sync` after cloning or when dependencies change. Always use `uv add <pkg>` for new packages. Execute scripts with `uv run python src/<script>.py`.
- **Validate column alignment** after CSV conversion: check demographics columns for expected value types. Fix rows shifted by empty cells.
- **Normalize category labels**: extract base category before the first parenthesis when form exports include verbose option labels.
- **Auto-generate `docs/data_dictionary.md`** from the cleanup script, documenting every variable (name, type, values, description, scale).
- **Editorial norms**: All reports and manuscripts follow the reference standards saved in `project/docs/normas_editoriales/`. Primary reference: `estudios_gerenciales.md` — Times New Roman 12, 1.5 line spacing, 3 cm margins, APA 6th ed., max 30 pages, IMRaD structure, anonymity, impersonal tone. Supplementary reference: `jbe.md` for English-language targets. Check these files before drafting any deliverable.
- **Reverse-code negative Likert items** (`col_inv = 6 - val`) so higher scores consistently mean better outcomes across all dimensions.
- **Research similar studies online** at project start: search academic sources (Google Scholar, SciELO, RedALyC, Scopus) on the same topic to guide analytical decisions (test selection, thresholds, coding conventions). Cite sources in the methodology.
- **Adapt methodology to the data**: not all projects use the same tests. Select statistical procedures based on the actual data (sample size, distributions, variable types, research questions). Methodology must be consistent with both the available data and similar studies found in the literature review.
- **Descriptive foundation**: social research uses scales, dichotomous, and nominal variables. Always compute frequencies and central tendency for every variable. Choose measure by type: mode for nominal/categorical, median for ordinal, mean for scale.
- **Likert descriptive tables (ordinal)**: Use 9-column format: Ítem, Dimensión, Descripción, 5, 4, 3, 2, 1, Moda. Each level column shows `f (%)`. Do NOT include mean or SD in the table (they are ordinal, not interval).
- **Markdown table alignment**: Before pandoc conversion, set alignment separators explicitly: `:---` for text columns (left), `---:` for numeric columns (right). This is required for proper docx formatting downstream.
- **Conclusions must align with methodology**: `docs/conclusiones.md` must address every element specified in `docs/metodologia.md` — sample characterization, reliability thresholds, item-level statistics (frequencies, mode, median where required), all planned inferential tests, and documented limitations. Any deviation must be explicitly justified.
- **Two-phase SPSS**: `analisis.sps` produces all tables (frequencies, alfa, Kendall, t-test) plus frequency bar charts for every item via `/BARCHART FREQ` (exhaustive). `graficos.sps` is created later with only the graphs needed to illustrate the conclusions (selective). Graph type depends on the finding (bar, stacked bar, cluster, box plot, etc.).
- **Bidirectional sync**: `sync.sh` at repo root syncs between `/home/.../collabs` (git, agent workspace) and `/mnt/d/collabs` (SPSS on Windows). On-demand: Jose requests sync, script analyzes diffs, routes files by type to correct directories, and verifies. Run `./sync.sh --dry-run` to preview.
- **Table style (booktabs)**: All `.docx` tables must be post-processed with `src/formatear_tablas.py` after pandoc conversion. This applies the booktabs style: full page width, text columns left-aligned (`:---`), numeric columns right-aligned (`---:`), no vertical borders, horizontal borders only under the header and at the bottom of the table.
- Jose exports tables as `.txt` and charts as `.png` from the Viewer to `results/`.
- **Commit messages**: Use Conventional Commits: `tipo(alcance): descripción imperativa`. Tipos: `feat`, `fix`, `docs`, `refactor`, `chore`. Scope optional. First line ≤50 characters.
- **All projects must follow the template structure below.**

- **No fabricated author names**: If a project's documents do not explicitly state an author, do not add one. Never copy an author name from another project — each project must be treated independently. Use no author or a placeholder only after asking Jose.
- **Reference doc**: Generate `reference.docx` via `python src/crear_referencia.py` at repo root before any pandoc conversion. This sets Times New Roman 12, 1.5 line spacing, 3 cm margins, letter size.
- **Locked files**: If `sync.sh` fails with "Permission denied", a Word lock file (`~$*.docx`) may exist in the target. Close Word on Windows or delete the `~$` file before retrying.

## Standard workflow

```
0. Scaffold → create project directory structure from template
1. Ingest   → data/raw/ (original .xlsx, .docx)
2. Convert  → .xlsx→.csv (Excel), .docx→.md (pandoc)
3. Process  → uv run python src/clean.py → data/processed/.csv
4. Analyze  → draft spss/analisis.sps (all tables + /BARCHART FREQ)
5. Execute  → Jose runs analisis.sps in SPSS, exports tables as .txt &
             charts as .png from Viewer to results/
6. Conclude → docs/conclusiones.md (cross-check against metodologia.md; identify needed graphs)
7. Illustrate → draft spss/graficos.sps for target graphs
8. Execute  → Jose runs graficos.sps in SPSS, exports charts as .png
9. Deliver  → pandoc --reference-doc=../../reference.docx output/reporte_final.md -o output/reporte_final.docx
              uv run python src/formatear_tablas.py output/reporte_final.docx
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
├── src/                 Processing scripts: .py
├── spss/                SPSS syntax: .sps
├── results/             SPSS output: .txt, .xlsx, .png, .spv
├── output/              Final deliverables: .md → .docx
├── archive/             Historical backups
└── sync.sh              (repo root) Bidirectional sync helper
```
