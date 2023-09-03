#! /usr/bin/bash

delim="----------------------------------"

read -p "Install packages? [y/n] " sin
if [ $sin == "y" ]; then
    pkgs="zsh lf fzf tmux neovim lazygit"
    sudo zypper refresh
    for i in $pkgs; do
        [[ -n "$(command -v $i)" ]] && continue 

        zypper se -xs $i
        read -p "install $i? [y/n] " sin
        if [ $sin != "y" ]; then
            echo "skipping install of $i"
            echo $delim
            continue
        fi
        sudo zypper in $i
        echo $delim
    done
fi
echo $delim

read -p "Download and install dot-files? [y/n] " sin
if [ $sin == "y" ]; then
    mv -f ./murky-depth/config/{.,}* ~/.config/
    mv -f ./murky-depth/.zsh/{.,}* ~/.zsh/
    mv -f ./murky-depth/.zshrc ~/
    echo "source ~/.zsh/settings.zsh" >> ~/.zshrc
    rm -rf murky-depth
    source ~/.zshrc
fi
echo $delim

if [ -n "$(command -v zsh)" ]; then
    read -p "Install zsh plugins? [y/n] " sin
    if [ $sin == "y" ]; then
        echo "installing powerlevel10k"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k
        echo 'source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
        echo '[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh' >> ~/.zshrc

        git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ~/.zsh/plugins/catppuccin
        echo 'source ~/.zsh/plugins/catppuccin/themes/catppuccin_frappe-zsh-syntax-highlighting.zsh' >>~/.zshrc

        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
        echo 'source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

        echo  "[[ -z \$TMUX ]] && (tmux attach || tmux)" >> ~/.zshrc
    fi
    echo $delim
fi

if [ -z "$(command -v nvm)" ]; then
    read -p "Install NodeVersionManager nvm? [y/n] " sin
    if [ $sin == "y" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
        source ~/.zshrc
        read -p "Install Typescript globaly? [y/n] " sin
        if [ $sin == "y" ]; then
            npm install -g typescript
        fi
    fi
echo $delim
fi

if [ -z "$(command -v go)" ]; then
    read -p "Install go? [y/n] " sin
    if [ $sin == "y" ]; then
        cd ~/Downloads
        sudo rm -rf /usr/local/go
        curl -o- https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz | sudo tar -C /usr/local -xz 
        echo "export PATH=\$PATH:/usr/local/go/bin" >> $HOME/.zshrc
        source ~/.zshrc
        go version
    fi
    echo $delim
fi

read -p "Install gnome extentions? [y/n] " sin
if [ $sin == "y" ]; then
   path="~/.local/share/gnome-shell/extensions" 
   git clone https://github.com/CZ-NIC/run-or-raise.git "$path/run-or-raise@edvard.cz"
   git clone https://github.com/corecoding/Vitals "$path/Vitals@CoreCoding.com"
   git clone https://github.com/b00f/gnome-clipboard "$path/gnome-clipboard@b00f.github.io"
   git clone https://github.com/aunetx/gnome-shell-extension-blur-my-shell "$path/blur-my-shell@aunetx"
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
