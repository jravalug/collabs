#!/bin/bash
# sync.sh — Sincronización inteligente entre /home (git/agente) y /mnt/d (SPSS)
#
# Analiza diferencias, clasifica por tipo, sincroniza con rsync -u (el más
# reciente gana) y verifica que los archivos estén en sus directorios correctos.
#
# Uso:  ./sync.sh              (ejecutar con copia)
#       ./sync.sh --dry-run    (solo previsualizar)
#
# Convención de directorios:
#   .sps           → spss/
#   .py            → src/
#   .md (en docs/) → docs/; AGENTS.md, README.md, CHANGELOG.md → raíz proyecto
#   .csv procesado → data/processed/; .csv respuestas → data/raw/
#   .sav           → data/processed/
#   .txt (tablas)  → results/
#   .png (graf)    → results/
#   .spv           → results/
#   .docx/.xlsx    → data/raw/ (originales)
#   .sh            → raíz

set -euo pipefail

HOME_DIR="/home/jravalug/collabs"
MNT_DIR="/mnt/d/collabs"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { echo -e "${CYAN}[>]${NC} $*"; }
ok()    { echo -e "${GREEN}[✓]${NC} $*"; }
warn()  { echo -e "${YELLOW}[!]${NC} $*"; }
err()   { echo -e "${RED}[✗]${NC} $*"; }

DRY=""
[[ "${1:-}" == "--dry-run" ]] && DRY="--dry-run" && info "MODO DRY RUN — no se copiarán archivos"

echo ""
echo -e "${CYAN}══════════════════════════════════════════════════${NC}"
echo -e "${CYAN}           sync.sh — Sincronización              ${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════${NC}"
echo "  HOME:  $HOME_DIR"
echo "  MNT:   $MNT_DIR"
echo ""

# ─── Fase 1: diferencias ──────────────────────────────────
info "Fase 1: Escaneando diferencias entre HOME y MNT..."
EXCLUDE="--exclude=.git/ --exclude=__pycache__/ --exclude=*.pyc --exclude=*.spv"

A_HOME=$(rsync -niav --no-R $EXCLUDE "$MNT_DIR/" "$HOME_DIR/" 2>/dev/null | grep '^>f' | wc -l)
A_MNT=$(rsync  -niav --no-R $EXCLUDE "$HOME_DIR/" "$MNT_DIR/" 2>/dev/null | grep '^>f' | wc -l)

if [ "$A_HOME" -eq 0 ] && [ "$A_MNT" -eq 0 ]; then
  ok "No hay diferencias. Ambos directorios están sincronizados."
  exit 0
fi

echo ""
info "Resumen: $A_HOME archivos diferentes en HOME, $A_MNT en MNT"
RSYNC_OPTS="-rlptgoD -u --no-R"  # -u = update (keep newer)

# ─── Fase 2: sincronizar por tipo ─────────────────────────
info "Fase 2: Sincronizando archivos por tipo..."

# 2a) Código fuente y configuración: HOME → MNT (agente autoritativo)
#     Pero con -u para respetar ediciones hechas desde SPSS.
info "  src/ + spss/ + raíz → HOME → MNT..."
rsync $DRY $RSYNC_OPTS \
  --include='*.sps' --include='*.py' --include='*.sh' \
  --include='AGENTS.md' --include='.gitignore' \
  --include='*/output/' --include='*/output/**' \
  --include='*/' --exclude='*' \
  "$HOME_DIR/" "$MNT_DIR/"

# 2b) Documentación: bidireccional, gana el más nuevo
info "  docs/ + README + CHANGELOG → bidireccional..."
rsync $DRY $RSYNC_OPTS \
  --include='*/docs/' --include='*/docs/**' \
  --include='*/README.md' --include='*/CHANGELOG.md' \
  --include='template/' --include='template/**' \
  --include='*/' --exclude='*' \
  "$HOME_DIR/" "$MNT_DIR/"
rsync $DRY $RSYNC_OPTS \
  --include='*/docs/' --include='*/docs/**' \
  --include='*/README.md' --include='*/CHANGELOG.md' \
  --include='*/' --exclude='*' \
  "$MNT_DIR/" "$HOME_DIR/"

# 2c) Datos: bidireccional
info "  data/ → bidireccional..."
rsync $DRY $RSYNC_OPTS \
  --include='*/data/' --include='*/data/**' \
  --include='*/' --exclude='*' \
  "$HOME_DIR/" "$MNT_DIR/"
rsync $DRY $RSYNC_OPTS \
  --include='*/data/' --include='*/data/**' \
  --include='*/' --exclude='*' \
  "$MNT_DIR/" "$HOME_DIR/"

# 2d) Resultados SPSS: MNT → HOME (SPSS los genera)
info "  results/ + .sav → MNT → HOME..."
rsync $DRY $RSYNC_OPTS \
  --include='*/results/' --include='*/results/**' \
  --include='*/data/processed/*.sav' \
  --include='*/' --exclude='*' \
  "$MNT_DIR/" "$HOME_DIR/"

# ─── Fase 3: archivos fuera de lugar ──────────────────────
info "Fase 3: Verificando archivos fuera de lugar..."

find "$HOME_DIR" -type f \( -name "*.spv" -o -name "*.sav" -o -name "*.png" \) ! -path "*/.git/*" 2>/dev/null | while IFS= read -r f; do
  rel="${f#$HOME_DIR/}"
  # Check if file is already in its correct directory
  # (correct paths: .../results/..., .../data/processed/...)
  case "${f##*.}" in
    spv)
      if [[ "$rel" != *"/results/"* ]]; then
        warn "  .spv fuera de lugar: $rel → debe ir en results/" >&2
      fi
      ;;
    sav)
      if [[ "$rel" != *"/data/processed/"* ]]; then
        warn "  .sav fuera de lugar: $rel → debe ir en data/processed/" >&2
      fi
      ;;
    png)
      if [[ "$rel" != *"/results/"* ]]; then
        warn "  .png fuera de lugar: $rel → debe ir en results/" >&2
      fi
      ;;
  esac
done

# ─── Fase 4: verificar ────────────────────────────────────
info "Fase 4: Verificando sincronización final..."
LEFT=$(rsync -niav --no-R $EXCLUDE "$MNT_DIR/" "$HOME_DIR/" 2>/dev/null | grep '^>f' | wc -l)
RIGHT=$(rsync -niav --no-R $EXCLUDE "$HOME_DIR/" "$MNT_DIR/" 2>/dev/null | grep '^>f' | wc -l)

if [ "$DRY" != "" ]; then
  info "Dry run — pendientes: $LEFT en HOME, $RIGHT en MNT"
elif [ "$LEFT" -eq 0 ] && [ "$RIGHT" -eq 0 ]; then
  ok "Sincronización completa. Ambos directorios están alineados."
else
  warn "Quedan $LEFT diferencias (HOME) y $RIGHT (MNT)."
  warn "  (pueden ser solo diferencias de timestamp, no de contenido)"
fi

echo ""
echo -e "${GREEN}══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           sync.sh — Finalizado                  ${NC}"
echo -e "${GREEN}══════════════════════════════════════════════════${NC}"
