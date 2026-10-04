# Git
alias g='git'
alias ga='git add .'
alias gaa='git add --all'
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gcm='git commit -m'
alias gs='git status'
alias gp='git push'
alias gpf='git push -f origin main'
alias gpl='git pull'
alias gl='git log -2'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='git restore .'
alias grs='git restore --staged .'
alias gcd='cd "$(git rev-parse --show-toplevel 2>/dev/null)"'

# Kubernetes and infrastructure
alias k='kubectl'
alias kgp='kubectl get pods'
alias kl='kubectl logs'
alias kdp='kubectl describe pod'
alias kdn='kubectl describe node'
alias kgn='kubectl get nodes'
alias kx='kubectl exec -it'
alias ks='k9s'
alias tf='terraform'

# Navigation and common utilities
alias cw='cd "$HOME/workspace"'
alias dl='cd "$HOME/Downloads"'
alias df='df -h'
alias free='free -m'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias grep='grep --color=auto'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lag --header'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa -lag --header'
fi

if command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias cat='batcat'
elif command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi
