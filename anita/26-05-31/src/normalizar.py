import csv
import re
from collections import Counter

REPLACEMENT_CHAR = "\ufffd"

COLUMN_MAP = {
    "ESCUELA": "nivel_educativo",
    "NOMBRE": "nombre_escuela",
    "PUBLICA O PRIVADA": "tipo_escuela",
    "SEXO DEL ALUMNO": "sexo",
    "EDAD": "edad",
    "GRADO": "grado",
    "GRUPO": "grupo",
    "FECHA APLICACI" + REPLACEMENT_CHAR + "N": "fecha_aplicacion",
    "a) Actualmente est" + REPLACEMENT_CHAR + "s viviendo con:": "a_convivencia",
    "b) La casa donde habitas es:": "b_vivienda",
    "c) Tu familia cuenta con alg" + REPLACEMENT_CHAR + "n negocio o empresa": "c_negocio_familiar",
    "1.- " + REPLACEMENT_CHAR + "Has escuchado hablar de Educaci" + REPLACEMENT_CHAR + "n Financiera?": "p01_has_escuchado_educacion_financiera",
    "2.- " + REPLACEMENT_CHAR + "Conoces que significa Educaci" + REPLACEMENT_CHAR + "n Financiera?": "p02_conoces_significado_educacion_financiera",
    "3.- " + REPLACEMENT_CHAR + "Te gustar" + REPLACEMENT_CHAR + "a aprender diversos temas de Educaci" + REPLACEMENT_CHAR + "n Financiera?": "p03_te_gustaria_aprender_educacion_financiera",
    "4.- " + REPLACEMENT_CHAR + "Consideras que es importante y necesaria la Educaci" + REPLACEMENT_CHAR + "n Financiera?": "p04_consideras_importante_educacion_financiera",
    "5.- " + REPLACEMENT_CHAR + "De las siguientes definiciones cual consideras describe mejor a la Educaci" + REPLACEMENT_CHAR + "n Financiera?": "p05_definicion_educacion_financiera",
    "6.- " + REPLACEMENT_CHAR + "Sabes que significa ahorro?": "p06_conoces_significado_ahorro",
    "7.- " + REPLACEMENT_CHAR + "Tienes cuenta de ahorro en alg" + REPLACEMENT_CHAR + "n banco o Caja Popular?": "p07_tienes_cuenta_ahorro",
    "8.- " + REPLACEMENT_CHAR + "Eres constante y responsable al ahorrar?": "p08_constante_responsable_ahorrar",
    "9.- " + REPLACEMENT_CHAR + "Consideras que sacar un cr" + REPLACEMENT_CHAR + "dito en un banco o Caja Popular es?": "p09_opinion_credito_banco_caja",
    "10.- " + REPLACEMENT_CHAR + "Sabes lo que es un cr" + REPLACEMENT_CHAR + "dito?": "p10_conoces_que_es_credito",
    "11.- " + REPLACEMENT_CHAR + " Sabes lo que es un presupuesto?": "p11_conoces_que_es_presupuesto",
    "12.- " + REPLACEMENT_CHAR + "Conoces que significa tasa de inter" + REPLACEMENT_CHAR + "s?": "p12_conoces_tasa_interes",
    "13.- " + REPLACEMENT_CHAR + "Comprendes que es una inversi" + REPLACEMENT_CHAR + "n?": "p13_comprendes_que_es_inversion",
    "14.- " + REPLACEMENT_CHAR + "Entiendes el significado de la palabra inflaci" + REPLACEMENT_CHAR + "n?": "p14_entendes_inflacion",
    "15.- " + REPLACEMENT_CHAR + " Entiendes el significado de devaluaci" + REPLACEMENT_CHAR + "n del dinero?": "p15_entendes_devaluacion_dinero",
    "16.- " + REPLACEMENT_CHAR + "Identificas las diferencias entre una tarjeta de cr" + REPLACEMENT_CHAR + "dito y una tarjeta de d" + REPLACEMENT_CHAR + "bito?": "p16_diferencias_tarjeta_credito_debito",
    "17.- " + REPLACEMENT_CHAR + "Ahorras fuera de las instituciones financieras como en una alcanc" + REPLACEMENT_CHAR + "a?": "p17_ahorras_fuera_instituciones",
    "18.- " + REPLACEMENT_CHAR + "C" + REPLACEMENT_CHAR + "mo te gustar" + REPLACEMENT_CHAR + "a que fueran las clases de educaci" + REPLACEMENT_CHAR + "n financiera?": "p18_como_gustarian_clases",
}

LIKERT_COLS = {
    "p01_has_escuchado_educacion_financiera",
    "p02_conoces_significado_educacion_financiera",
    "p03_te_gustaria_aprender_educacion_financiera",
    "p04_consideras_importante_educacion_financiera",
    "p06_conoces_significado_ahorro",
    "p08_constante_responsable_ahorrar",
    "p09_opinion_credito_banco_caja",
    "p10_conoces_que_es_credito",
    "p11_conoces_que_es_presupuesto",
    "p12_conoces_tasa_interes",
    "p13_comprendes_que_es_inversion",
    "p14_entendes_inflacion",
    "p15_entendes_devaluacion_dinero",
    "p16_diferencias_tarjeta_credito_debito",
}

