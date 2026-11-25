# I use the thin cursor. Some tools reset it on exit, so this fixes it.

_fix_cursor() { print -n '\e[6 q' }
precmd_functions+=(_fix_cursor)

# Alias and fix 'pwd' termux (Only ZSH)
p() { print -P '%F{4}%~%f' }
