import csv
import os
from collections import Counter
from datetime import datetime

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RAW_CSV = os.path.join(BASE, "data/raw/respuestas.csv")
OUT_CSV = os.path.join(BASE, "data/processed/data_analisis.csv")
DICT_PATH = os.path.join(BASE, "docs/data_dictionary.md")
LOG_PATH = os.path.join(BASE, "docs/transformaciones_log.csv")

RAW_HEADERS = [
    "tamano_empresa",
    "anos_permanencia",
    "responsabilidad",
    "edad",
    "sexo",
    "escolaridad",
    "a_01", "a_02", "a_03",
    "b_01", "b_02", "b_03", "b_04", "b_05", "b_06", "b_07",
    "c_01", "c_02", "c_03", "c_04", "c_05",
    "d_01", "d_02", "d_03",
    "e_01", "e_02", "e_03", "e_04", "e_05", "e_06", "e_07",
    "g_01", "g_02", "g_03",
    "h_01", "h_02", "h_03",
    "f_01", "f_02", "f_03", "f_04", "f_05", "f_06",
    "i_01", "i_02",
    "j_01", "j_02", "j_03", "j_04",
]

SEXO_VALS = {"Masculino", "Femenino"}
ESCOLARIDAD_VALS = {
    "Ninguno", "Primaria", "Secundaria", "Preparatoria",
    "Técnica", "Técnico", "Universitaria", "Universataria",
    "Postgraduada",
}
LIKERT_VALS = {"1", "2", "3", "4", "5"}

TAMANO_MAP = {
    "Pequeña (De 11 a 50 empleados industria y servicios. De 11 a 30 en comercio. )": "Pequeña",
    "Mediana (De 51 a 250 empleados industria y servicios. De 31 a 100 en comercio.)": "Mediana",
    "Mediana (Más de 10 empleados)": "Mediana",
    "Pequeña (Más de 10 empleados)": "Pequeña",
    "Pequeña (De 51 a 250 empleados industria y servicios. De 31 a 100 en comercio.)": "Pequeña",
    "Pequeña(De 51 a 250 empleados industria y servicios. De 31 a 100 en comercio.)": "Pequeña",
    "Pequeña": "Pequeña",
    "Mediana": "Mediana",
}

ESCOLARIDAD_FIX = {
    "Universataria": "Universitaria",
    "5": "",
}

REVERSE_ITEMS = {"f_01", "f_02", "f_03", "f_05"}


def is_shifted(row):
    edad_val = row[3].strip()
    return edad_val in SEXO_VALS


def fix_alignment(row):
    log_entry = ("edad", row[3], "", "columna desplazada: Edad vacía, sexo en columna edad")
    row.insert(3, "")
    return row, log_entry


def standardize_tamano(val):
    val = val.strip()
    for k, v in TAMANO_MAP.items():
        if val == k:
            return v
    if val.startswith("Pequeña"):
        return "Pequeña"
    if val.startswith("Mediana"):
        return "Mediana"
    return val


def standardize_escolaridad(val):
    val = val.strip()
    if val in ESCOLARIDAD_FIX:
        return ESCOLARIDAD_FIX[val]
    return val


def normalize_likert(val):
    val = val.strip()
    if val in LIKERT_VALS:
        return val
    return ""


def detect_reverse(val):
    return str(6 - int(val)) if val and val.isdigit() and 1 <= int(val) <= 5 else val


