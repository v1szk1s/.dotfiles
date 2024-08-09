# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

bindkey '^h' autosuggest-accept

# the following options are from https://github.com/Phantas0s
# 
# +------------+
# | NAVIGATION |
# +------------+
# zmodload zsh/zprof

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.


# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

setopt PROMPT_SUBST

source $DOTFILES/zsh.config/plugins/bd.zsh
# source $DOTFILES/zsh.config/plugins/powerlevel10k/powerlevel10k.zsh-theme

# Enable colors and change prompt:
autoload -U colors && colors


[ -f "$DOTFILES/zsh.config/aliases.zsh" ] && source "$DOTFILES/zsh.config/aliases.zsh"

# Load version control information
# autoload -Uz vcs_info
#
# Remove mode switching delay.
KEYTIMEOUT=1

# Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# _fix_cursor() {
#    echo -ne '\e[5 q'
# }
#
# precmd_functions+=(_fix_cursor)
# precmd() {
#     vcs_info && print ""
# }
# # Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '[%b]'
#
# PROMPT='$(tput setaf 13)%n$(tput setaf 15)@$(tput setaf 220)%m $(tput setaf 14)%~%{$fg[red]%}%{$reset_color%} %F{green}${vcs_info_msg_0_}%F{white}
# %(?.%F{green}.%F{red})$%f '



# Basic auto/tab complete:
source $DOTFILES/zsh.config/completion.zsh

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# bindkey -v
bindkey '^R' history-incremental-search-backward


# Load aliases and shortcuts if existent.

cdir () {
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

LFCD="$DOTFILES/lf.config/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

bindkey -s '^o' 'lfcd\n'


export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"

# zprof

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh.config/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh.config/.p10k.zsh ]] || source ~/.dotfiles/zsh.config/.p10k.zsh

[ -f $DOTFILES/zsh.config/.fzf.zsh ] && source $DOTFILES/zsh.config/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
