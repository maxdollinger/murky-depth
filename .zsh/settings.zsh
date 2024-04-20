alias vim='nvim'
alias vi='nvim'
export EDITOR='nvim'

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
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

hist() {
	if [[ "$1" == "-c" ]]; then
		echo "clear history"
        history -p
        clear 
		truncate -s 0 ~/.histfile
	elif [[ "$1" == "-e" ]]; then
        shift
        rest="$@"
		cmd="$( fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' | fzf --height=15 --no-sort -q "$rest" | awk '{print $1}')"
		[[ ! -z "$cmd" ]] && fc "$cmd"
    else
		cmd="$( fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' | fzf --height=15 --no-sort -q "$*" | awk '{print $1}')"
		[[ ! -z "$cmd" ]] && fc -s "$cmd"
	fi
}

rr() {
	clear && exec zsh
}

bindkey -s '^e' 'lfcd\n'
bindkey -s '^o' 'nvim\n'
