# It's comfortable for me to have the plugins there.
zshp=$HOME/.zsh-plugins

fpath=($zshp/zsh-completions/src $fpath)

autoload -Uz compinit
compinit

# This allows FZF TAB to recognize hidden files and folders.
_comp_options+=(globdots)

# An improvement for 'TAB'.
setopt COMPLETE_IN_WORD
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source $zshp/somewhere/fzf-tab.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=6

ZSH_AUTOSUGGEST_HISTORY_IGNORE="wget ?(#c0,)|git ?(#c20,)|mv ?(#c20,)|mkdir *|cp ?(#c20,)|rm *| *"

source $zshp/zsh-autosuggestions/zsh-autosuggestions.zsh

# NOTE: I no longer use this plugin because I now use <patina>; however, I will keep this plugin active. Since the installation process for <patina> can vary, I recommend handling it on your own. My <patina> configuration is located at <~/.config/>.
# https://github.com/michel-kraemer/zsh-patina
source $zshp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unset zshp

# I chose this installation for this plugin:

# git clone https://github.com/michel-kraemer/zsh-patina.git ~/.zsh-plugins/.zsh-patina

# cd ~/.zsh-plugins/.zsh-patina

# cargo build --release

#eval "$(~/.zsh-plugins/.zsh-patina/target/release/zsh-patina activate)"
