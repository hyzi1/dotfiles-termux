# I set this up for experimentation or for use in demos; it might be annoying for day-to-day use. Just delete .zprofile, as it’s purely cosmetic.

# pkg i zsh chafa fastfetch

# Look, it really depends on how you have your phone's resources configured. The animation might take longer to start, or it might not.

#===
# Path
gif="$HOME/.config/.gif/precure-magical-girl.gif"
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

# Change the number 40 to 60, or whatever you like.
chafa -c full --dither none -s 40 --symbols block+quad+vhalf+hhalf --probe off --duration inf "$gif" &
pid=$!
#===

trap 'kill $pid 2>/dev/null; clear; exec zsh' INT
read -r _
kill $pid 2>/dev/null
wait $pid 2>/dev/null
trap - INT
clear
command -v fastfetch >/dev/null 2>&1 && fastfetch
exec zsh
