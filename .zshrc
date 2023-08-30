neofetch

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
unsetopt autocd notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/max/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias vim='nvim'

export EDITOR='nvim'
export PATH="/usr/share:$PATH"

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

export s2B () {
[ -z "$(ps -aux | pgrep firefox)" ] && (MESA_DEBUG=silent firefox&) || wmctrl -a firefox
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
