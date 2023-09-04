#! /usr/bin/bash

delim="----------------------------------"

read -p "Install packages? [y/n] " sin
if [ $sin == "y" ]; then
    pkgs="zsh kitty lf fzf tmux neovim lazygit jq"
    for i in $pkgs; do
        [[ -n "$(command -v $i)" ]] && continue 
        
        sudo pacman -S $i
        echo $delim
    done
fi
echo $delim

if [ -n "$(command -v zsh)" ]; then
    read -p ¨Make zsh default? [y/n]" sin
    [[ $sin == "y" ]] && chsh -s $(`which zsh`) $USER
fi
        

read -p "Download and install dot-files? [y/n] " sin
if [ $sin == "y" ]; then
    git clone https://github.com/maxdollinger/murky-depth.git ~/murky-depth
    cp -ar ~/murky-depth/configs/* ~/.config/
    chmod +x ~/.config/tmux/plugins/catppuccin/catppuccin.tmux
    cp -ar ~/murky-depth/.zsh/ ~/
    cp -a  ~/murky-depth/.zshrc ~/
    rm -rf ~/murky-depth
    echo "source ~/.zsh/settings.zsh" >> ~/.zshrc
fi
echo $delim

if [ -n "$(command -v zsh)" ]; then
    read -p "Install zsh plugins? [y/n] " sin
    if [ $sin == "y" ]; then

        if [ -d ~/.zsh/plugins/powerlevel10k ]; then
            echo "update powerlevel10k"
            git -C ~/.zsh/plugins/powerlevel10k fetch
            git -C ~/.zsh/plugins/powerlevel10k pull
        else
            echo "installing powerlevel10k"
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k
            echo 'source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
            echo '[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh' >> ~/.zshrc
        fi

        if [ -d ~/.zsh/plugins/catppuccin ]; then
            echo "update catppuccin"
            git -C ~/.zsh/plugins/catppuccin fetch
            git -C ~/.zsh/plugins/catppuccin pull
        else
            echo "installing catppuccin"
            git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ~/.zsh/plugins/catppuccin
            echo 'source ~/.zsh/plugins/catppuccin/themes/catppuccin_frappe-zsh-syntax-highlighting.zsh' >>~/.zshrc
        fi

        if [ -d ~/.zsh/plugins/zsh-syntax-highlighting ]; then
            echo "update zsh-syntax-highlighting"
            git -C ~/.zsh/plugins/zsh-syntax-highlighting fetch
            git -C ~/.zsh/plugins/zsh-syntax-highlighting pull
        else
            echo "installing syntax-highlighting"
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
            echo 'source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
        fi

        if [ -n "$(command -v tmux)" ]; then
            [[ -z "$(cat ~/.zshrc | grep 'tmux attach')" ]] && echo  "[[ -z \$TMUX ]] && (tmux attach || tmux) || echo ''" >> ~/.zshrc
        fi
    fi
    echo $delim
fi

read -p "Install gnome extentions? [y/n] " sin
if [ $sin == "y" ]; then
    ext="run-or-raise@edvard.cz Vitals@CoreCoding.com gnome-clipboard@b00f.github.io blur-my-shell@aunetx"

    for i in $ext; do
        vs=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[0].shell_version_map | map(.version) | max')
        name="$(echo $i | sed 's/@//')"
        url="https://extensions.gnome.org/extension-data/${name}.v${vs}.shell-extension.zip"
        curl $url --output "${i}.zip"
        gnome-extensions install --force "${i}.zip"
        gnome-extensions enable ${i}
        rm "${i}.zip"
    done
fi
echo $delim

if [ -z "$(command -v nvm)" ]; then
    read -p "Install NodeVersionManager nvm? [y/n] " sin
    if [ $sin == "y" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
        source ~/.zshrc 2> /dev/null
        read -p "Install Typescript globaly? [y/n] " sin
        if [ $sin == "y" ]; then
            npm install -g typescript
        fi
    fi
echo $delim
fi

read -p "Install or update go? [y/n] " sin
if [ $sin == "y" ]; then
    sudo rm -rf /usr/local/go
    curl -o- https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz | sudo tar -C /usr/local -xz 
    echo "export PATH=\$PATH:/usr/local/go/bin" >> $HOME/.zshrc
    source ~/.zshrc 2> /dev/null
    go version
fi
echo $delim


read -p "Apply gnome settings? [y/n] " sin
echo $delim
if [ $sin == "y" ]; then
    gsettings org.gnome.mutter dynamic-workspaces False
    gsettings org.gnome.desktop.wm.preferences num-workspaces 6
    ks="1 2 3 4 5 6"
    for i in $ks; do
        gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$i" "['<Alt>$i']"
        gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$i" "['<Alt>$i']"
    done

    gsettings org.gnome.desktop.wm.keybindings close "['<Alt>q']"
    gsettings org.gnome.desktop.wm.keybindings toggle-maximized "['<Alt>m']"

    gsettings org.gnome.mutter.keybindings toggle-tiled-left "['<Alt>h']"
    gsettings org.gnome.mutter.keybindings toggle-tiled-right "['<Alt>l']"

    gsettings org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
fi