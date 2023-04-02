alias q="exit; tmux attach -t" 
alias cp="cp -iv" 
alias mv="mv -iv" 
alias rm="rm -vI" 
alias mkd="mkdir -pv" 


alias ll='exa -al --color=always --group-directories-first' # my preferred listing
alias l='exa -l --color=always --group-directories-first'  # all files and dirs
alias ls='exa --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -al --color=always --group-directories-first | grep "^\..*"'


alias grep="grep --color=auto" 
alias gs="git status" 
alias gl='git log --graph --all --format="%an %Cblue"%s'
alias gll="git log --all --graph --decorate" 
alias up="cd .." 
alias py="python3" 
alias python="python3" 
alias alias arm="env /usr/bin/arch -arm64 /bin/zsh" 
alias intel="env /usr/bin/arch -x86_64 /bin/zsh" 
alias sshtokabinet="ssh h142508@linux.inf.u-szeged.hu" 
alias studmount="sshfs h142508@linux.inf.u-szeged.hu:/home/h142508 /Users/hulu/stud" 
alias gepmount="sshfs v1szk1s@192.168.1.67:/home/v1szk1s /Users/hulu/v1szk1s" 
alias studumount="umount -f /Users/hulu/stud" 
alias gepumount="umount -f /Users/hulu/v1szk1s" 

alias vim="nvim"

alias ts="tmux new -s" 
alias lst="tmux list-sessions" 
alias ta="tmux attach -t" 


alias pmd="/Users/hulu/analysers/pmd-bin-6.54.0/bin/run.sh pmd"
alias spotbugs="java -jar /Users/hulu/analysers/spotbugs-4.7.3/lib/spotbugs.jar -textui"
alias sonarqube="/Users/hulu/analysers/sonarqube-9.8.0.63668/bin/macosx-universal-64/sonar.sh"
alias sonarscanner="/Users/hulu/analysers/sonar-scanner-4.7.0.2747-macosx/bin/sonar-scanner"
alias orania="ssh -f -N h142508@linux.inf.u-szeged.hu -L 9999:orania2.inf.u-szeged.hu:1521"

if [[ $OSTYPE == 'darwin'* ]]; then
    alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
    alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_361`; java -version"
    alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"
fi
