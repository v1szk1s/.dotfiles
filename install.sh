#!/bin/bash
DOTFILES=$(pwd)
FORCE=false

# Parse args
while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--force)
      FORCE=true
      shift
      ;;
    *)
      shift
      ;;
  esac
done

setup_gitconfig(){
	if [[ ! -f $HOME/.gitconfig || $FORCE == true ]]; then
		echo "Linking gitconfig"
		ln -sf $DOTFILES/gitconfig $HOME/.gitconfig
	else
		echo "Already exists... Skipping."
	fi
}

setup_tmux(){
	if [[ ! -e $DOTFILES/tmux.config/plugins/tpm || $FORCE == true ]]; then
		if [[ -d $DOTFILES/tmux.config/plugins/tpm ]]; then
			rm -rf $DOTFILES/tmux.config/plugins/tpm
		fi
		git clone https://github.com/tmux-plugins/tpm $DOTFILES/tmux.config/plugins/tpm
		echo "tmux plugins installed."
	else
		echo "Already exists... Skipping."
	fi
}

setup_symlinks() {
	for i in $(find "$DOTFILES" -maxdepth 1 -name '*.config'); do
		basename=$(basename "$i" '.config')
		target="$HOME/.config/$basename"

		if [[ ! -e $target || $FORCE == true ]]; then
			echo "Creating $basename symlink."
			ln -sfn "$i" "$target"
			[[ "$basename" == "zsh" ]] && ln -sfn "$i/zshenv" "$HOME/.zshenv"
		else
			echo "Already exists... Skipping."
		fi
	done
}

setup_gitconfig
setup_tmux
setup_symlinks

echo -e "Done"
