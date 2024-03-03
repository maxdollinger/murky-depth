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
    # Create .trash directory if it doesn't exist
   if [ ! -d "$trash_dir" ]; then
        mkdir "$trash_dir"
    fi
    # Get the current timestamp
    timestamp=$(date +%s)
    # Loop through each file argument
    for arg in "$@"; do
        # Check if the arg exists
        if [ -e "$arg" ]; then
            # Copy the arg to .Tras
            name=$(basename "$arg")
            cp -a "$arg" "${trash_dir}/${timestamp}_${name}" && rm -rf "$arg"
            # Remove the original arg
            echo "Moved $arg to Trash"
        else
            echo "$arg does not exist"
        fi
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
