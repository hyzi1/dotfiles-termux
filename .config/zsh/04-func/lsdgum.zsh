# I use the 'i1'+'i2' alias by my keyboard layout. Just change the aliases to lsd.

#ls -l
i2() {
    local dir=${PWD/#"$HOME"}
    if [[ $dir != "$PWD" ]]; then dir="~$dir"; fi

    # >> Only PWD
    #local header="\033[1;35m$dir\033[0m"
    # <<

    # >> PWD and date
    local header="\033[1;31m $(date '+%d-%m-%y/%H:%M:%S')\033[0m\n\033[1;35m$dir\033[0m"
    # <<

    local box_width=$((COLUMNS - 4))
    local out

    out=$(script -q -c "lsd -l --color=always --icon=always --blocks name,size,date --date '+%d-%m-%y/%H:%M:%S' --total-size $*" /dev/null | tr -d '\r' | sed -E $'s/([0-9])(\x1b\\[[0-9;]*m)* (\x1b\\[[0-9;]*m)*([KMGT]B)/\\1\\2\\3\\4/g')

    if [[ -n "$out" ]]; then
        printf '%b\n\n%s' "$header" "$out" | gum style --border rounded --padding "1 2" --width "$box_width" --no-strip-ansi
    fi
}

# ls -1 (normal)
# Look! Instead of using `lsd -1` (which shows just one line), you can use `lsd -X` or `lsd -a`; however, you have to zoom out so it doesn't look too cramped.
i1() {
    local dir=${PWD/#"$HOME"}
    if [[ $dir != "$PWD" ]]; then dir="~$dir"; fi

    # >> Only PWD
    #local header="\033[1;35m$dir\033[0m"
    # <<

    # >> PWD and date
    local header="\033[1;31m $(date '+%d-%m-%y/%H:%M:%S')\033[0m\n\033[1;35m$dir\033[0m"
    # <<

    local box_width=$((COLUMNS - 4))
    local out

    out=$(script -q -c "lsd -1 --color=always --icon=always $*" /dev/null | tr -d '\r')

    if [[ -n "$out" ]]; then
        printf '%b\n\n%s' "$header" "$out" | gum style --border rounded --padding "1 2" --width "$box_width" --no-strip-ansi
    fi
}
