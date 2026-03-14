#!/usr/bin/env bash
# update_skill.sh — Update skill vernon-python ke versi terbaru
# Jalankan dari root project yang menggunakan skill ini

set -euo pipefail

SKILL_NAME="vernon-python"
REPO_URL="https://github.com/erickmo/Claude-Skill-Python.git"
SKILL_DEST=".claude/skills/${SKILL_NAME}"
TMP_DIR=$(mktemp -d)

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "==> Mengupdate skill: ${SKILL_NAME}"
echo "    Sumber : ${REPO_URL}"
echo "    Tujuan : ${SKILL_DEST}"
echo ""

# Cek apakah folder tujuan ada
if [ ! -d "${SKILL_DEST}" ]; then
  echo "ERROR: Folder ${SKILL_DEST} tidak ditemukan."
  echo "       Pastikan kamu menjalankan script ini dari root project."
  exit 1
fi

# Clone repo sementara (sparse, hanya ambil folder skill)
echo "==> Mengambil update dari repository..."
git clone --depth=1 --filter=blob:none --sparse "${REPO_URL}" "${TMP_DIR}" -q

cd "${TMP_DIR}"
git sparse-checkout set ".claude/skills/${SKILL_NAME}" -q
cd - > /dev/null

# Verifikasi file SKILL.md tersedia
if [ ! -f "${TMP_DIR}/.claude/skills/${SKILL_NAME}/SKILL.md" ]; then
  echo "ERROR: SKILL.md tidak ditemukan di repository."
  exit 1
fi

# Backup SKILL.md yang lama
BACKUP="${SKILL_DEST}/SKILL.md.bak"
if [ -f "${SKILL_DEST}/SKILL.md" ]; then
  cp "${SKILL_DEST}/SKILL.md" "${BACKUP}"
  echo "==> Backup disimpan di: ${BACKUP}"
fi

# Salin file-file skill yang baru
cp -r "${TMP_DIR}/.claude/skills/${SKILL_NAME}/." "${SKILL_DEST}/"

# Hapus backup jika update berhasil
rm -f "${BACKUP}"

echo ""
echo "Skill '${SKILL_NAME}' berhasil diupdate."