def main():
    with open(RAW_CSV, encoding="utf-8", newline="") as f:
        reader = csv.reader(f)
        raw_header = next(reader)
        raw_rows = list(reader)

    log = []
    out_rows = []
    fix_count = 0

    for i, row in enumerate(raw_rows):
        r = row[:49]
        while len(r) < 49:
            r.append("")

        if is_shifted(r):
            r, entry = fix_alignment(r)
            log.append((i + 2, entry[0], entry[1], entry[2], entry[3]))
            fix_count += 1

        d = dict(zip(RAW_HEADERS, r))

        d["tamano_empresa"] = standardize_tamano(d["tamano_empresa"])
        d["escolaridad"] = standardize_escolaridad(d["escolaridad"])

        edad_val = d["edad"].strip()
        if edad_val.isdigit():
            d["edad"] = edad_val
        else:
            d["edad"] = ""

        for col in RAW_HEADERS[6:]:
            d[col] = normalize_likert(d[col])

        for col in REVERSE_ITEMS:
            orig = d[col]
            d[col + "_inv"] = detect_reverse(orig)
            if d[col + "_inv"] != orig:
                log.append((i + 2, col, orig, d[col + "_inv"], "inversión: item negativo recodificado"))

        out_rows.append(d)

    final_headers = RAW_HEADERS[:]
    for col in sorted(REVERSE_ITEMS):
        final_headers.append(col + "_inv")

    with open(OUT_CSV, "w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=final_headers, delimiter=";")
        w.writeheader()
        w.writerows(out_rows)

    with open(LOG_PATH, "w", encoding="utf-8", newline="") as f:
        w = csv.writer(f)
        w.writerow(["fila", "campo", "valor_original", "valor_nuevo", "motivo"])
        for fila, campo, orig, nuevo, motivo in log:
            w.writerow([fila, campo, orig, nuevo, motivo])

    generate_dictionary(final_headers, len(out_rows))
    print_report(out_rows, final_headers, raw_rows, fix_count, log)


def generate_dictionary(header, n_rows):
    dict_data = {
        "tamano_empresa": ("str", "Pequeña | Mediana", "Tamaño de la empresa", "Nominal", ""),
        "anos_permanencia": ("str", "1-5 | 6-10 | 11-15 | 16-20 | 21-30 | 31-40 | 41+", "Años de permanencia en el mercado", "Ordinal", ""),
        "responsabilidad": ("str", "Dueño | Administrador", "Responsabilidad o función que realiza", "Nominal", ""),
        "edad": ("int", "19-48", "Edad del encuestado", "Razón", ""),
        "sexo": ("str", "Masculino | Femenino", "Sexo del encuestado", "Nominal", ""),
        "escolaridad": ("str", "Preparatoria | Técnica | Universitaria | Postgraduada", "Nivel de escolaridad", "Ordinal", "Universataria→Universitaria"),
        "a_01": ("int", "1-5", "A.1 ¿Posee su plan de negocios?", "Likert", "Dim: Desempeño y Estrategias"),
        "a_02": ("int", "1-5", "A.2 ¿Revisa y adecua periódicamente su plan de negocios?", "Likert", ""),
        "a_03": ("int", "1-5", "A.3 ¿Conocen todos los que trabajan el mismo?", "Likert", ""),
        "b_01": ("int", "1-5", "B.1 ¿Realiza proyección de ingresos, gastos y utilidades?", "Likert", "Dim: Presupuestación Financiera"),
        "b_02": ("int", "1-5", "B.2 ¿Revisa esta proyección?", "Likert", ""),
        "b_03": ("int", "1-5", "B.3 ¿Proyección mensual?", "Likert", ""),
        "b_04": ("int", "1-5", "B.4 ¿Proyección trimestral?", "Likert", ""),
        "b_05": ("int", "1-5", "B.5 ¿Proyección semestral?", "Likert", ""),
        "b_06": ("int", "1-5", "B.6 ¿Elabora planes de medidas?", "Likert", ""),
        "b_07": ("int", "1-5", "B.7 ¿Analiza el cumplimiento de planes de medidas?", "Likert", ""),
        "c_01": ("int", "1-5", "C.1 ¿Están definidas responsabilidades y roles?", "Likert", "Dim: Institucionalización"),
        "c_02": ("int", "1-5", "C.2 ¿Tiene instructivos y manuales?", "Likert", ""),
        "c_03": ("int", "1-5", "C.3 ¿Está definida la estructura empresarial?", "Likert", ""),
        "c_04": ("int", "1-5", "C.4 ¿Estructura delimita responsabilidades y autoridad?", "Likert", ""),
        "c_05": ("int", "1-5", "C.5 ¿Existe separación de funciones?", "Likert", ""),
        "d_01": ("int", "1-5", "D.1 ¿Riesgos identificados?", "Likert", "Dim: Controles de Riesgos"),
        "d_02": ("int", "1-5", "D.2 ¿Riesgos jerarquizados por importancia?", "Likert", ""),
        "d_03": ("int", "1-5", "D.3 ¿Medidas para mitigar riesgos?", "Likert", ""),
        "e_01": ("int", "1-5", "E.1 ¿Plan comercial?", "Likert", "Dim: Prácticas de Ventas"),
        "e_02": ("int", "1-5", "E.2 ¿Caracterización de clientes?", "Likert", ""),
        "e_03": ("int", "1-5", "E.3 ¿Productos estrella?", "Likert", ""),
        "e_04": ("int", "1-5", "E.4 ¿Identificación de competidores?", "Likert", ""),
        "e_05": ("int", "1-5", "E.5 ¿Promoción de productos?", "Likert", ""),
        "e_06": ("int", "1-5", "E.6 ¿Canales digitales?", "Likert", ""),
        "e_07": ("int", "1-5", "E.7 ¿Alianzas comerciales?", "Likert", ""),
        "f_01": ("int", "1-5", "F.1 ¿Problemas de liquidez regularmente?", "Likert", "Dim: Finanzas Internas. Negativo→invertido"),
        "f_01_inv": ("int", "1-5", "F.1 invertido (6 - valor original)", "Likert", "Item negativo recodificado"),
        "f_02": ("int", "1-5", "F.2 ¿Dificultades con capital de trabajo?", "Likert", "Negativo→invertido"),
        "f_02_inv": ("int", "1-5", "F.2 invertido (6 - valor original)", "Likert", "Item negativo recodificado"),
        "f_03": ("int", "1-5", "F.3 ¿Problemas en rotación de inventarios?", "Likert", "Negativo→invertido"),
        "f_03_inv": ("int", "1-5", "F.3 invertido (6 - valor original)", "Likert", "Item negativo recodificado"),
        "f_04": ("int", "1-5", "F.4 ¿Cobra con facilidad cuentas pendientes?", "Likert", "Positivo, sin invertir"),
        "f_05": ("int", "1-5", "F.5 ¿Dificultades para pagar proveedores?", "Likert", "Negativo→invertido"),
        "f_05_inv": ("int", "1-5", "F.5 invertido (6 - valor original)", "Likert", "Item negativo recodificado"),
        "f_06": ("int", "1-5", "F.6 ¿Negociaciones con proveedores?", "Likert", "Positivo, sin invertir"),
        "g_01": ("int", "1-5", "G.1 ¿Negocia financiamiento a menor costo?", "Likert", "Dim: Negociación Financiera"),
        "g_02": ("int", "1-5", "G.2 ¿Negocia reestructuración de deudas?", "Likert", ""),
        "g_03": ("int", "1-5", "G.3 ¿Flujos financieros positivos?", "Likert", ""),
        "h_01": ("int", "1-5", "H.1 ¿Capacitación al personal?", "Likert", "Dim: Recursos Humanos"),
        "h_02": ("int", "1-5", "H.2 ¿Motiva al personal?", "Likert", ""),
        "h_03": ("int", "1-5", "H.3 ¿Pagos por resultados?", "Likert", ""),
        "i_01": ("int", "1-5", "I.1 ¿Revisa portafolio vs competencia?", "Likert", "Dim: Ventajas Competitivas"),
        "i_02": ("int", "1-5", "I.2 ¿Adecúa portafolio según revisión?", "Likert", ""),
        "j_01": ("int", "1-5", "J.1 ¿Medidas para armonía familiar?", "Likert", "Dim: Mejores Prácticas Emp. Familiares"),
        "j_02": ("int", "1-5", "J.2 ¿Consejo familiar?", "Likert", ""),
        "j_03": ("int", "1-5", "J.3 ¿Planes de sucesión?", "Likert", ""),
        "j_04": ("int", "1-5", "J.4 ¿Capacitación a familiares?", "Likert", ""),
    }

    dims = {
        "A": ["a_01", "a_02", "a_03"],
        "B": ["b_01", "b_02", "b_03", "b_04", "b_05", "b_06", "b_07"],
        "C": ["c_01", "c_02", "c_03", "c_04", "c_05"],
        "D": ["d_01", "d_02", "d_03"],
        "E": ["e_01", "e_02", "e_03", "e_04", "e_05", "e_06", "e_07"],
        "F": ["f_01_inv", "f_02_inv", "f_03_inv", "f_04", "f_05_inv", "f_06"],
        "G": ["g_01", "g_02", "g_03"],
        "H": ["h_01", "h_02", "h_03"],
        "I": ["i_01", "i_02"],
        "J": ["j_01", "j_02", "j_03", "j_04"],
    }

    lines = [
        "# Diccionario de Datos",
        "",
        "Archivo: `data_analisis.csv`",
        f"Filas: {n_rows}",
        f"Columnas: {len(header)}",
        f"Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
        "",
        "## Dimensiones",
        "",
        "| Dimensión | Ítems | Invertidos |",
        "|---|---|---|",
        "| A: Desempeño y Estrategias | a_01–a_03 | — |",
        "| B: Presupuestación Financiera | b_01–b_07 | — |",
        "| C: Institucionalización | c_01–c_05 | — |",
        "| D: Controles de Riesgos | d_01–d_03 | — |",
        "| E: Prácticas de Ventas | e_01–e_07 | — |",
        "| F: Finanzas Internas | f_01–f_06 | f_01, f_02, f_03, f_05 |",
        "| G: Negociación Financiera | g_01–g_03 | — |",
        "| H: Recursos Humanos | h_01–h_03 | — |",
        "| I: Ventajas Competitivas | i_01–i_02 | — |",
        "| J: Mejores Prácticas E. Familiares | j_01–j_04 | — |",
        "",
        "## Variables",
        "",
        "| Variable | Tipo | Valores | Descripción | Escala | Notas |",
        "|---|---|---|---|---|---|",
    ]
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
        "- 1 = No, nunca, mal",
        "- 2 = Casi nunca, regular",
        "- 3 = No sé, no tengo criterio",
        "- 4 = Casi siempre, bien",
        "- 5 = Sí, siempre, excelente",
        "",
        "### Inversión de ítems negativos",
        "",
        "Los ítems de la dimensión F (Finanzas Internas) que expresan un problema",
        "se invierten: valor_inv = 6 - valor_original. Así, puntajes altos siempre",
        "indican buen gobierno corporativo.",
    ])

    with open(DICT_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"[DICT] {DICT_PATH}")


