command -v zsh >/dev/null 2>&1 || {
	echo >&2 "Zsh is not installed. Aborting."
	exit 1
}

if [ ! -d ~/.homesick ]; then
	echo "Installing Homeshick."
	git clone https://github.com/andsens/homeshick.git ~/.homesick/repos/homeshick
	source ~/.homesick/repos/homeshick/homeshick.sh
fi

if [ ! -d ~/.homesick/repos/prezto ]; then
	echo "Installing Prezto."
	homeshick clone -b sorin-ionescu/prezto
fi

if [ ! -d ~/.homesick/repos/homeshick-prezto ]; then
	echo "Installing wrappers for the default Prezto and Zsh configuration."
	homeshick clone -b mrmachine/homeshick-prezto
	# TODO: Backup existing files.
	homeshick link homeshick-prezto
	cp ~/.homesick/repos/homeshick-prezto/template/.z* ~
fi

if [ ! -d ~/.homesick/repos/dotfiles ]; then
	echo "Creating a dotfiles castle to manage user configuration."
	homeshick generate dotfiles
	homeshick track dotfiles ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc
fi

ZSH=`which zsh`

if [ $ZSH != $SHELL ]; then
	echo "Changing shell to Zsh."
	chsh -s $ZSH
fi

echo "Prezto and Zsh installed. Open a new terminal window or tab."