TIPO_ESCUELA_MAP = {
    "PUBLICA": "P\u00fablica",
    "Publica": "P\u00fablica",
    "P" + REPLACEMENT_CHAR + "blica": "P\u00fablica",
    "Privada": "Privada",
}

CONVIVENCIA_MAP = {"1": "Padres", "2": "Uno de ellos", "3": "Otro familiar"}
VIVIENDA_MAP = {"1": "Propia", "2": "Rentada", "3": "Prestada"}
NEGOCIO_MAP = {"SI": "S\u00ed", "NO": "No", "1": "S\u00ed", "5": "No"}
P5_MAP = {
    "1": "a) Estrategias para manejo de finanzas personales",
    "2": "b) Habilidades y conocimientos para el dinero",
    "3": "c) Ninguna",
    "4": "d) No s\u00e9",
}


def clean_text(s):
    if s is None:
        return ""
    s = s.replace(REPLACEMENT_CHAR, "")
    s = re.sub(r"\s+", " ", s).strip()
    return s


def normalize_likert(s):
    s = s.strip()
    if s == "":
        return ""
    try:
        n = int(s)
        return str(n) if 1 <= n <= 5 else s
    except ValueError:
        return s


def rename_header(h):
    h = h.strip()
    if h in COLUMN_MAP:
        return COLUMN_MAP[h]
    cleaned = h.replace(REPLACEMENT_CHAR, "")
    return cleaned


def main():
    with open("../data/raw/data.csv", "r", encoding="utf-8") as f:
        reader = csv.reader(f, delimiter=";")
        raw_header = next(reader)
        raw_rows = list(reader)

    non_empty_rows = [r for r in raw_rows if any(c.strip() for c in r)]
    eliminated = len(raw_rows) - len(non_empty_rows)

    while raw_header and raw_header[-1].strip() == "":
        raw_header.pop()

    new_header = [rename_header(h) for h in raw_header]

    out_rows = []
    for r in non_empty_rows:
        r = r[: len(new_header)]
        while len(r) < len(new_header):
            r.append("")
        d = dict(zip(new_header, r))

        if "nombre_escuela" in d:
            d["nombre_escuela"] = clean_text(d["nombre_escuela"])
        if "p18_como_gustarian_clases" in d:
            d["p18_como_gustarian_clases"] = clean_text(d["p18_como_gustarian_clases"])
        if "fecha_aplicacion" in d:
            d["fecha_aplicacion"] = d["fecha_aplicacion"].strip()

        if "tipo_escuela" in d:
            d["tipo_escuela"] = TIPO_ESCUELA_MAP.get(d["tipo_escuela"].strip(), d["tipo_escuela"])
        if "a_convivencia" in d:
            d["a_convivencia"] = CONVIVENCIA_MAP.get(d["a_convivencia"].strip(), "")
        if "b_vivienda" in d:
            d["b_vivienda"] = VIVIENDA_MAP.get(d["b_vivienda"].strip(), "")
        if "c_negocio_familiar" in d:
            d["c_negocio_familiar"] = NEGOCIO_MAP.get(d["c_negocio_familiar"].strip(), d["c_negocio_familiar"])
        if "p05_definicion_educacion_financiera" in d:
            d["p05_definicion_educacion_financiera"] = P5_MAP.get(
                d["p05_definicion_educacion_financiera"].strip(),
                d["p05_definicion_educacion_financiera"],
            )

        for col in LIKERT_COLS:
            if col in d:
                d[col] = normalize_likert(d[col])

        for col in ("p07_tienes_cuenta_ahorro", "p17_ahorras_fuera_instituciones"):
            if col in d:
                v = d[col].strip()
                d[col] = {"SI": "S\u00ed", "NO": "No"}.get(v, v)

        out_rows.append(d)

    nivel_order = {"Secundaria": 0, "Telesecundaria": 1, "Preparatoria": 2}
    out_rows.sort(
        key=lambda d: (
            nivel_order.get(d.get("nivel_educativo", ""), 99),
            d.get("nombre_escuela", ""),
            d.get("grado", ""),
            d.get("grupo", ""),
        )
    )

    with open("../data/processed/data_normalizado.csv", "w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=new_header, delimiter=";")
        w.writeheader()
        w.writerows(out_rows)

    print("=" * 60)
    print("NORMALIZACION COMPLETADA")
    print("=" * 60)
    print(f"Filas originales:  {len(raw_rows)}")
    print(f"Filas eliminadas (vacias): {eliminated}")
    print(f"Filas finales:     {len(out_rows)}")
    print(f"Columnas finales:  {len(new_header)}")
    print()
    print("--- Resumen por columna ---")
    for col in new_header:
        vals = [d.get(col, "") for d in out_rows]
        non_empty = [v for v in vals if v != ""]
        unique = len(set(non_empty))
        sample = list(Counter(non_empty).most_common(3))
        sample_str = ", ".join(f"{v!r}:{n}" for v, n in sample)
        print(f"  {col:55s}  n={len(non_empty):4d}  u={unique:3d}  top=[{sample_str}]")
    print()
    print("Archivo generado: ../data/processed/data_normalizado.csv")


if __name__ == "__main__":
    main()
