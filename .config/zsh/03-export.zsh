# pkg i pinentry
# NOTE: I use GPG daily. If you don’t use it, you can delete this.
export GPG_TTY=$(tty)

# pkg i proton-drive-cli gnupg pass
# NOTE: I use Proton Drive for backups. I don’t think you use this. You can delete this and the aliases.

#export PROTON_DRIVE_CREDENTIALS_STORE=pass

# pkg i vivid
# NOTE: Not necessary at all. It’s just to make 'lsd' look nice.
export LS_COLORS="$(vivid generate ~/.config/vivid/themes/main.yml)"

# Shizuku
# This is very versatile, having privileges climbed with only shizuku.
export RISH_APPLICATION_ID=com.termux

# pkg i fzf
# This theme adapts to the theme of the terminal you are using.
export FZF_DEFAULT_OPTS=" \
--color=bg+:8,bg:,spinner:1,hl:1 \
--color=fg:7,header:1,info:2,pointer:13 \
--color=marker:13,fg+:7,prompt:13,hl+:1 \
--color=selected-bg:8 \
--color=border:4,label:4"
# NOTE: FZF TAB inherits this theme.
