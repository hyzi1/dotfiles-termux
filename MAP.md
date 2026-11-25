I think you're looking:

```map
 /config/
 lsd/    LSD theme
 vivid/    LS colors
 zsh/    ZSH core
 yazi/    Yazi theme
 zsh-patina/    Syntax theme (zsh) 
 zsh/04-func/lsdgum.zsh    Details for LSD

 /
 fonts/    Nerd fonts
 themes/    Topics you might like
 .zprofile/    Home screen (cat) 
```

## ZSH

In my [.zshrc](./.zshrc) file, I include a command to load [~/.config/zsh](./.config/zsh/), where I organize my ZSH functions; this makes them easier to locate and more convenient to copy.

`.config/zsh/01-eval.zsh`
Here is the commands **eval**

`.config/zsh/02-zplugins.zsh`
Here is everything related to **zsh plugins.**

`.config/zsh/03-export.zsh`
This is where I put the conventional **export** commands.

`.config/zsh/04-func/`
Here are the package **functions** such as: yazi, aria2.
