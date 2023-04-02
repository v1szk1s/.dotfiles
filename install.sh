#!/bin/bash
DOTFILES=$(pwd)
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
    echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
    echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
    exit 1
}

warning() {
    echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
    echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

get_linkables() {
    find -H "$DOTFILES" -maxdepth 3 -name '*.symlink'
}


setup_zsh(){
	title "Setup zsh"

    mkdir -p ~/.config/zsh
    for i in $(find $DOTFILES/zsh -name '*.symlink' | xargs basename ); do
        target="$HOME/.config/zsh/.$(basename "$DOTFILES/zsh/$i" '.symlink')"
        if [[ ! -f $target ]]; then
            info "Making symlink for $i"
            ln -s $DOTFILES/zsh/$i $target
        else
            info "$i Already exists... Skipping. "
        fi
    done

}

setup_gitconfig(){
    title "Set up gitconfig"
    if [[ ! -f $HOME/.gitconfig ]]; then
        info "Making symlink for gitconfig"
        ln -s $DOTFILES/gitconfig $HOME/.gitconfig
    else
        info "Already exists... Skipping. "
    fi
}

setup_packer(){
    title "Setup Packer for nvim"

    if [[ ! -e  $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
        git clone --depth 1 https://github.com/wbthomason/packer.nvim \
            $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
        success "Done"
    else
        info "Already exists... Skipping. "
    fi
}


setup_symlinks() {
    setup_zsh
    setup_gitconfig
    setup_packer

    title "Setup remaning"
    configs_to_links=$(find $DOTFILES -name '*.config')

    for i in $(find $DOTFILES -name '*.config'); do
        target="$HOME/.config/$(basename "$DOTFILES/$i" '.config')"
        if [[ ! -e $target ]]; then
            info "Creatng $target symlink."
            ln -s $i $target
        else
            info "Already exists... Skipping. "
        fi
    done
}

setup_symlinks

#case "$1" in
#		link)
#			setup_symlinks
#			;;
#        proba)
#            setup_zsh
#            #for i in ${configs_to_links[@]}; do
#                #echo $i
#            #done
#            ;;
#		*)
#			echo -e $"\nUsage: $(basename "$0") {link}\n"
#			exit 1
#			;;
#esac

echo -e
success "Done."
