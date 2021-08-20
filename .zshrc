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

eval "$(starship init zsh)"
