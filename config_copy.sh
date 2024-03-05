#! /bin/sh

cp -av "${HOME}/.config/nvim" "${HOME}/murky-depth/.config/"
cp -av "${HOME}/.config/lf" "${HOME}/murky-depth/.config/"
cp -av "${HOME}/.config/tmux/tmux.conf" "${HOME}/murky-depth/.config/tmux"
cp -av "${HOME}/.zsh/settings.zsh" "${HOME}/murky-depth/.config/"
cp -av "${HOME}/.ssh/config" "${HOME}/murky-depth/.ssh/"
cp -av "${HOME}/.wezterm.lua" "${HOME}/murky-depth/"
cp -av "${HOME}/.gitconfig" "${HOME}/murky-depth/"

gsed -i 's/name = "[^"]*"/name = "_"/g' "${HOME}/murky-depth/.gitconfig"
gsed -i 's/email = "[^"]*"/email = "_"/g' "${HOME}/murky-depth/.gitconfig"
