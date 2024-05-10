if [[ $OSTYPE =~ darwin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export SCALA_HOME=/opt/homebrew/bin/scala
    export JAVA_HOME=`/usr/libexec/java_home -v 17`
    export PATH=/opt/homebrew/bin/:$PATH
fi

# [ -f $DOTFILES/zsh.config/variables.zsh ] && source $DOTFILES/zsh/variables.zsh


