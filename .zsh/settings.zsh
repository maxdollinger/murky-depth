alias vim='nvim'
export EDITOR='nvim'

lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
alias lf='lfcd'

trash() {
    trash_dir="${HOME}/.trash"

   if [ ! -d "$trash_dir" ]; then
        mkdir "$trash_dir"
   fi

   timestamp=$(date +%s)
   for arg in "$@"; do
       name=$(basename "$arg")
       mv -fv "$arg" "${trash_dir}/${timestamp}_${name}"
   done
}

empty () {
    find . -name . -o -prune -exec rm -rf -- {} +
}


otmux () {
    [[ -z $TMUX ]] && (tmux attach || tmux) || echo ''
}

bindkey -s '^t' 'otmux\n'
bindkey -s '^e' 'lfcd\n'
bindkey -s '^o' 'nvim\n'
