# export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH

# Enable colors and change prompt:
autoload -U colors && colors


# # Load version control information
autoload -Uz vcs_info

precmd() {
    vcs_info && print ""
}

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

RPROMPT='%F{green}${vcs_info_msg_0_}%F{white}'

PROMPT='$(tput setaf 13)%n$(tput setaf 15)@$(tput setaf 220)%m $(tput setaf 14)%~%{$fg[red]%}%{$reset_color%}
%(?.%F{green}.%F{red})$%f '



# History in cache directory:
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# setopt appendhistory

# Fixing zsh history problems on multiple terminals
setopt inc_append_history
setopt share_history

# Ignore duplicate commands in history file
setopt histignorealldups



# Fixing some keys inside zsh
autoload -Uz select-word-style
select-word-style bash

CASE_SENSITIVE="false"

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' gain-privileges 1

# LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:*=00;31'
LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.



# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# enable backward search
# bindkey "^R" history-incremental-pattern-search-backward
bindkey -s '^R' 'cat ~/.config/zsh/.zsh_history | fzf\n'


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$DOTFILES/zsh.config/aliases.zsh" ] && source "$DOTFILES/zsh.config/aliases.zsh"
[ -f "$DOTFILES/zsh.config/antigen.zsh" ] && source "$DOTFILES/zsh.config/antigen.zsh"

antigen bundle jeffreytse/zsh-vi-mode

antigen apply

cdir ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

LFCD="$DOTFILES/lf.config/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

bindkey -s '^o' 'lfcd\n'

# stole from here: https://github.com/Tarrasch/zsh-bd/blob/master/bd.zsh
# didn't want to install another plugin for this
bd () {
  (($#<1)) && {
    print -- "usage: $0 <name-of-any-parent-directory>"
    print -- "       $0 <number-of-folders>"
    return 1
  } >&2
  # example:
  #   $PWD == /home/arash/abc ==> $num_folders_we_are_in == 3
  local num_folders_we_are_in=${#${(ps:/:)${PWD}}}
  local dest="./"

  # First try to find a folder with matching name (could potentially be a number)
  # Get parents (in reverse order)
  local parents
  local i
  for i in {$num_folders_we_are_in..2}
  do
    parents=($parents "$(echo $PWD | cut -d'/' -f$i)")
  done
  parents=($parents "/")
  # Build dest and 'cd' to it
  local parent
  foreach parent (${parents})
  do
    dest+="../"
    if [[ $1 == $parent ]]
    then
      cd $dest
      return 0
    fi
  done

  # If the user provided an integer, go up as many times as asked
  dest="./"
  if [[ "$1" = <-> ]]
  then
    if [[ $1 -gt $num_folders_we_are_in ]]
    then
      print -- "bd: Error: Can not go up $1 times (not enough parent directories)"
      return 1
    fi
    for i in {1..$1}
    do
      dest+="../"
    done
    cd $dest
    return 0
  fi

  # If the above methods fail
  print -- "bd: Error: No parent directory named '$1'"
  return 1
}
_bd () {
  # Get parents (in reverse order)
  local num_folders_we_are_in=${#${(ps:/:)${PWD}}}
  local i
  for i in {$num_folders_we_are_in..2}
  do
    reply=($reply "`echo $PWD | cut -d'/' -f$i`")
  done
  reply=($reply "/")
}
compctl -V directories -K _bd bd

if [[ $OSTYPE == 'darwin'* ]]; then
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
