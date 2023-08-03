alias vim='nvim'

export EDITOR='nvim'

export PATH="$HOME/go/bin:$PATH"
export PATH="/Users/maximiliandollinger/bin:/Users/maximiliandollinger/.local/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"

eval "$(tmuxifier init -)"

[ -f "/Users/maximiliandollinger/.ghcup/env" ] && source "/Users/maximiliandollinger/.ghcup/env" # ghcup-env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

fzfcd () {
    cd $(find . -type d 2>/dev/null | fzf --reverse) 
}

alias lf='lfcd'
bindkey -s '^e' 'lfcd\n'
bindkey -s '^f' 'fzfcd\n'
bindkey -s '^o' 'nvim .\n'

