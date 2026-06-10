import csv
import os
import re
from collections import Counter
from datetime import datetime

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RAW_CSV = os.path.join(BASE, "data/raw/respuestas.csv")
OUT_CSV = os.path.join(BASE, "data/processed/respuestas.csv")
DICT_PATH = os.path.join(BASE, "docs/data_dictionary.md")
LOG_PATH = os.path.join(BASE, "docs/transformaciones_log.csv")

RAW_HEADERS = [
    "Marca_temporal",
    "Sexo",
    "Edad",
    "Escolaridad",
    "Antiguedad_funcionario",
    "sat_01",
    "sat_02",
    "sat_03",
    "sat_04",
    "cual_01",
    "cual_02",
    "cual_03",
    "cual_04",
    "recom_01",
    "recom_02",
    "recom_03",
    "recom_04",
    "obra_01",
    "obra_02",
    "obra_03",
    "obra_04",
    "cs_01",
    "cs_02",
]

DIMENSIONES = {
    "Satisfacción por el servicio recibido": ["sat_01", "sat_02", "sat_03", "sat_04"],
    "Cualidades de los productos financieros": ["cual_01", "cual_02", "cual_03", "cual_04"],
    "Programas de recompensas": ["recom_01", "recom_02", "recom_03", "recom_04"],
    "Beneficios de obra social": ["obra_01", "obra_02", "obra_03", "obra_04"],
    "Capital social": ["cs_01", "cs_02"],
}

ITEM_DESCRIPTIONS = {
    "sat_01": "Calidad de la atención al socio",
    "sat_02": "Rapidez en la prestación de servicios",
    "sat_03": "Solución de problemas",
    "sat_04": "Profesionalismo del personal",
    "cual_01": "Accesibilidad",
    "cual_02": "Competitividad",
    "cual_03": "Diversidad de productos",
    "cual_04": "Flexibilidad de condiciones",
    "recom_01": "Incentivos económicos",
    "recom_02": "Beneficios preferenciales",
    "recom_03": "Reconocimientos",
    "recom_04": "Programas de fidelización",
    "obra_01": "Apoyo educativo",
    "obra_02": "Programas comunitarios",
    "obra_03": "Actividades sociales",
    "obra_04": "Responsabilidad social cooperativa",
    "cs_01": "Disposición para incrementar aportaciones de los socios",
    "cs_02": "Permanencia y crecimiento de socios",
}

LIKERT_VALS = {"1", "2", "3", "4", "5"}
SEXO_MAP = {"F": "Femenino", "M": "Masculino"}


def normalizar_edad(val):
    val = val.strip().upper()
    val = val.replace("AÑOS", "").replace("AÑO", "").strip()
    if val.isdigit():
        return int(val)
    try:
        return int(float(val))
    except:
        return None


def normalizar_antiguedad(val):
    val = val.strip().upper()
    val = val.replace("AÑOS", "").replace("AÑO", "").strip()
    if val.isdigit():
        return int(val)
    try:
        return int(float(val))
    except:
        return None


def clean_header(h):
    h = h.replace("\n", " ").replace("\r", "").strip()
    h = h.rstrip(".")
    if ":" in h and not h.startswith("Sexo") and not h.startswith("Antigüedad"):
        h = h.split(":", 1)[-1].strip()
    return h


