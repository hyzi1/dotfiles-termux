# I use ColemakDH, the H is more comfortable.
alias h='lsd -X'
alias hq='lsd -a'
alias h1='lsd -1 *(.)'
alias h2='lsd -X -d .*'
alias h-='lsd --tree -a'

alias l='lsd -X -d *(/)'
alias ll='lsd -X -d *(D/)'
alias b='bat -p'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias c='clear'

# I like to have my suggestions set, so I did something simple.
alias zhi='cp $HOME/.config/.zsh_history ~/.zsh_history && exit'

alias gpgsk='gpg --list-secret-keys --keyid-format=long'
alias gpgpk='gpg --list-keys --keyid-format=long'
alias gpgv='gpg --verify'
alias gpgm='gpg --encrypt --armor --recipient'
alias gpgi='gpg --import'
alias gpga='gpgconf --kill gpg-agent'

# chmod +x rish
alias shi="$HOME/.config/shizuku/rish"
