# Using Aria2 is super convenient; it optimizes my mobile data usage. And if I want to use a public network to download things, I just prepare a .txt list of what I want to download before heading out, and that's it.

# WIFI
adw()  { aria2c --conf-path="$HOME/.aria2/i.conf" "$@"; }
adwl() { adw -i "$@"; }
# List mode: adwl list.txt

# Data
add()  { aria2c --conf-path="$HOME/.aria2/d.conf" "$@"; }
addl() { add -i "$@"; }
# List mode: addl list.txt
