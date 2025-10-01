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

setup_tmux(){
	if [[ ! -e ~/.tmux/plugins/tpm/tpm || $FORCE == true ]]; then
		if [[ -d ~/.tmux/plugins/tpm/tpm ]]; then
			rm -rf ~/.tmux/plugins/tpm/tpm
		fi
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		echo "tmux plugins installed."
	else
		echo "Already exists... Skipping."
	fi
}

setup_symlinks() {
	for i in $(find "$DOTFILES/config" -maxdepth 1); do
		basename=$(basename "$i")
		target="$HOME/.config/$basename"

		if [[ ! -e $target || $FORCE == true ]]; then
			echo "Creating $basename symlink."
			echo "ln -sfn $i $target"
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
