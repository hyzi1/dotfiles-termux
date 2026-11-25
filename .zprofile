# I set this up for experimentation or for use in demos; it might be annoying for day-to-day use. Just delete .zprofile, as it’s purely cosmetic.

# pkg i zsh chafa fastfetch

# Look, it really depends on how you have your phone's resources configured. The animation might take longer to start, or it might not.

#===
# Path
gif="$HOME/.config/.gif/cat.gif"
#===

#===
# Security
if [[ ! -r "$gif" ]] || ! command -v chafa >/dev/null 2>&1; then
  echo -e "\033[31m[-] gif or chafa not found." >&2
  return
fi
#===

unsetopt monitor

#===
# Hi!
echo -e "\033[35m[+] You're back! press \033[31m[ENTER] \033[32mto start\033[0m"

#The larger the number, the further away you need to move the screen.

chafa -c full --dither none -s 32 --symbols quad --probe off --duration inf "$gif" &
pid=$!
#===

trap 'kill $pid 2>/dev/null; clear; exec zsh' INT
read -r _
kill $pid 2>/dev/null
wait $pid 2>/dev/null
trap - INT
clear
printf '\e[?25h'
command -v fastfetch >/dev/null 2>&1 && fastfetch
exec zsh
