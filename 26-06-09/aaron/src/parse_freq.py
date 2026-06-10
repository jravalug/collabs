import csv
import re
import sys

FILE = "/home/jravalug/collabs/26-06-09/aaron/results/tablas_analisis.txt"

LIKERT_KEYS = {
    "No, nunca, mal": 1,
    "Casi nunca, regular": 2,
    "No s\u00e9, no tengo criterio": 3,
    "Casi siempre, bien": 4,
    "S\u00ed, siempre, excelente": 5,
}

ITEM_SPECS = [
    ("A.1", "a_01", "A"), ("A.2", "a_02", "A"), ("A.3", "a_03", "A"),
    ("B.1", "b_01", "B"), ("B.2", "b_02", "B"), ("B.3", "b_03", "B"),
    ("B.4", "b_04", "B"), ("B.5", "b_05", "B"), ("B.6", "b_06", "B"),
    ("B.7", "b_07", "B"),
    ("C.1", "c_01", "C"), ("C.2", "c_02", "C"), ("C.3", "c_03", "C"),
    ("C.4", "c_04", "C"), ("C.5", "c_05", "C"),
    ("D.1", "d_01", "D"), ("D.2", "d_02", "D"), ("D.3", "d_03", "D"),
    ("E.1", "e_01", "E"), ("E.2", "e_02", "E"), ("E.3", "e_03", "E"),
    ("E.4", "e_04", "E"), ("E.5", "e_05", "E"), ("E.6", "e_06", "E"),
    ("E.7", "e_07", "E"),
    ("F.1", "f_01", "F"), ("F.2", "f_02", "F"), ("F.3", "f_03", "F"),
    ("F.4", "f_04", "F"), ("F.5", "f_05", "F"), ("F.6", "f_06", "F"),
    ("F.1 invertido (6 - valor original)", "f_01_inv", "F"),
    ("F.2 invertido (6 - valor original)", "f_02_inv", "F"),
    ("F.3 invertido (6 - valor original)", "f_03_inv", "F"),
    ("F.5 invertido (6 - valor original)", "f_05_inv", "F"),
    ("G.1", "g_01", "G"), ("G.2", "g_02", "G"), ("G.3", "g_03", "G"),
    ("H.1", "h_01", "H"), ("H.2", "h_02", "H"), ("H.3", "h_03", "H"),
    ("I.1", "i_01", "I"), ("I.2", "i_02", "I"),
    ("J.1", "j_01", "J"), ("J.2", "j_02", "J"), ("J.3", "j_03", "J"),
    ("J.4", "j_04", "J"),
]

HEADING_PREFIXES = sorted({s[0] for s in ITEM_SPECS}, key=len, reverse=True)
HEADING_PREFIX_TO_SPEC = {s[0]: s for s in ITEM_SPECS}


def clean_pct(v):
    return v.strip().replace(",", ".")


def main():
    with open(FILE, "r", encoding="utf-8") as f:
        lines = f.readlines()

    n = len(lines)

    # find first "Tabla de frecuencia"
    i = 0
    while i < n and not lines[i].strip().startswith("Tabla de frecuencia"):
        i += 1
    if i >= n:
        print("ERROR: no frequency tables found", file=sys.stderr)
        sys.exit(1)
    i += 1  # skip "Tabla de frecuencia" header

    results = {}

    while i < n:
        raw = lines[i].strip()
        if not raw:
            i += 1
            continue

        # check if this line is an item heading
        matched = None
        for prefix in HEADING_PREFIXES:
            if raw.startswith(prefix):
                matched = prefix
                break

        if matched is None:
            i += 1
            continue

        _, code, dim = HEADING_PREFIX_TO_SPEC[matched]
        desc_line = raw[len(matched):].strip().lstrip("\u00bf").rstrip("?")
        desc_line = re.sub(r"\s+", " ", desc_line).strip()
        desc_line = desc_line.replace(" (invertido)", "")

        # scan for table data between separator lines
        i += 1
        data = {}
        total_val = None

        while i < n:
            row = lines[i].strip()
            # closing separator: |---...---| with exactly 2 pipes
            if row.startswith("|-") and row.endswith("|") and row.count("|") == 2:
                i += 1
                break
            if row.startswith("|"):
                parts = [p.strip() for p in row.split("|")]
                if len(parts) >= 6:
                    label = parts[2]
                    freq = parts[3]
                    pct = parts[4]
                    if label == "Total":
                        total_val = freq
                    elif label in LIKERT_KEYS:
                        data[LIKERT_KEYS[label]] = (freq, pct)
            i += 1

        if total_val is not None:
            results[code] = (dim, desc_line, data, total_val)

    # output CSV
    writer = csv.writer(sys.stdout)
    writer.writerow([
        "code", "dim", "desc",
        "f1", "pct1", "f2", "pct2", "f3", "pct3",
        "f4", "pct4", "f5", "pct5", "total"
    ])

    for heading, code, dim in ITEM_SPECS:
        if code in results:
            _, desc, data, total_val = results[code]
            row = [code, dim, desc]
            for level in range(1, 6):
                if level in data:
                    f, p = data[level]
                    row.extend([f, clean_pct(p)])
                else:
                    row.extend(["0", "0"])
            row.append(total_val)
            writer.writerow(row)
        else:
            row = [code, dim, ""]
            for level in range(1, 6):
                row.extend(["0", "0"])
            row.append("0")
            writer.writerow(row)


if __name__ == "__main__":
    main()
