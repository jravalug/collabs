import zipfile
import shutil
import os
import sys
from xml.etree import ElementTree as ET

NS = {
    'w': 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
}


def qn(tag):
    return ET.QName('http://schemas.openxmlformats.org/wordprocessingml/2006/main', tag)


def booktabs(docx_path):
    tmp_dir = '/tmp/opencode/docx_fix'
    # Clean up any previous extraction
    if os.path.exists(tmp_dir):
        shutil.rmtree(tmp_dir)
    os.makedirs(tmp_dir, exist_ok=True)

    with zipfile.ZipFile(docx_path, 'r') as z:
        z.extractall(tmp_dir)

    tree = ET.parse(os.path.join(tmp_dir, 'word', 'document.xml'))
    root = tree.getroot()
    body = root.find('.//w:body', NS)

    # Get page width and margins from sectPr
    sectPr = body.find('.//w:sectPr', NS)
    page_w = 12240  # default letter
    left_margin = 1701  # default 3cm
    right_margin = 1701
    if sectPr is not None:
        pg_sz = sectPr.find('w:pgSz', NS)
        if pg_sz is not None:
            page_w = int(pg_sz.attrib.get(qn('w'), page_w))
        pg_mar = sectPr.find('w:pgMar', NS)
        if pg_mar is not None:
            left_margin = int(pg_mar.attrib.get(qn('left'), left_margin))
            right_margin = int(pg_mar.attrib.get(qn('right'), right_margin))

    usable_w = page_w - left_margin - right_margin

    tables = root.findall('.//w:tbl', NS)
    if not tables:
        print('  No se encontraron tablas.')
        tree.write(os.path.join(tmp_dir, 'word', 'document.xml'),
                   xml_declaration=True, encoding='UTF-8')
        _repack(docx_path, tmp_dir)
        return

    for ti, tbl in enumerate(tables):
        # Get tblGrid (column definitions)
        tbl_grid = tbl.find('w:tblGrid', NS)
        grid_cols = tbl_grid.findall('w:gridCol', NS) if tbl_grid is not None else []
        total_grid_w = sum(int(c.attrib.get(qn('w'), 0)) for c in grid_cols)

        # --- Set table width ---
        tbl_pr = tbl.find('w:tblPr', NS)
        if tbl_pr is None:
            tbl_pr = ET.Element(qn('tblPr'))
            tbl.insert(0, tbl_pr)

        # Remove existing tblW
        existing = tbl_pr.find('w:tblW', NS)
        if existing is not None:
            tbl_pr.remove(existing)
        tblw = ET.SubElement(tbl_pr, qn('tblW'))
        tblw.set(qn('w'), str(usable_w))
        tblw.set(qn('type'), 'dxa')

        # Ensure autofit layout so Word distributes columns within the width
        existing_layout = tbl_pr.find('w:tblLayout', NS)
        if existing_layout is not None:
            tbl_pr.remove(existing_layout)
        layout = ET.SubElement(tbl_pr, qn('tblLayout'))
        layout.set(qn('type'), 'autofit')

        rows = tbl.findall('.//w:tr', NS)
        nrows = len(rows)

        for ri, row in enumerate(rows):
            cells = row.findall('.//w:tc', NS)

            for ci, cell in enumerate(cells):
                tc_pr = cell.find('w:tcPr', NS)
                if tc_pr is None:
                    tc_pr = ET.Element(qn('tcPr'))
                    cell.insert(0, tc_pr)

                # --- Set column width proportionally ---
                if ci < len(grid_cols) and total_grid_w > 0:
                    grid_w = int(grid_cols[ci].attrib.get(qn('w'), 1))
                    prop_w = int(usable_w * grid_w / total_grid_w)
                    existing_tcw = tc_pr.find('w:tcW', NS)
                    if existing_tcw is not None:
                        tc_pr.remove(existing_tcw)
                    tcw = ET.SubElement(tc_pr, qn('tcW'))
                    tcw.set(qn('w'), str(prop_w))
                    tcw.set(qn('type'), 'dxa')

                # --- Remove all borders ---
                existing_borders = tc_pr.find('w:tcBorders', NS)
                if existing_borders is not None:
                    tc_pr.remove(existing_borders)

                borders = ET.SubElement(tc_pr, qn('tcBorders'))
                bnames = ['top', 'left', 'bottom', 'right']
                b_els = {}
                for bn in bnames:
                    bel = ET.SubElement(borders, qn(bn))
                    bel.set(qn('val'), 'nil')
                    b_els[bn] = bel

                # Header row: top + bottom border
                if ri == 0:
                    for bn in ['top', 'bottom']:
                        b = b_els[bn]
                        b.set(qn('val'), 'single')
                        b.set(qn('sz'), '4')
                        b.set(qn('space'), '0')
                        b.set(qn('color'), '000000')

                # Last row: bottom border only
                if ri == nrows - 1:
                    b = b_els['bottom']
                    b.set(qn('val'), 'single')
                    b.set(qn('sz'), '4')
                    b.set(qn('space'), '0')
                    b.set(qn('color'), '000000')

    tree.write(os.path.join(tmp_dir, 'word', 'document.xml'),
               xml_declaration=True, encoding='UTF-8')
    _repack(docx_path, tmp_dir)
    print(f'  Formateadas {len(tables)} tablas (estilo booktabs).')


def _repack(docx_path, tmp_dir):
    tmp_out = docx_path + '.tmp'
    with zipfile.ZipFile(tmp_out, 'w', zipfile.ZIP_DEFLATED) as zout:
        for dirpath, dirnames, filenames in os.walk(tmp_dir):
            for fn in filenames:
                fpath = os.path.join(dirpath, fn)
                arcname = os.path.relpath(fpath, tmp_dir)
                zout.write(fpath, arcname)
    shutil.move(tmp_out, docx_path)
    shutil.rmtree(tmp_dir, ignore_errors=True)


def main():
    if len(sys.argv) < 2:
        print('Uso: python formatear_tablas.py archivo.docx [archivo2.docx ...]')
        sys.exit(1)
    for path in sys.argv[1:]:
        print(f'Procesando: {path}')
        booktabs(path)


if __name__ == '__main__':
    main()
