#! /bin/sh

delim="----------------------------------"

read -p "Install packages? [y/n] " sin
if [ $sin == "y" ]; then
    pkgs="kitty lf lazygit fzf tmux neovim jq"
    for i in $pkgs; do
        [[ -n "$(command -v $i)" ]] && continue 
        
        sudo brew install $i
    done
fi
echo $delim

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
    read -p "Setup zsh? [y/n] " sin
    if [ $sin == "y" ]; then
    
        sudo chsh -s $(which zsh) $USER

        [[ ! -d ~/.zsh/plugins ]] && mkdir -p ~/.zsh/plugins
        
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
    fi
    echo $delim
fi

if [ -z "$(command -v nvm)" ]; then
    read -p "Install node and nvm? [y/n] " sin
    if [ $sin == "y" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
        source ~/.zshrc 2> /dev/null
        nvm install node
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

if [ -n "$(command -v zsh)" ]; then
    read -p "Install Haskell? [y/n] " sin
    if [ $sin == "y" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    fi
    echo $delim
fi
