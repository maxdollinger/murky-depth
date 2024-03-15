alias vim='nvim'
alias vi='nvim'
export EDITOR='nvim'

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt EXTENDED_HISTORY # record command start time
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

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

hist () {
    eval fc -s $(fc -l | fzf | awk '{print $1}')
}

bindkey -s '^e' 'lfcd\n'
bindkey -s '^o' 'nvim\n'
