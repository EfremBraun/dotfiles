_is_mac=$(uname -s | grep Darwin)

# Laptop specific
if [[ -n "$_is_mac" ]]; then
    alias vi='/usr/bin/vim'
fi

# Terminal colors
export CLICOLOR=1
export TERM=xterm-color
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Command prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
 }      
PS1="\[\033[32m\]\$(parse_git_branch)[\[\033[0;32m\]\h:\W]$ \[\033[0m\]"

# git aliases (mostly from oh-my-bash)
alias ga='command git add'
alias gaa='command git add --all'
alias gapa='command git add --patch'
alias gau='command git add --update'
alias gb='command git branch'
alias gco='command git checkout'
alias gc='command git commit --verbose'
alias gc!='command git commit --verbose --amend'
alias gd='command git diff'
alias gds='command git diff --staged'
alias glg='command git lg'
alias gl='command git pull'
alias gp='command git push'
alias grm='command git rm'
alias gsh='command git show'
alias gst='command git status'

# bash history settings
export HISTIGNORE='pwd:ls'
shopt -s histappend
export HISTSIZE=10000
