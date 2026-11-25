ZSH_CONFIG_DIR="$HOME/.config/zsh"

if [ -d "$ZSH_CONFIG_DIR" ]; then
  for config_file in "$ZSH_CONFIG_DIR"/**/*.zsh(N); do
    source "$config_file"
  done
fi
