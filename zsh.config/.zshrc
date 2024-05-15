# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

source $DOTFILES/zsh.config/plugins/powerlevel10k/powerlevel10k.zsh-theme

# Enable colors and change prompt:
autoload -U colors && colors


[ -f "$DOTFILES/zsh.config/aliases.zsh" ] && source "$DOTFILES/zsh.config/aliases.zsh"

# Load version control information
# autoload -Uz vcs_info
#
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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# zprof
