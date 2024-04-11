alias q="exit; tmux attach -t"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv"

alias ggc='gcloud compute ssh --zone "europe-central2-a" "instance-20240322-103402" --project "sincere-blade-416610"'

if command -v exa >/dev/null; then
    alias ll='exa -al --color=always --group-directories-first' # my preferred listing
    alias l='exa -l --color=always --group-directories-first'  # all files and dirs
    alias ls='exa --color=always --group-directories-first'  # long format
    alias lt='exa -aT --color=always --group-directories-first' # tree listing
    alias l.='exa -al --color=always --group-directories-first | grep "^\..*"'
else
    alias ll='ls -al --color=auto'
    alias l='ls -l --color=auto'
    alias ls='ls --color=auto'
    alias lt='ls -aT --color=auto'
fi


alias grep="grep --color=auto"
alias gs="git status"
alias gl='git log --graph --all' #--format="%an %Cblue"%s'
alias gll="git log --all --graph --decorate"

if command -v python3 >/dev/null; then
    alias py="python3"
    alias python="python3"
fi

if command -v nvim >/dev/null; then
    alias vim="nvim"
fi

alias ts="tmux new -s"
alias lst="tmux list-sessions"
alias ta="tmux attach -t"

if [[ $OSTYPE =~ darwin ]]; then
    alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 20`; java -version"
    alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
    alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
    alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_361`; java -version"
    alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"
fi

