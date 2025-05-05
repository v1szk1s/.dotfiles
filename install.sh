#!/bin/bash
DOTFILES=$(pwd)

setup_gitconfig(){
	if [[ ! -f $HOME/.gitconfig ]]; then
		echo "Making symlink for gitconfig"
		ln -s $DOTFILES/gitconfig $HOME/.gitconfig
	else
		echo "Already exists... Skipping. "
	fi
}

setup_tmux(){

	if [[ ! -e $DOTFILES/tmux.config/plugins/tpm ]]; then
		git clone https://github.com/tmux-plugins/tpm $DOTFILES/tmux.config/plugins/tpm
		success "Done"
	else
		echo "Already exists... Skipping. "
	fi

}

setup_symlinks() {
	for i in $(find $DOTFILES -maxdepth 1 -name '*.config'); do
		basename=$(basename "$DOTFILES/$i" '.config')

		target="$HOME/.config/$(basename "$DOTFILES/$i" '.config')"

		if [[ ! -e $target ]]; then
			echo "Creating $basename symlink."
			ln -sf $i $target

			[[ "$i" =~ zsh ]] && echo "ln -sf $i/zshenv $HOME/.zshenv"
		else
			echo "Already exists... Skipping. "
		fi
	done
}

setup_symlinks


# POSITIONAL_ARGS=()
#
# while [[ $# -gt 0 ]]; do
#   case $1 in
#     -e|--extension)
#       EXTENSION="$2"
#       shift # past argument
#       shift # past value
#       ;;
#     -s|--searchpath)
	#       SEARCHPATH="$2"
	#       shift # past argument
	#       shift # past value
	#       ;;
#     --default)
	#       DEFAULT=YES
	#       shift # past argument
	#       ;;
#     -*|--*)
	#       echo "Unknown option $1"
	#       exit 1
	#       ;;
#     *)
	#       POSITIONAL_ARGS+=("$1") # save positional arg
	#       shift # past argument
	#       ;;
	#   esac
	# done
	#
	# set -- "${POSITIONAL_ARGS[@]}"

	echo -e "Done"
