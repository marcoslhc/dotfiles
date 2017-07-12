export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/marcoslh/.sdkman"
[[ -s "/Users/marcoslh/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/marcoslh/.sdkman/bin/sdkman-init.sh"
