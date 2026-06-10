import zipfile
import os
from xml.etree import ElementTree as ET
from xml.dom import minidom
import shutil

NS = {
    'w': 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
    'r': 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
    'mc': 'http://schemas.openxmlformats.org/markup-compatibility/2006',
    'wp': 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing',
    'a': 'http://schemas.openxmlformats.org/drawingml/2006/main',
    'pic': 'http://schemas.openxmlformats.org/drawingml/2006/picture',
    'wps': 'http://schemas.microsoft.com/office/word/2010/wordprocessingShape',
    'wpg': 'http://schemas.microsoft.com/office/word/2010/wordprocessingGroup',
    'wpi': 'http://schemas.microsoft.com/office/word/2010/wordprocessingInk',
    'wne': 'http://schemas.microsoft.com/office/word/2006/wordml',
    'wpc': 'http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas',
    'v': 'urn:schemas-microsoft-com:vml',
    'o': 'urn:schemas-microsoft-com:office:office',
    'w10': 'urn:schemas-microsoft-com:office:word',
}

QA = lambda tag: ET.QName('http://schemas.openxmlformats.org/wordprocessingml/2006/main', tag)


def _E(tag, attrib=None, text=None, children=None):
    el = ET.Element(QA(tag), attrib or {})
    if text:
        el.text = text
    if children:
        el.extend([c for c in children if c is not None])
    return el


def _txt(text):
    return _E('t', {'xml:space': 'preserve'}, text=text)


def _rPr(font='Times New Roman', sz=24, bold=False, italic=False, color=None):
    """sz is half-points: 24 = 12pt"""
    children = []
    if bold:
        children.append(_E('b'))
    if italic:
        children.append(_E('i'))
    if color:
        children.append(_E('color', {'w:val': color}))
    children.append(_E('rFonts', {'w:ascii': font, 'w:hAnsi': font, 'w:cs': font}))
    children.append(_E('sz', {'w:val': str(sz)}))
    children.append(_E('szCs', {'w:val': str(sz)}))
    return _E('rPr', children=children)


def _pPr(space_after=0, space_before=0, line=360, justify='both', first_line=0):
    """line is twips: 360 = 1.5 lines (360 = 240 * 1.5)"""
    children = []
    if justify:
        children.append(_E('jc', {'w:val': justify}))
    spacing_children = []
    if space_after:
        spacing_children.append(_E('after', {'w:val': str(space_after)}))
    if space_before:
        spacing_children.append(_E('before', {'w:val': str(space_before)}))
    if line:
        spacing_children.append(_E('line', {'w:val': str(line)}))
    if spacing_children:
        children.append(_E('spacing', children=spacing_children))
    if first_line:
        children.append(_E('ind', {'w:firstLine': str(first_line)}))
    return _E('pPr', children=children) if children else None


def _p(elements, ppr=None):
    children = [ppr] if ppr else []
    children.extend(elements)
    return _E('p', children=children)


