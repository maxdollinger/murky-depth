#! /bin/sh

delim="----------------------------------"

read -p "Install apps? [y/n] " sin
if [ $sin == "y" ]; then
	if [ -n "$(command -v brew)" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo $delim
	fi

	source ~/.zshrc 2>/dev/null

	brew bundle --file ~/murky-depth/Brewfile

	if [ "${OSTYPE}" == "darwin"* ]; then
		echo "alias sed='gsed'" >>~.zshrc
	fi

	echo "eval \"$(zoxide init zsh --cmd cd)\"" >>~.zshrc

fi
echo $delim

read -p "Install FiraCode NerdFont? [y/n] " sin
if [ $sin == "y" ]; then
	dir="$HOME/Library/Fonts"
	curl --output-dir "$dir" -O -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
	unzip "$dir/FiraCode.zip" -d "$dir/FiraCode"
	rm -rf "$dir/FiraCode.zip"
fi
echo $delim

read -p "Update dot-files? [y/n] " sin
if [ $sin == "y" ]; then
	if [ -d ~/murky-depth/ ]; then
		git -C ~/murky-depth/ fetch
		git -C ~/murky-depth/ pull
	else
		git -C https://github.com/maxdollinger/murky-depth.git ~/murky-depth
	fi

	cp -R ~/murky-depth/.configs ~/
	cp -R ~/murky-depth/.ssh ~/
	cp -R ~/murky-depth/.zsh ~/
	cp -a ~/murky-depth/.wezterm.lua ~/
	cp -a ~/murky-depth/.gitconfig ~/

	echo "source ~/.zsh/settings.zsh" >>~/.zshrc
fi
echo $delim

read -p "Setup zsh? [y/n] " sin
if [ $sin == "y" ]; then

	[[ ! -d ~/.zsh/plugins ]] && mkdir -p ~/.zsh/plugins

	if [ -d ~/.zsh/plugins/powerlevel10k ]; then
		echo "update powerlevel10k"
		git -C ~/.zsh/plugins/powerlevel10k fetch
		git -C ~/.zsh/plugins/powerlevel10k pull
	else
		echo "installing powerlevel10k"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k
		echo 'source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
		echo '[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh' >>~/.zshrc
	fi

	if [ -d ~/.zsh/plugins/zsh-syntax-highlighting ]; then
		echo "update zsh-syntax-highlighting"
		git -C ~/.zsh/plugins/zsh-syntax-highlighting fetch
		git -C ~/.zsh/plugins/zsh-syntax-highlighting pull
	else
		echo "installing syntax-highlighting"
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
		echo 'source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>~/.zshrc
	fi
fi
echo $delim

if [ -z "$(command -v nvm)" ]; then
	read -p "Install nvm and node? [y/n] " sin
	if [ $sin == "y" ]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
		source ~/.zshrc 2>/dev/null
		nvm install --lts
		read -p "Install Typescript globaly? [y/n] " sin
		if [ $sin == "y" ]; then
			npm install -g typescript @types/node ts-node
		fi
	fi
	echo $delim
fi

if [ -n "$(command -v ghcup)" ]; then
	read -p "Install Haskell? [y/n] " sin
	if [ $sin == "y" ]; then
		curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
	fi
	echo $delim
fi
