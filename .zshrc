# chsh -s zsh

# pkg i pinentry
# >> I use GPG daily. If you don’t use it, you can delete this.
export GPG_TTY=$(tty)
#<<

# pkg i starship
eval "$(starship init zsh)"

# pkg i zoxide
eval "$(zoxide init zsh)"

# pkg i vivid
# Command: vivid themes
# >> Not necessary at all. It’s just to make 'lsd' look nice.
export LS_COLORS="$(vivid generate ~/.config/vivid/themes/main.yml)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#<<

#===
# Dependencies

# pkg i zsh starship vivid file python git nodejs aria2 yt-dlp fzf zoxide lsd gum yazi ffmpeg neovim termux-api pinentry gnupg bat

# python3 -m pip install mutagen
#===

#===
# ZSH Dependencies
# mkdir -p ~/.zsh-plugins

# git clone https://github.com/zsh-users/zsh-completions ~/.zsh-plugins/zsh-completions

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-plugins/zsh-autosuggestions

# git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh-plugins/zsh-syntax-highlighting

# git clone https://github.com/Aloxaf/fzf-tab ~/.zsh-plugins/somewhere
#===

#===
# Shizuku

# This is very versatile, having privileges climbed with only shizuku.
export RISH_APPLICATION_ID=com.termux
alias shi="$HOME/.config/shizuku/rish"
# chmod +x rish
#===

#===
# YT DLP

# yt-dlp/videos
ytv() {
    yt-dlp \
    --js-runtimes node \
    -P "$HOME/storage/downloads/.vi/" \
    --downloader aria2c \
    --downloader-args aria2c:"--conf-path=$HOME/.aria2//i.conf" \
    --write-thumbnail \
    -f "bestvideo[height<=1080][vcodec^=avc]+bestaudio[ext=opus]/bestvideo[height<=1080]+bestaudio/best" \
    --merge-output-format mkv \
    --write-subs \
    --sub-langs "es.*,en.*" \
    --embed-subs \
    --embed-thumbnail \
    "$1"
}
# yt-dlp/audio
# python3 -m pip install mutagen

yta() {
    yt-dlp \
    --js-runtimes node \
    -P "$HOME/storage/downloads/.au/" \
    --downloader aria2c \
    --downloader-args aria2c:"--conf-path=$HOME/.aria2/i.conf" \
    -f "bestaudio[ext=opus]/bestaudio/best" \
    -x \
    --audio-format opus \
    --write-thumbnail \
    --embed-thumbnail \
    --embed-metadata \
    "$1"
}
# If you want to install from a '.txt' list, just change it to: -a "$1"
#===

#===
# Aria2

# Using Aria2 is super convenient; it optimizes my mobile data usage. And if I want to use a public network to download things, I just prepare a .txt list of what I want to download before heading out, and that's it.
alias adw="aria2c --conf-path=$HOME/.aria2/i.conf"
alias adwl="aria2c --conf-path=$HOME/.aria2/i.conf -i"

alias add="aria2c --conf-path=$HOME/.aria2/d.conf"
alias addl="aria2c --conf-path=$HOME/.aria2/d.conf -i"
#===

#===
# Fix cursor

# I use the thin cursor. Some tools reset it on exit, so this fixes it.

CMD_WRAP+=(vi fzf)
for cmd in "${CMD_WRAP[@]}"; do
  eval "$cmd() { command $cmd \"\$@\"; printf '\e[6 q'; }"
done
#===

#===
# ZSH

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
#===

#===
# Alias

# >> I use ColemakDH, the H is more comfortable.
alias h='lsd -X'
alias hq='lsd -a'
alias h1='lsd -1 *(.)'
alias h2='lsd -X -d .*'
alias h-='lsd --tree -a'
#<<

# >> I like to have my suggestions set, so I did something simple.
alias zhi='cp $HOME/.config/.zsh_history ~/.zsh_history && exit'
#<<

alias gpg-sk='gpg --list-secret-keys --keyid-format=long'
alias gpg-pk='gpg --list-keys --keyid-format=long'
alias gpg-v='gpg --verify'
alias gpg-m='gpg --encrypt --armor --recipient'
alias gpg-i='gpg --import'
#===

#===
# ZSTD

# This is for quickly creating a compressed tar archive.

# Use: zs22 images

zs22() {
  local target="${1%/}"
  tar -I 'zstd --ultra -22 -T0' -cf "${target}.tar.zst" "$1"
}
#===

#===
# Hashes

# Quickly create and compare hashes

# Use: sh2 backup.tar

sh2() {
  sha256sum "$1" > "${1}.sha256"
  sha512sum "$1" > "${1}.sha512"
}

