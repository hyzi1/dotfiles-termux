# pkg i termux-api
# And install termux-api app.

# example: yy gpg-key.txt
yy() {
  if [[ ! -r "$1" ]]; then
    print -u2 "ii: Error. '$1'"
    return 1
  fi
  termux-clipboard-set < "$1"
  print -u2 "Copy in the clipboard!"
}
