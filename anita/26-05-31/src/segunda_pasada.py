import csv
import shutil
import os
from datetime import datetime
from collections import Counter

LIKERT_COLS = [
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
]

LIKERT_OUTLIERS = {
    "p06_conoces_significado_ahorro": "54",
    "p11_conoces_que_es_presupuesto": "42",
    "p12_conoces_tasa_interes": "55",
    "p14_entendes_inflacion": "23",
}

P18_GROUPS = {
    "Interactivas": [
        "videos y clases interactivas", "videos y clases interactivas",
        "divertidas, entretenidas e interesantes", "divertidas y entretenidas e interesantes",
        "clases interactivas", "clases en linea", "juegos interactivos",
        "clases en lnea",
    ],
    "Con expertos": [
        "expertos en el tema, dinamicas y simulaciones",
        "expertos en el tema, dinmicas y simulaciones",
        "talleres, cursos y tutoriales",
    ],
    "Explicaciones claras": [
        "explicacion, estrategias y actividades",
        "explicacin, estrategias y actividades",
        "claras, vers tiles, objetivas y did cticas",
        "claras, verstiles, objetivas y didcticas",
        "sencillas con lenguaje cotidiano e informacion",
        "sencillas con lenguaje cotidiano e informacin",
        "sencillas, con lenguaje cotidiano e informacion",
        "sencillas, con lenguaje cotidiano e informacin",
    ],
    "Con practica": [
        "exposiciones, ejemplos y practicas",
        "practicas, con formularios, aplicadas e investigaciones",
        "exposiciones y practicas",
        "investigaciones y tareas",
    ],
    "En equipo": [
        "trabajos en equipo", "propuestas y metas", "con propuestas",
    ],
    "Ahorro/inversion": [
        "metodos de ahorro e inversion",
        "mtodos de ahorro e inversin",
        "hablar sobre inflacion y devaluacion",
        "hablar sobre inflacin y devaluacin",
    ],
    "Otro": [
        "no se", "sin comentarios", "que me den plata", "ganar dinero",
        "no me llama la atencion", "no me llama la atencin",
        "como tengan que ser", "que los maestros no sean estrictos",
        "materia extra y funcional", "buenas",
        "con aprendizaje y oficinas", "al aire libre", "novedosas",
        "prometedoras y directas",
    ],
}


def normalize_p18(text):
    if not text:
        return "Otro"
    t = text.strip().lower()
    if t in ("", "no contesto"):
        return "Otro"
    for grupo, keys in P18_GROUPS.items():
        for k in keys:
            if t == k or t.startswith(k[:10]):
                return grupo
    return "Otro"


def normalize_p18_loose(text):
    if not text:
        return "Otro"
    t = text.strip().lower()
    for grupo, keys in P18_GROUPS.items():
        for k in keys:
            kk = k.replace(" ", "")
            tt = t.replace(" ", "")
            if kk in tt or tt in kk:
                return grupo
            if k[:8] in t:
                return grupo
    return "Otro"


def categorize_p18(text):
    if not text:
        return "Otro"
    t = text.strip().lower()
    if not t:
        return "Otro"
    best = "Otro"
    best_len = 0
    for grupo, keys in P18_GROUPS.items():
        for k in keys:
            if k in t and len(k) > best_len:
                best = grupo
                best_len = len(k)
    return best