sum-a() {
    setopt local_options null_glob

    for f in *.md5; do
        [[ -f "$f" ]] && md5sum -c "$f"
    done

    for f in *.sha1; do
        [[ -f "$f" ]] && sha1sum -c "$f"
    done

    for f in *.sha256; do
        [[ -f "$f" ]] && sha256sum -c "$f"
    done

    for f in *.sha512; do
        [[ -f "$f" ]] && sha512sum -c "$f"
    done

    for f in *.b3; do
        [[ -f "$f" ]] && b3sum -c "$f"
    done
}
#===

#===
# GPG

# Use: gpg-s hi.txt

gpg-s() {
    read "user_id?ID-Email: "
    gpg --local-user "$user_id" --clearsign "$1"
}

# These aren't used much. They are for exporting keys.

gpg-e() {
    read "user_id?ID-Email: "
    gpg --armor --export "$user_id" > key.asc
}

gpg-exs() {
    read "user_id?ID-Email: "
    gpg --export-secret-keys --armor "$user_id" > private-key.asc
}
#===

#===
# Yazi

function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  
  command yazi "$@" --cwd-file="$tmp"
  
  # Fix cursor
  printf '\e[6 q'
  
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}
#===

#===
#FZF

# FZF theme

# This theme adapts to the theme of the terminal you are using.

export FZF_DEFAULT_OPTS=" \
--color=bg+:8,bg:,spinner:1,hl:1 \
--color=fg:7,header:1,info:2,pointer:13 \
--color=marker:13,fg+:7,prompt:13,hl+:1 \
--color=selected-bg:8 \
--color=border:4,label:4"
# FZF TAB inherits this theme.

# FZF TAB

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# https://github.com/Aloxaf/fzf-tab
#===

#===
# Details

# Alias and fix 'pwd' termux (Only ZSH)
p() { print -P '%F{4}%~%f' }

# lsd and gum

# I use the 'i'+'ii' alias by my keyboard layout. Just change the aliases to ls.
#ls -l
i2() {
    local dir=${PWD/#"$HOME"}
    if [[ $dir != "$PWD" ]]; then dir="~$dir"; fi
    # Want to add an extra? (pwd, pwd and date..)
    # >> pwd
    #local header="\033[1;35m$dir\033[0m"
    #<<

    # >> pwd and date
    local header="\033[1;31m$(date '+%d-%m-%y/%H:%M:%S')\033[0m\n\033[1;35m$dir\033[0m"
    #<<
    local box_width=$((COLUMNS - 4))
    local out

    out=$(script -q -c "lsd -l --color=always --icon=always --blocks name,size,date --date '+%d-%m-%y/%H:%M:%S' --total-size $*" /dev/null | tr -d '\r' | sed -E $'s/([0-9])(\x1b\\[[0-9;]*m)* (\x1b\\[[0-9;]*m)*([KMGT]B)/\\1\\2\\3\\4/g')

    if [[ -n "$out" ]]; then
        printf '%b\n\n%s' "$header" "$out" | gum style --border rounded --padding "1 2" --width "$box_width" --no-strip-ansi
    fi
}

# ls -1 (normal)
# Look! Instead of using `lsd -1` (which shows just one line), you can use `lsd -X` or `lsd -a`; however, you have to zoom out so it doesn't look too cramped.
i() {
    local dir=${PWD/#"$HOME"}
    if [[ $dir != "$PWD" ]]; then dir="~$dir"; fi
    # Want to add an extra? (pwd, pwd and date..)
    # >> pwd
    #local header="\033[1;35m$dir\033[0m"
    #<<

    # >> pwd and date
    local header="\033[1;31m$(date '+%d-%m-%y/%H:%M:%S')\033[0m\n\033[1;35m$dir\033[0m"
    #<<
    local box_width=$((COLUMNS - 4))
    local out

    out=$(script -q -c "lsd -1 --color=always --icon=always $*" /dev/null | tr -d '\r')

    if [[ -n "$out" ]]; then
        printf '%b\n\n%s' "$header" "$out" | gum style --border rounded --padding "1 2" --width "$box_width" --no-strip-ansi
    fi
}

# Termux copy
# You need the Termux API!

# example: yy gpg-key.txt
yy() {
  if [[ ! -r "$1" ]]; then
    print -u2 "ii: Error. '$1'"
    return 1
  fi
  termux-clipboard-set < "$1"
  print -u2 "Copy in the clipboard!"
}
#===

#===
#ZSH Plugins

# >> It's comfortable for me to have the plugins there.
ZSH_PLUGINS=$HOME/.zsh-plugins
#<<

fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)

autoload -Uz compinit
compinit

# >> An improvement for 'TAB'.
setopt COMPLETE_IN_WORD
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#<<

# Fix the cursor at startup
autoload -Uz add-zsh-hook
_cursor_main() { printf '\e[?25h' }
add-zsh-hook precmd _cursor_main

source ~/.zsh-plugins/somewhere/fzf-tab.plugin.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=6

ZSH_AUTOSUGGEST_HISTORY_IGNORE="wget ?(#c0,)|git ?(#c20,)|mv ?(#c20,)|mkdir *|cp ?(#c20,)|rm *| *"

source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#===
