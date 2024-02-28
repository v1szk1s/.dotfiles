#!/bin/bash
DOTFILES=$(pwd)


setup_gitconfig(){
	title "Set up gitconfig"
	if [[ ! -f $HOME/.gitconfig ]]; then
		echo "Making symlink for gitconfig"
		ln -s $DOTFILES/gitconfig $HOME/.gitconfig
	else
		echo "Already exists... Skipping. "
	fi
}

setup_tmux(){
	title "Setup tpm"

	if [[ ! -e $DOTFILES/tmux.config/plugins/tpm ]]; then
		git clone https://github.com/tmux-plugins/tpm $DOTFILES/tmux.config/plugins/tpm
		success "Done"
	else
		echo "Already exists... Skipping. "
	fi

}



setup_lf(){
	title "setting up lf"

	echo "downloading latest release"
	if [[ $OSTYPE == 'darwin'* ]]; then
		url=$(curl -s https://api.github.com/repos/gokcehan/lf/releases/latest | grep "browser_download_url.*darwin-amd")
	else
		url=$(curl -s https://api.github.com/repos/gokcehan/lf/releases/latest | grep "browser_download_url.*linux-amd")
	fi

	url=$(echo $url | cut -d : -f 2,3 | tr -d '"' )
	target_dir=$HOME/.local/bin
	mkdir -p $target_dir
	wget $url -q -O $target_dir/lf.tar.gz

	cd $target_dir
	tar xf lf.tar.gz && rm lf.tar.gz

	echo "finished dowlnoading"
}

setup_symlinks() {
	# setup_tmux

	title "Setup symlinks"

	for i in $(find $DOTFILES -name '*.config'); do
		MAC="yabai|sketchybar|skhd"
		LINUX="i3|picom|polybar"
		BOTH="zsh|nvim|lf|tmux|kitty|alacritty"
		basename=$(basename "$DOTFILES/$i" '.config')

		target="$HOME/.config/$(basename "$DOTFILES/$i" '.config')"

		[[ $OSTYPE =~ darwin.* && "$i" =~ $LINUX || \
			! $OSTYPE =~ darwin.* && "$i" =~ $MAX ]] && continue



		if [[ ! -e $target ]]; then
			echo "Creating $basename symlink."
			ln -sf $i $target

            [[ "$i" =~ zsh ]] && echo ln -sf $i/zshenv $HOME/.zshenv
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

	echo -e
	success "Done."