def main():
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"../archive/data_normalizado.backup_{timestamp}.csv"
    shutil.copy("../data/processed/data_normalizado.csv", backup_name)
    print(f"[BACKUP] {backup_name} creado")

    log_rows = []
    with open("../data/processed/data_normalizado.csv", "r", encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f, delimiter=";")
        header = reader.fieldnames
        rows = [dict(r) for r in reader]

    n = len(rows)
    print(f"[INPUT] {n} filas, {len(header)} columnas")

    log = []

    for idx, r in enumerate(rows, 1):
        if r.get("grado") == "3B" and r.get("nivel_educativo") == "Secundaria":
            log.append((idx, "grado", "3B", "3", "reparacion: 3B->3 (mezcla grado+grupo)"))

    for r in rows:
        if r.get("grado") == "3B":
            r["grado"] = "3"

    if "grupo" in header:
        for r in rows:
            r.pop("grupo", None)
        new_header = [c for c in header if c != "grupo"]
    else:
        new_header = list(header)

    for col, bad in LIKERT_OUTLIERS.items():
        for idx, r in enumerate(rows, 1):
            if r.get(col) == bad:
                log.append((idx, col, bad, "", f"outlier Likert (fuera de rango 1-5)"))

    for col, bad in LIKERT_OUTLIERS.items():
        for r in rows:
            if r.get(col) == bad:
                r[col] = ""

    for r in rows:
        v = r.get("edad", "").strip()
        if v and v.lstrip("-").isdigit():
            try:
                r["edad"] = str(int(v))
            except ValueError:
                pass
        else:
            r["edad"] = ""

        v = r.get("grado", "").strip()
        if v and v.isdigit():
            r["grado"] = v
        elif v == "":
            r["grado"] = ""

    for col in LIKERT_COLS:
        for r in rows:
            v = r.get(col, "").strip()
            if v and v.isdigit():
                n = int(v)
                if 1 <= n <= 5:
                    r[col] = str(n)
                else:
                    r[col] = ""
            else:
                r[col] = ""

    for r in rows:
        niv = r.get("nivel_educativo", "")
        if niv in ("Secundaria", "Telesecundaria"):
            r["nivel_agrupado"] = "Secundaria"
        elif niv == "Preparatoria":
            r["nivel_agrupado"] = "Bachillerato"
        else:
            r["nivel_agrupado"] = ""

    for r in rows:
        r["p18_categoria"] = categorize_p18(r.get("p18_como_gustarian_clases", ""))

    final_header = [
        "nivel_educativo", "nivel_agrupado",
        "nombre_escuela", "tipo_escuela", "sexo", "edad", "grado",
        "fecha_aplicacion", "a_convivencia", "b_vivienda", "c_negocio_familiar",
        "p01_has_escuchado_educacion_financiera",
        "p02_conoces_significado_educacion_financiera",
        "p03_te_gustaria_aprender_educacion_financiera",
        "p04_consideras_importante_educacion_financiera",
        "p05_definicion_educacion_financiera",
        "p06_conoces_significado_ahorro",
        "p07_tienes_cuenta_ahorro",
        "p08_constante_responsable_ahorrar",
        "p09_opinion_credito_banco_caja",
        "p10_conoces_que_es_credito",
        "p11_conoces_que_es_presupuesto",
        "p12_conoces_tasa_interes",
        "p13_comprendes_que_es_inversion",
        "p14_entendes_inflacion",
        "p15_entendes_devaluacion_dinero",
        "p16_diferencias_tarjeta_credito_debito",
        "p17_ahorras_fuera_instituciones",
        "p18_como_gustarian_clases", "p18_categoria",
    ]
    final_header = [c for c in final_header if c in (new_header + ["nivel_agrupado", "p18_categoria"])]

    with open("../data/processed/data_analisis.csv", "w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=final_header, delimiter=";")
        w.writeheader()
        w.writerows(rows)
    print(f"[OUTPUT] ../data/processed/data_analisis.csv: {len(rows)} filas, {len(final_header)} columnas")

    with open("../docs/transformaciones_log.csv", "w", encoding="utf-8", newline="") as f:
        w = csv.writer(f)
        w.writerow(["fila", "campo", "valor_original", "valor_nuevo", "motivo"])
        for fila, campo, orig, nuevo, motivo in log:
            w.writerow([fila, campo, orig, nuevo, motivo])
    print(f"[LOG] ../docs/transformaciones_log.csv: {len(log)} cambios registrados")

    generate_dictionary(final_header)

    print()
    print("=" * 60)
    print("REPORTE FINAL")
    print("=" * 60)
    print(f"Filas:  {len(rows)}")
    print(f"Cols:   {len(final_header)}")
    print()
    print("nivel_agrupado (Mann-Whitney U):")
    for k, v in Counter(r["nivel_agrupado"] for r in rows).most_common():
        print(f"  {k:15s} {v:4d}")
    print()
    print("p18_categoria (7 grupos):")
    for k, v in Counter(r["p18_categoria"] for r in rows).most_common():
        print(f"  {k:25s} {v:4d}")
    print()
    print("Cambios aplicados:")
    motivo_count = Counter(m[4] for m in log)
    for k, v in motivo_count.most_common():
        print(f"  {v}x  {k}")


def generate_dictionary(header):
    dict_data = {
        "nivel_educativo": (
            "str", "Secundaria | Telesecundaria | Preparatoria",
            "Nivel educativo del estudiante", "Nominal", ""
        ),
        "nivel_agrupado": (
            "str", "Secundaria | Bachillerato",
            "Nivel agrupado (secundaria+telesecundaria vs preparatoria) para Mann-Whitney U",
            "Nominal", "Derivada de nivel_educativo"
        ),
        "nombre_escuela": (
            "str", "13 escuelas",
            "Nombre de la escuela (no del alumno)", "Nominal", ""
        ),
        "tipo_escuela": (
            "str", "Publica | Privada",
            "Tipo de financiamiento", "Nominal", ""
        ),
        "sexo": (
            "str", "Hombre | Mujer",
            "Sexo del estudiante", "Nominal", "1 vacio"
        ),
        "edad": (
            "int", "12-51",
            "Edad en anos", "Razon", "Outlier 51 conservado por decision del usuario"
        ),
        "grado": (
            "int", "1-6",
            "Grado escolar. En secundaria/telesecundaria: 1-3. En preparatoria: 1-6",
            "Ordinal", "3B en secundaria reparado a 3"
        ),
        "fecha_aplicacion": (
            "str", "DD/MM/YYYY",
            "Fecha de aplicacion del cuestionario", "Fecha", "Formato D/M/Y; 3/1/1900 conservado (placeholder)"
        ),
        "a_convivencia": (
            "str", "Padres | Uno de ellos | Otro familiar",
            "Con quien vive el estudiante", "Nominal", "1 vacio"
        ),
        "b_vivienda": (
            "str", "Propia | Rentada | Prestada",
            "Tipo de tenencia de la vivienda", "Nominal", ""
        ),
        "c_negocio_familiar": (
            "str", "Si | No",
            "La familia tiene negocio o empresa", "Dicotomica", "Reinterpretado: 1->Si, 5->No"
        ),
        "p01_has_escuchado_educacion_financiera": (
            "int", "1-5",
            "Has escuchado hablar de Educacion Financiera?", "Likert", "1=No, nunca 5=Si, mucho"
        ),
        "p02_conoces_significado_educacion_financiera": (
            "int", "1-5",
            "Conoces que significa Educacion Financiera?", "Likert", ""
        ),
        "p03_te_gustaria_aprender_educacion_financiera": (
            "int", "1-5",
            "Te gustaria aprender diversos temas de Educacion Financiera?", "Likert", ""
        ),
        "p04_consideras_importante_educacion_financiera": (
            "int", "1-5",
            "Consideras que es importante y necesaria la Educacion Financiera?", "Likert", ""
        ),
        "p05_definicion_educacion_financiera": (
            "str", "a) ... | b) ... | c) Ninguna | d) No se",
            "Cual de las definiciones describe mejor la Educacion Financiera", "Nominal", ""
        ),
        "p06_conoces_significado_ahorro": (
            "int", "1-5",
            "Sabes que significa ahorro?", "Likert", "Outlier 54 -> NaN"
        ),
        "p07_tienes_cuenta_ahorro": (
            "str", "Si | No",
            "Tienes cuenta de ahorro en algun banco o Caja Popular?", "Dicotomica", ""
        ),
        "p08_constante_responsable_ahorrar": (
            "int", "1-5",
            "Eres constante y responsable al ahorrar?", "Likert", ""
        ),
        "p09_opinion_credito_banco_caja": (
            "int", "1-5",
            "Consideras que sacar un credito en un banco o Caja Popular es?", "Likert", ""
        ),
        "p10_conoces_que_es_credito": (
            "int", "1-5",
            "Sabes lo que es un credito?", "Likert", ""
        ),
        "p11_conoces_que_es_presupuesto": (
            "int", "1-5",
            "Sabes lo que es un presupuesto?", "Likert", "Outlier 42 -> NaN"
        ),
        "p12_conoces_tasa_interes": (
            "int", "1-5",
            "Conoces que significa tasa de interes?", "Likert", "Outlier 55 -> NaN"
        ),
        "p13_comprendes_que_es_inversion": (
            "int", "1-5",
            "Comprendes que es una inversion?", "Likert", ""
        ),
        "p14_entendes_inflacion": (
            "int", "1-5",
            "Entiendes el significado de la palabra inflacion?", "Likert", "Outlier 23 -> NaN"
        ),
        "p15_entendes_devaluacion_dinero": (
            "int", "1-5",
            "Entiendes el significado de devaluacion del dinero?", "Likert", ""
        ),
        "p16_diferencias_tarjeta_credito_debito": (
            "int", "1-5",
            "Identificas las diferencias entre una tarjeta de credito y una de debito?",
            "Likert", ""
        ),
        "p17_ahorras_fuera_instituciones": (
            "str", "Si | No",
            "Ahorras fuera de las instituciones financieras (alcancía)?", "Dicotomica", ""
        ),
        "p18_como_gustarian_clases": (
            "str", "34 categorias verbatim",
            "Como te gustaria que fueran las clases de educacion financiera?",
            "Texto libre", "Caracteres acentuados perdidos en fuente original"
        ),
        "p18_categoria": (
            "str", "7 grupos",
            "Categoria agrupada de p18 para analisis cuantitativo",
            "Nominal", "Derivada: Interactivas | Con expertos | Explicaciones claras | Con practica | En equipo | Ahorro/inversion | Otro"
        ),
    }

    lines = [
        "# Diccionario de Datos",
        "",
        "Archivo: `data_analisis.csv`  ",
        f"Filas: 656  ",
        f"Columnas: {len(header)}  ",
        f"Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
        "",
        "## Tabla de variables",
        "",
        "| Variable | Tipo | Valores validos | Pregunta / descripcion | Escala | Notas |",
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
        "## Escalas",
        "",
        "### Likert (1-5)",
        "- 1 = No, nunca, muy malo",
        "- 2 = Muy poco, casi nunca, malo",
        "- 3 = Algo, a veces",
        "- 4 = Casi siempre, bueno",
        "- 5 = Si, mucho, siempre, muy bueno",
        "",
        "### Dicotomica",
        "- Si / No",
        "",
        "## Categorias de p18_categoria",
        "",
        "| Grupo | Descripcion |",
        "|---|---|",
        "| Interactivas | Videos, juegos, dinamicas, interactivas, en linea, divertidas |",
        "| Con expertos | Expertos en el tema, talleres, cursos, tutoriales |",
        "| Explicaciones claras | Explicacion, claras, didacticas, sencillas, exposiciones, lenguaje cotidiano |",
        "| Con practica | Practicas, ejemplos, formularios, investigaciones, tareas |",
        "| En equipo | Trabajos en equipo, propuestas, metas |",
        "| Ahorro/inversion | Metodos de ahorro, inflacion, devaluacion |",
        "| Otro | No se, sin comentarios, respuestas miscelaneas |",
        "",
        "## Cambios respecto a data_normalizado.csv",
        "",
        "- 4 outliers Likert -> NaN (p06=54, p11=42, p12=55, p14=23)",
        "- 1 reparacion: grado '3B' en secundaria -> grado=3",
        "- Columna `grupo` eliminada (no relevante para el estudio)",
        "- Columna `nivel_agrupado` anadida (Secundaria vs Bachillerato)",
        "- Columna `p18_categoria` anadida (7 grupos)",
        "- Likert convertidas de string a int",
        "- `edad` y `grado` convertidas a int donde aplica",
        "",
        "## Trazabilidad",
        "",
        "Ver `transformaciones_log.csv` para el detalle de cada modificacion.",
    ])

    with open("../docs/data_dictionary.md", "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print("[DICT] ../docs/data_dictionary.md generado")


if __name__ == "__main__":
    main()
