#! /usr/bin/bash
# Edit package-manager cmd on other systems
pkgs="zsh neofetch lf fzf tmux neovim lazygit"

delim="----------------------------------"

echo "1. installing packages"
echo $delim
for i in $pkgs; do
    zypper se -xs $i
    read -p "install $i? [y/n] " sin
    if [ $sin != "y" ]; then
        echo "skipping install of $i"
        echo $delim
        continue
    fi
    zypper in $i
    echo $delim
done