def print_report(out_rows, final_headers, raw_rows, fix_count, log):
    print("=" * 60)
    print("LIMPIEZA COMPLETADA")
    print("=" * 60)
    print(f"Filas originales:  {len(raw_rows)}")
    print(f"Filas finales:     {len(out_rows)}")
    print(f"Columnas:          {len(final_headers)}")
    print(f"Alineaciones corregidas: {fix_count}")
    print(f"Cambios registrados: {len(log)}")
    print()
    print("--- Tamaño de empresa ---")
    for k, v in Counter(r["tamano_empresa"] for r in out_rows).most_common():
        print(f"  {k}: {v}")
    print()
    print("--- Responsabilidad ---")
    for k, v in Counter(r["responsabilidad"] for r in out_rows).most_common():
        print(f"  {k}: {v}")
    print()
    print("--- Sexo ---")
    for k, v in Counter(r["sexo"] for r in out_rows).most_common():
        print(f"  {k}: {v}")
    print()
    print("--- Escolaridad ---")
    for k, v in Counter(r["escolaridad"] for r in out_rows).most_common():
        print(f"  {k}: {v}")
    print()
    print("--- Años de permanencia ---")
    for k, v in Counter(r["anos_permanencia"] for r in out_rows).most_common():
        print(f"  {k}: {v}")
    print()
    cambios = Counter(m[4] for m in log)
    for k, v in cambios.most_common():
        print(f"  {v}x  {k}")


if __name__ == "__main__":
    main()
