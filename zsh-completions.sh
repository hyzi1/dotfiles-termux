#!/usr/bin/env bash

# This ensures that, when the TAB key is pressed, certain tools I use are recognized. To keep things simple, I reuse the folder <~/.zsh-plugins/zsh-completions/src/>.  

# pkg i restic
restic generate --zsh-completion ~/.zsh-plugins/zsh-completions/src/_restic

# go install github.com/Achno/gowall@latest 
gowall completion zsh > ~/.zsh-plugins/zsh-completions/src/_gowall
