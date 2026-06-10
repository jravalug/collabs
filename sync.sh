#!/bin/bash
# sync.sh — Sincronización bidireccional entre /home (Linux/git/agente)
#           y /mnt/d (Windows/SPSS).
#
# Después del sync ambos lados quedan idénticos (no deja archivos residuales).
#
#   Fase A — MNT → HOME: resultados SPSS (results/, .sav)
#   Fase B — HOME → MNT: todo el repositorio (espejo exacto con --delete)
#
# Uso:
#   ./sync.sh              sincronizar
#   ./sync.sh --dry-run    previsualizar

set -euo pipefail

HOME_DIR="/home/jravalug/collabs"
MNT_DIR="/mnt/d/collabs"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { echo -e "${CYAN}[>]${NC} $*"; }
ok()    { echo -e "${GREEN}[✓]${NC} $*"; }
err()   { echo -e "${RED}[✗]${NC} $*"; }

DRY="${1:+--dry-run}"
[[ "${1:-}" != "--dry-run" ]] && DRY=""

echo ""
echo -e "${CYAN}══════════════════════════════════════════════════${NC}"
echo -e "${CYAN}           sync.sh — Sincronización              ${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════${NC}"
echo "  HOME:  $HOME_DIR"
echo "  MNT:   $MNT_DIR"
echo ""

[ "$DRY" != "" ] && info "MODO DRY RUN — no se copiarán archivos"
[ ! -d "$MNT_DIR" ] && { err "$MNT_DIR no existe. ¿Está montado /mnt/d?"; exit 1; }

RSYNC="rsync -rltgoD -u --delete"

# ─── Fase A: resultados SPSS → HOME ──────────────────
info "Fase A: Resultados SPSS (MNT → HOME)..."
A_OK=0

while IFS= read -r -d '' dir; do
  rel="${dir#$HOME_DIR/}"
  mnt="$MNT_DIR/$rel"
  [ -d "$mnt" ] || continue
  $RSYNC $DRY "$mnt/" "$dir/"
  A_OK=1
done < <(find "$HOME_DIR" -maxdepth 4 -type d -name "results" -not -path "*/.git/*" -print0 2>/dev/null)

while IFS= read -r -d '' dir; do
  rel="${dir#$HOME_DIR/}"
  mnt="$MNT_DIR/$rel"
  [ -d "$mnt" ] || continue
  $RSYNC $DRY --include='*.sav' --include='*/' --exclude='*' "$mnt/" "$dir/"
  A_OK=1
done < <(find "$HOME_DIR" -maxdepth 4 -type d -path "*/data/processed" -not -path "*/.git/*" -print0 2>/dev/null)

[ "$A_OK" -eq 0 ] && echo "  (sin proyectos con datos SPSS)"

# ─── Fase B: espejo completo HOME → MNT ──────────────
info "Fase B: Espejo completo (HOME → MNT)..."
$RSYNC $DRY \
  --exclude='.git/' \
  --exclude='.venv/' \
  --exclude='.python-version' \
  --exclude='__pycache__/' \
  --exclude='*.pyc' \
  --exclude='~$*' \
  "$HOME_DIR/" "$MNT_DIR/"

# ─── Resultado ───────────────────────────────────────
echo ""
ok "Sincronización completada. Ambos directorios están alineados."
echo ""
echo -e "${GREEN}══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           sync.sh — Finalizado                  ${NC}"
echo -e "${GREEN}══════════════════════════════════════════════════${NC}"
