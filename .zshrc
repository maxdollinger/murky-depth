# neofetch

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
unsetopt autocd notify
bindkey -v


alias vim='nvim'
export EDITOR='nvim'

export PATH="$PATH:/usr/share"

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

#ZPlug
source ~/.zplug/init.zsh

zplug "catppuccin/zsh-syntax-highlighting"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Attach to tmux on startup
if [ -z $TMUX ]; then
    tmux attach || tmux
fi
