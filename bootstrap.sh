hash zsh 2>/dev/null || {
	echo >&2 "Zsh is not installed. Aborting."
	exit 1
}

if [ ! -d ~/.homesick/repos/homeshick ]; then
	echo "Installing Homeshick."
	git clone https://github.com/andsens/homeshick.git ~/.homesick/repos/homeshick
	source ~/.homesick/repos/homeshick/homeshick.sh
	homeshick link homeshick
fi

if [ ! -d ~/.homesick/repos/prezto ]; then
	echo "Installing Prezto."
	homeshick clone sorin-ionescu/prezto
fi

if [ ! -d ~/.homesick/repos/dotfiles ]; then
	echo "Creating a dotfiles castle to manage user configuration."
	homeshick generate dotfiles
fi

if [ ! -d ~/.homesick/repos/homeshick-prezto ]; then
	echo "Installing the default Prezto and Zsh configuration."
	homeshick clone mrmachine/homeshick-prezto
	cp -R ~/.homesick/repos/homeshick-prezto/template/ ~/.homesick/repos/dotfiles/home
	homeshick link dotfiles
fi

ZSH=`which zsh`

if [ $ZSH != $SHELL ]; then
	echo "Changing shell to Zsh."
	chsh -s $ZSH
fi

echo "Prezto and Zsh installed. Open a new terminal window or tab, then add a"
echo "remote origin for your dotfiles castle and push an initial commit."