def build_styles():
    """Build the minimal styles.xml for pandoc reference docx."""
    style_els = []

    # Default paragraph style (Normal)
    style_normal = _E('style', {
        'w:type': 'paragraph',
        'w:styleId': 'Normal',
        'w:default': '1',
    }, children=[
        _E('name', {'w:val': 'Normal'}),
        _E('pPr', children=[
            _E('spacing', {
                'w:after': '0',
                'w:line': '360',
                'w:lineRule': 'auto',
            }),
            _E('jc', {'w:val': 'both'}),
        ]),
        _E('rPr', children=[
            _E('rFonts', {'w:ascii': 'Times New Roman', 'w:hAnsi': 'Times New Roman', 'w:cs': 'Times New Roman'}),
            _E('sz', {'w:val': '24'}),
            _E('szCs', {'w:val': '24'}),
        ]),
    ])
    style_els.append(style_normal)

    # Title style for pandoc's Title block
    style_title = _E('style', {
        'w:type': 'paragraph',
        'w:styleId': 'Title',
    }, children=[
        _E('name', {'w:val': 'Title'}),
        _E('basedOn', {'w:val': 'Normal'}),
        _E('pPr', children=[
            _E('spacing', {
                'w:before': '240',
                'w:after': '120',
                'w:line': '360',
                'w:lineRule': 'auto',
            }),
            _E('jc', {'w:val': 'center'}),
        ]),
        _E('rPr', children=[
            _E('b'),
            _E('sz', {'w:val': '32'}),
            _E('szCs', {'w:val': '32'}),
        ]),
    ])
    style_els.append(style_title)

    # Heading 1
    style_h1 = _E('style', {
        'w:type': 'paragraph',
        'w:styleId': 'Heading1',
    }, children=[
        _E('name', {'w:val': 'heading 1'}),
        _E('basedOn', {'w:val': 'Normal'}),
        _E('pPr', children=[
            _E('spacing', {'w:before': '480', 'w:after': '240', 'w:line': '360', 'w:lineRule': 'auto'}),
            _E('jc', {'w:val': 'left'}),
        ]),
        _E('rPr', children=[
            _E('b'),
            _E('sz', {'w:val': '28'}),
            _E('szCs', {'w:val': '28'}),
        ]),
    ])
    style_els.append(style_h1)

    # Heading 2
    style_h2 = _E('style', {
        'w:type': 'paragraph',
        'w:styleId': 'Heading2',
    }, children=[
        _E('name', {'w:val': 'heading 2'}),
        _E('basedOn', {'w:val': 'Normal'}),
        _E('pPr', children=[
            _E('spacing', {'w:before': '240', 'w:after': '120', 'w:line': '360', 'w:lineRule': 'auto'}),
            _E('jc', {'w:val': 'left'}),
        ]),
        _E('rPr', children=[
            _E('b'),
            _E('sz', {'w:val': '26'}),
            _E('szCs', {'w:val': '26'}),
        ]),
    ])
    style_els.append(style_h2)

    # Heading 3
    style_h3 = _E('style', {
        'w:type': 'paragraph',
        'w:styleId': 'Heading3',
    }, children=[
        _E('name', {'w:val': 'heading 3'}),
        _E('basedOn', {'w:val': 'Normal'}),
        _E('pPr', children=[
            _E('spacing', {'w:before': '240', 'w:after': '120', 'w:line': '360', 'w:lineRule': 'auto'}),
            _E('jc', {'w:val': 'left'}),
        ]),
        _E('rPr', children=[
            _E('b'),
            _E('sz', {'w:val': '24'}),
            _E('szCs', {'w:val': '24'}),
        ]),
    ])
    style_els.append(style_h3)

    # Remove the default Table style from pandoc — we don't need it since
    # we override with formatear_tablas.py
    # But we DO need a table style for pandoc to reference
    style_table = _E('style', {
        'w:type': 'table',
        'w:styleId': 'Table',
        'w:default': '1',
    }, children=[
        _E('name', {'w:val': 'Table'}),
        _E('pPr', children=[
            _E('spacing', {'w:after': '0', 'w:line': '240', 'w:lineRule': 'auto'}),
        ]),
        _E('rPr', children=[
            _E('rFonts', {'w:ascii': 'Times New Roman', 'w:hAnsi': 'Times New Roman'}),
            _E('sz', {'w:val': '20'}),
            _E('szCs', {'w:val': '20'}),
        ]),
    ])
    style_els.append(style_table)

    # Caption style
    style_caption = _E('style', {
        'w:type': 'paragraph',
        'w:styleId': 'Caption',
    }, children=[
        _E('name', {'w:val': 'caption'}),
        _E('basedOn', {'w:val': 'Normal'}),
        _E('pPr', children=[
            _E('spacing', {'w:before': '120', 'w:after': '60', 'w:line': '240', 'w:lineRule': 'auto'}),
            _E('jc', {'w:val': 'left'}),
        ]),
        _E('rPr', children=[
            _E('b'),
            _E('sz', {'w:val': '20'}),
            _E('szCs', {'w:val': '20'}),
        ]),
    ])
    style_els.append(style_caption)

    styles_xml = ET.tostring(
        _E('styles', {
            'xmlns:w': 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
            'xmlns:r': 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
            'xmlns:mc': 'http://schemas.openxmlformats.org/markup-compatibility/2006',
        }, children=style_els),
        encoding='unicode', xml_declaration=True
    )
    # Indent for readability
    return styles_xml


def build_document():
    """Build document.xml with Times New Roman 12, 1.5 spacing, 3cm margins."""
    # 3cm in twips (1cm = 567 twips)
    margin = 1701  # 3cm
    # Letter page: 12240 x 15840 twips (width x height)
    page_w = 12240
    page_h = 15840

    body = [
        # SectPr with margins and page size
        _E('sectPr', children=[
            _E('pgSz', {'w:w': str(page_w), 'w:h': str(page_h)}),
            _E('pgMar', {
                'w:top': str(margin),
                'w:right': str(margin),
                'w:bottom': str(margin),
                'w:left': str(margin),
                'w:header': '720',
                'w:footer': '720',
                'w:gutter': '0',
            }),
        ]),
    ]

    doc_xml = ET.tostring(
        _E('document', {
            'xmlns:w': 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
            'xmlns:r': 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
            'xmlns:mc': 'http://schemas.openxmlformats.org/markup-compatibility/2006',
        }, children=[
            _E('body', children=body),
        ]),
        encoding='unicode', xml_declaration=True
    )
    return doc_xml


