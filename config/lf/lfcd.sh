lfcd () {
    emulate -L zsh
    setopt localoptions no_aliases   # prevent alias expansion inside this function

    local tmp dir
    tmp="$(mktemp -t lfcd.XXXXXX)" || return

    command lfrun -last-dir-path="$tmp" "$@"

    if [[ -f $tmp ]]; then
        dir="$(<"$tmp")"
        \rm -f -- "$tmp" >/dev/null 2>&1   # use backslash to bypass any alias and stay quiet
        if [[ -d $dir && $dir != $PWD ]]; then
            cd -- "$dir"
        fi
    fi

    if [[ -n $ZLE ]]; then
        zle -I
        zle -R            # generic redisplay
        zle reset-prompt       zle reset-prompt
    fi
}
