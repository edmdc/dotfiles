export ZSH="/Users/edmdc/.oh-my-zsh"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# User configuration
alias e='nvim'
alias cat='bat'
alias dots='cd ~/.dotfiles'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tkill='tmux kill-server'
alias tkiss='tmux kill-session -t'
alias ls='exa -la'
alias py3='python3'
alias nd='npm run dev'
alias yd='yarn dev'
alias cl='clear'

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