def main():
    with open(RAW_CSV, encoding="utf-8", newline="") as f:
        reader = csv.reader(f)
        raw_header = next(reader)
        raw_rows = list(reader)

    log = []
    out_rows = []

    for i, row in enumerate(raw_rows):
        if len(row) < 23:
            continue
        r = row[:23]

        d = {}
        changes = []

        # Marca temporal
        d["Marca_temporal"] = r[0].strip()

        # Sexo
        sexo_orig = r[1].strip().upper()
        sexo_new = SEXO_MAP.get(sexo_orig, sexo_orig)
        d["Sexo"] = sexo_new
        if sexo_new != sexo_orig:
            changes.append(("Sexo", sexo_orig, sexo_new, "estandarización"))

        # Edad
        edad_orig = r[2].strip()
        edad_new = normalizar_edad(edad_orig)
        d["Edad"] = str(edad_new) if edad_new is not None else ""
        if edad_new is not None and str(edad_new) != edad_orig:
            changes.append(("Edad", edad_orig, str(edad_new), "normalización a entero"))
        elif edad_new is None and edad_orig:
            changes.append(("Edad", edad_orig, "", "no se pudo normalizar"))

        # Escolaridad
        esc = r[3].strip()
        if "(" in esc:
            esc_base = esc[: esc.index("(")].strip()
            if esc_base != esc:
                changes.append(("Escolaridad", esc, esc_base, "extraer base antes de paréntesis"))
                esc = esc_base
        d["Escolaridad"] = esc

        # Antigüedad
        anti_orig = r[4].strip()
        anti_new = normalizar_antiguedad(anti_orig)
        d["Antiguedad_funcionario"] = str(anti_new) if anti_new is not None else ""
        if anti_new is not None and str(anti_new) != anti_orig:
            changes.append(("Antiguedad_funcionario", anti_orig, str(anti_new), "normalización a entero"))

        # Likert items (columns 5-22 in raw, corresponding to headers 5-22)
        raw_to_code = list(ITEM_DESCRIPTIONS.keys())
        for j, code in enumerate(raw_to_code):
            col = 5 + j
            raw_val = r[col].strip() if col < len(r) else ""
            if raw_val in LIKERT_VALS:
                d[code] = raw_val
            else:
                d[code] = ""

        out_rows.append(d)
        for campo, orig, nuevo, motivo in changes:
            log.append((i + 2, campo, orig, nuevo, motivo))

    # Write cleaned CSV
    with open(OUT_CSV, "w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=RAW_HEADERS)
        w.writeheader()
        w.writerows(out_rows)

    # Write transformation log
    with open(LOG_PATH, "w", encoding="utf-8", newline="") as f:
        w = csv.writer(f)
        w.writerow(["fila", "campo", "valor_original", "valor_nuevo", "motivo"])
        for fila, campo, orig, nuevo, motivo in log:
            w.writerow([fila, campo, orig, nuevo, motivo])

    generate_dictionary(RAW_HEADERS, len(out_rows), ITEM_DESCRIPTIONS, DIMENSIONES)
    print_report(out_rows, raw_rows, log)


def generate_dictionary(header, n_rows, items, dims):
    dict_data = {
        "Marca_temporal": ("str", "Fecha/hora", "Marca de tiempo de la respuesta", "Nominal", ""),
        "Sexo": ("str", "Femenino | Masculino", "Sexo del encuestado", "Nominal", ""),
        "Edad": ("int", "41-58", "Edad del encuestado en años", "Razón", "Normalizada a entero"),
        "Escolaridad": ("str", "Universitaria | Maestría", "Nivel educativo máximo", "Nominal", "Normalizada sin paréntesis"),
        "Antiguedad_funcionario": ("int", "12-28", "Años de experiencia como funcionario", "Razón", "Normalizada a entero"),
    }

    for code, desc in items.items():
        dim = ""
        for dim_name, codes in dims.items():
            if code in codes:
                dim = dim_name
                break
        dict_data[code] = ("int", "1-5", desc, "Likert", f"Dim: {dim}")

    lines = [
        "# Diccionario de Datos",
        "",
        "Archivo: `respuestas.csv`",
        f"Filas: {n_rows}",
        f"Columnas: {len(header)}",
        f"Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
        "",
        "## Dimensiones",
        "",
        "| Dimensión | Ítems | Descripción |",
        "|---|---|---|",
    ]
    for dim_name, codes in dims.items():
        items_list = ", ".join(codes)
        desc = ITEM_DESCRIPTIONS[codes[0]] if codes else ""
        desc = desc[:50] + "..." if len(desc) > 50 else desc
        lines.append(f"| {dim_name} | {items_list} | {dim_name} |")

    lines.extend([
        "",
        "## Variables",
        "",
        "| Variable | Tipo | Valores | Descripción | Escala | Notas |",
        "|---|---|---|---|---|---|",
    ])
    for col in header:
        if col in dict_data:
            tipo, vals, desc, escala, notas = dict_data[col]
            vals = vals.replace("|", "\\|")
            desc = desc.replace("|", "\\|")
            notas = notas.replace("|", "\\|")
            lines.append(f"| `{col}` | {tipo} | {vals} | {desc} | {escala} | {notas} |")

    lines.extend([
        "",
        "## Escala Likert",
        "",
        "- 1 = Totalmente en desacuerdo",
        "- 2 = En desacuerdo",
        "- 3 = Ni de acuerdo ni en desacuerdo",
        "- 4 = De acuerdo",
        "- 5 = Totalmente de acuerdo",
        "",
        "### Notas",
        "",
        "- Todos los ítems están redactados en sentido positivo; no se requirió inversión.",
        "- Edad y Antigüedad se normalizaron eliminando sufijos textuales (\"años\", \"AÑOS\").",
        "- Escolaridad se normalizó extrayendo la categoría base antes del primer paréntesis.",
    ])

    with open(DICT_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"[DICT] {DICT_PATH}")


def print_report(out_rows, raw_rows, log):
    print("=" * 60)
    print("LIMPIEZA COMPLETADA")
    print("=" * 60)
    print(f"Filas originales:  {len(raw_rows)}")
    print(f"Filas finales:     {len(out_rows)}")
    print(f"Columnas:          {len(RAW_HEADERS)}")
    print(f"Transformaciones:  {len(log)}")
    print()

    print("--- Sexo ---")
    for k, v in Counter(r["Sexo"] for r in out_rows).most_common():
        print(f"  {k}: {v}")

    print("\n--- Escolaridad ---")
    for k, v in Counter(r["Escolaridad"] for r in out_rows).most_common():
        print(f"  {k}: {v}")

    print("\n--- Edad ---")
    edades = [int(r["Edad"]) for r in out_rows if r["Edad"].isdigit()]
    if edades:
        print(f"  Rango: {min(edades)}-{max(edades)}")
        print(f"  Media: {sum(edades) / len(edades):.1f}")

    print("\n--- Antigüedad ---")
    antis = [int(r["Antiguedad_funcionario"]) for r in out_rows if r["Antiguedad_funcionario"].isdigit()]
    if antis:
        print(f"  Rango: {min(antis)}-{max(antis)}")
        print(f"  Media: {sum(antis) / len(antis):.1f}")

    print("\n--- Transformaciones registradas ---")
    cambios = Counter(m[4] for m in log)
    for k, v in cambios.most_common():
        print(f"  {v}x  {k}")

    print(f"\n[LOG] {LOG_PATH}")
    print("[OK] Limpieza finalizada.")


if __name__ == "__main__":
    main()
