import csv
import zipfile
import xml.etree.ElementTree as ET

import os
BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
XLSX_PATH = os.path.join(BASE, "data/raw/Gobierno Corporativo PyMe (respuestas).xlsx")
CSV_PATH = os.path.join(BASE, "data/raw/respuestas.csv")

z = zipfile.ZipFile(XLSX_PATH)
ns = {"s": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}

shared_strings = ET.fromstring(z.read("xl/sharedStrings.xml"))
strings = [
    si.find(".//s:t", ns).text if si.find(".//s:t", ns) is not None else ""
    for si in shared_strings.findall(".//s:si", ns)
]

sheet = ET.fromstring(z.read("xl/worksheets/sheet1.xml"))
rows = sheet.findall(".//s:row", ns)

data = []
for row in rows:
    cells = row.findall(".//s:c", ns)
    vals = []
    for c in cells:
        v = c.find(".//s:v", ns)
        t = c.get("t", "")
        if v is not None and v.text:
            vals.append(strings[int(v.text)] if t == "s" else v.text)
        else:
            vals.append("")
    data.append(vals)

with open(CSV_PATH, "w", encoding="utf-8", newline="") as f:
    w = csv.writer(f)
    w.writerows(data)

print(f"Exportado: {len(data)} filas, {len(data[0]) if data else 0} columnas → {CSV_PATH}")

z.close()
