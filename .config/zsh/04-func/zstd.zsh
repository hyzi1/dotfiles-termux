# This is for quickly creating a compressed tar archive.

# Use: zs22 images

zs22() {
  local target="${1%/}"
  tar -I 'zstd --ultra -22 -T0' -cf "${target}.tar.zst" "$1"
}

zs9() {
  local target="${1%/}"
  tar -I 'zstd -9 -T0' -cf "${target}.tar.zst" "$1"
}

zs6() {
  local target="${1%/}"
  tar -I 'zstd -6 -T0' -cf "${target}.tar.zst" "$1"
}
