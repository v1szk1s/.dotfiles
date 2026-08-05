if [[ $OSTYPE =~ darwin ]]; then

  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=/opt/homebrew/bin/:$PATH

  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use # This loads nvm
  alias node='unalias node ; unalias npm ; nvm use default ; node $@'
  alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'


  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi
