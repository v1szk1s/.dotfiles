# Automatically start tmux on zsh startup
if command -v tmux >/dev/null 2>&1; then
  # Check if tmux is already running
  if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
  fi
fi

export TERM=tmux-256color


source <(fzf --zsh)

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


[ -f "$DOTFILES/zsh.config/aliases.zsh" ] && source "$DOTFILES/zsh.config/aliases.zsh" || echo "Could not source aliases"

[ -f "$DOTFILES/zsh.config/.variables.sh" ] && source "$DOTFILES/zsh.config/.variables.sh" || echo "Could not source .variables.sh\nSome script may not work!"

KEYTIMEOUT=1

LFCD="$DOTFILES/lf.config/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi


# Basic auto/tab complete:
source $DOTFILES/zsh.config/completion.zsh

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Keybinds


bindkey '^h' autosuggest-accept
zvm_bindkey viins '^R' fzf-history-widget
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# bindkey -s '^o' 'lfcd\n'
# bindkey -M vicmd '^o' 'lfcd\n'

lfcd-widget() {
  lfcd 
  zle reset-prompt  # Refresh the prompt immediately
}

lf-widget() {
  lfcd /run/media/v1szk1s/
  zle reset-prompt  # Refresh the prompt immediately
}

zle -N lfcd-widget
zle -N lf-widget

bindkey '^o' lfcd-widget
bindkey -M vicmd '^o' lfcd-widget

bindkey '^n' lf-widget
bindkey -M vicmd '^n' lf-widget


# zvm_bindkey viins '^o' fzf-history-widget
# bindkey -M vicmd '^R' fzf-history-widget

zvm_bindkey viins '^R' fzf-history-widget

WORDCHARS=${WORDCHARS/\/}
bindkey '^W' backward-kill-word


# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

# bindkey -v
# bindkey '^R' history-incremental-search-backward


# Load aliases and shortcuts if existent.

cdir () {
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}




export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"

export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"


# zprof

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh.config/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh.config/.p10k.zsh ]] || source ~/.dotfiles/zsh.config/.p10k.zsh


export GOPATH="$HOME/go"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/var/lib/snapd/snap/bin:$PATH"
export PATH="/opt/idea-IU-242.21829.142/bin:$PATH"
export PATH="/opt/GoLand-2024.2.1.1/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="/opt/RustRover-2024.3.3/bin:$PATH"
export _JAVA_AWT_WM_NONREPARENTING=1

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
