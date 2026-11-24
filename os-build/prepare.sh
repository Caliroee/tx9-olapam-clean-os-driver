#!/usr/bin/env bash
set -eu
# Entrada: distribuição compactada. Saída: novo diretório, criado pelo script.
src=${1:?Informe a imagem oficial .img.gz}
out=${2:?Informe um novo diretório de saída}
base=$(cd "$(dirname "$0")" && pwd)
expected=9edf06e752ed285e11a565584a2369a39b734df56bd0852ce37eee3d9ea9d16b
actual=$(sha256sum < "$src")
test "${actual%% *}" = "$expected" || { echo "SHA-256 de origem divergente" >&2; exit 1; }
mkdir -- "$out"
tmp=$(mktemp -d)
trap 'rm -f "$tmp/disk.img" "$tmp/check.dtb" "$tmp/readback.dtb"; rmdir "$tmp"' EXIT
gzip -dc -- "$src" > "$tmp/disk.img"
fat="$tmp/disk.img@@4194304"
mcopy -i "$fat" ::device_trees/gxl_p281_1g.dtb "$tmp/check.dtb"
cmp "$base/gxl_p281_1g.dtb" "$tmp/check.dtb"
mcopy -o -i "$fat" "$tmp/check.dtb" ::dtb.img
mcopy -i "$fat" ::dtb.img "$tmp/readback.dtb"
cmp "$base/gxl_p281_1g.dtb" "$tmp/readback.dtb"
gzip -nc "$tmp/disk.img" > "$out/TX9-OLAPAM-CoreELEC-21.3.img.gz"
(cd "$out" && sha256sum TX9-OLAPAM-CoreELEC-21.3.img.gz > SHA256SUMS)
