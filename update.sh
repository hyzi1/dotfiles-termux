#!/usr/bin/env bash

#Line '81' is where you choose which parts of my configuration you want to apply. Just so you know, a backup of your files will be created before they are replaced by mine—a handy little extra! <3

#===
# Paths

SRC="$(cd -- "$(dirname -- "$0")" && pwd)"
#===

#===
# Safety

set -eu
IFS="$(printf '\n\t')"
#===

#===
# Logging

ok()   { printf '\033[35m[+] %s\033[0m\n' "$*"; }
warn() { printf '\033[33m[!] %s\033[0m\n' "$*" >&2; }
die()  { printf '\033[31m[-] %s\033[0m\n' "$*" >&2; exit 1; }
#===

#===
# Deploy

# files and dirs share one lane, cp -Rp does not care
put() {
  _rel="$1"
  _src="${SRC}/${_rel}"
  [ -e "$_src" ] || die "missing source: $_rel"

  if [ -n "$DRY" ]; then
    ok "would install ${_rel}"
    return 0
  fi

# snapshot first, a bad deploy never eats your old configs
  if [ -e "${HOME}/${_rel}" ]; then
    mkdir -p -- "${BK}/$(dirname -- "$_rel")"
    cp -Rp -- "${HOME}/${_rel}" "${BK}/${_rel}"
  fi

  rm -rf -- "${HOME:?}/${_rel}"
  mkdir -p -- "$(dirname -- "${HOME}/${_rel}")"
  cp -Rp -- "$_src" "${HOME}/${_rel}"

# only files get a mode, dirs keep what they brought
  if [ -f "$_src" ]; then
    chmod "${2:-600}" -- "${HOME}/${_rel}"
  fi

  ok "${_rel}"
}
#===

#===
# Run

DRY=""
BK="${HOME}/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

while [ $# -gt 0 ]; do
  case "$1" in
    -n|--dry-run) DRY=1 ;;
    -h|--help)    printf 'usage: %s [-n|--dry-run]\n' "$0"; exit 0 ;;
    *)            die "unknown option: $1" ;;
  esac
  shift
done

if [ -n "$DRY" ]; then
  warn "dry-run mode, nothing gets touched"
fi

while IFS= read -r _f; do
  [ -n "$_f" ] || continue
  put "$_f"
done <<'FILES'
.zshrc
.zprofile
.config/starship.toml
.config/yazi/keymap.toml
.config/yazi/theme.toml
.aria2/d.conf
.aria2/i.conf
.config/.zsh_history
.config/lsd
.config/vivid
.config/bat
.config/fastfetch
.config/shizuku
.termux
.config/.gif
FILES

if [ -n "$DRY" ]; then
  ok "dry-run done, nothing was touched"
else
  ok "done, backup at ${BK}"
fi
#===