def build_rels():
    """Build .rels files."""
    NS_REL = 'http://schemas.openxmlformats.org/package/2006/relationships'
    NS_DOC = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'

    def make_rel(id_, type_, target):
        el = ET.Element(ET.QName(NS_REL, 'Relationship'))
        el.set('Id', id_)
        el.set('Type', type_)
        el.set('Target', target)
        return el

    # Document rels
    root_doc = ET.Element(ET.QName(NS_REL, 'Relationships'), {
        'xmlns': NS_REL,
    })
    root_doc.append(make_rel('rId1',
        f'{NS_DOC}/styles', 'styles.xml'))
    root_doc.append(make_rel('rId2',
        f'{NS_DOC}/fontTable', 'fontTable.xml'))
    doc_rels = ET.tostring(root_doc, encoding='unicode', xml_declaration=True)

    # Root rels
    root_root = ET.Element(ET.QName(NS_REL, 'Relationships'), {
        'xmlns': NS_REL,
    })
    root_root.append(make_rel('rId1',
        f'{NS_DOC}/officeDocument', 'word/document.xml'))
    root_rels = ET.tostring(root_root, encoding='unicode', xml_declaration=True)

    return doc_rels, root_rels


def build_content_types():
    return '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/word/fontTable.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml"/>
</Types>'''


def build_fonttable():
    return '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:fonts xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:font w:name="Times New Roman">
    <w:panose1 w:val="02020603050405020304"/>
    <w:charset w:val="00"/>
    <w:family w:val="roman"/>
    <w:pitch w:val="variable"/>
    <w:sig w:usb0="20007A87" w:usb1="80000000" w:usb2="00000008" w:usb3="00000000" w:csb0="000001FF" w:csb1="00000000"/>
  </w:font>
</w:fonts>'''


def main():
    out_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                            'reference.docx')
    tmp_dir = '/tmp/opencode/reference_docx'
    if os.path.exists(tmp_dir):
        shutil.rmtree(tmp_dir)

    os.makedirs(os.path.join(tmp_dir, 'word'), exist_ok=True)
    os.makedirs(os.path.join(tmp_dir, '_rels'), exist_ok=True)

    # Write document.xml
    with open(os.path.join(tmp_dir, 'word', 'document.xml'), 'w', encoding='utf-8') as f:
        f.write(build_document())

    # Write styles.xml
    with open(os.path.join(tmp_dir, 'word', 'styles.xml'), 'w', encoding='utf-8') as f:
        f.write(build_styles())

    # Write fontTable.xml
    with open(os.path.join(tmp_dir, 'word', 'fontTable.xml'), 'w', encoding='utf-8') as f:
        f.write(build_fonttable())

    # Write relationships
    doc_rels, root_rels = build_rels()
    os.makedirs(os.path.join(tmp_dir, 'word', '_rels'), exist_ok=True)
    with open(os.path.join(tmp_dir, 'word', '_rels', 'document.xml.rels'), 'w', encoding='utf-8') as f:
        f.write(doc_rels)
    with open(os.path.join(tmp_dir, '_rels', '.rels'), 'w', encoding='utf-8') as f:
        f.write(root_rels)

    # Write [Content_Types].xml
    with open(os.path.join(tmp_dir, '[Content_Types].xml'), 'w', encoding='utf-8') as f:
        f.write(build_content_types())

    # Package as .docx
    with zipfile.ZipFile(out_path, 'w', zipfile.ZIP_DEFLATED) as zout:
        for dirpath, dirnames, filenames in os.walk(tmp_dir):
            for fn in filenames:
                fpath = os.path.join(dirpath, fn)
                arcname = os.path.relpath(fpath, tmp_dir)
                zout.write(fpath, arcname)

    shutil.rmtree(tmp_dir, ignore_errors=True)
    print(f'Referencia creada: {out_path}')
    print(f'Usa: pandoc --reference-doc={out_path} archivo.md -o archivo.docx')


if __name__ == '__main__':
    main()
